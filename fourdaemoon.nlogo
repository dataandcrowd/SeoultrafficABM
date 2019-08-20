extensions [gis csv table]
globals [pollution-data area roads dilute car-limit-number no2-stat]
breed [nodes node]
breed [area-labels area-label]
breed [cars car]
nodes-own [name line-start line-end auto? green-light? intersection?]
links-own [road-name is-road? max-spd Daero?]
cars-own  [to-node cur-link speed class fueltype ]
patches-own [is-research-area? intersection countdown dong-code no2_road road_buffer]




to setup
  ca
  set-gis
  add-labels
  activate-links
  set-signals
  set-cars
  set car-limit-number no-of-cars * 1.5
  ask cars [ifelse class <= 2 [set dilute 2 + random 4][ set dilute 5 + random 5 ]]
  reset-ticks
end


to go
  ask cars [move speed]
  set-signal-colours
  add-a-car
  speed-up
  meet-traffic-lights
  drive-out-of-hanyang
  pollute
  impact
  kill-cars
  calc-poll
  set-scenario ;; we turn this off when testing
  NO2-plot
  traffic-count


  tick
  if ticks = 13008 [stop export-all-plots "results.csv"]
end

;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;

to set-gis
  ask patches [ set pcolor white ] ;; set a white background

  gis:load-coordinate-system (word "GIS/Seoul_4daemoonArea.prj")
  set area  gis:load-dataset "GIS/Seoul_4daemoonArea.shp"
  set roads gis:load-dataset "GIS/Seoul_4DaemoonLink.shp"
  gis:set-world-envelope (gis:envelope-union-of gis:envelope-of roads)

  ask patches gis:intersecting area [set is-research-area? true]
  ask patches gis:intersecting roads [set road_buffer true ]
  ask patches with [road_buffer != true] [
    if any? neighbors with [road_buffer = true][set road_buffer true]]
  ask patches with [road_buffer != true][set road_buffer false]

  foreach gis:feature-list-of roads [ vector-feature ->
    let first-vertex gis:property-value vector-feature "UP_FROM_NO"
    let last-vertex gis:property-value vector-feature "UP_TO_NO"

    foreach  gis:vertex-lists-of vector-feature [ vertex ->
      let previous-turtle nobody

      foreach vertex [ point ->
        let location gis:location-of point
        if not empty? location
        [
          let x item 0 location
          let y item 1 location
          let current-node one-of (nodes-on patch x y) with [ xcor = x and ycor = y ]
          if current-node = nobody [
             create-nodes 1 [
              setxy x y
              set size 0.05
              set shape "circle"
              set color one-of base-colors
              set hidden? false
              ;set name gis:property-value vector-feature "ROAD_NAME_"

              ; Here you assign the first-vertex and last-vertex of the entire line
              ; to each node
              set line-start first-vertex
              set line-end last-vertex
              set current-node self
            ]
          ]
          ask current-node [
            if is-turtle? previous-turtle [
              create-link-with previous-turtle
            ]
            set previous-turtle self
          ]]]]
  ]


  ; Import daily pollution
  let p0 csv:from-file "GIS/jongno_rep.csv"
  let poll-value remove-item 0 p0  ;;remove headers in the csv file
  let rep 0  ;; loop

  set no2-stat table:make
  set no2-stat table:make

  foreach poll-value [poll ->
    if item 1 poll = "Back" [
    let counter item 0 poll ;; counter
    let date/hour list (item 2 poll)(item 3 poll) ;; add date and place
    let value lput item 4 poll date/hour
    let no2_ lput item 5 poll value
    table:put no2-stat counter no2_
  ]
    if item 1 poll = "Road" [
    let counter item 0 poll ;; counter
    let date/hour list (item 2 poll)(item 3 poll) ;; add date and place
    let value lput item 4 poll date/hour
    let no2_ lput item 5 poll value
    table:put no2-stat counter no2_
  ]
  ]
  set rep rep + 1

  ;ask patches with [is-research-area? = true and road_buffer = false]
  ;[set no2_back (item 2 table:get no2-stat 1) + random-float (item 3 table:get no2-stat 1)]

  ask patches with [is-research-area? = true and road_buffer = true]
  [set no2_road (item 2 table:get no2-stat 1) + random-float (item 3 table:get no2-stat 1)]

end

to draw-4daemoon
  gis:set-drawing-color [ 229 255 204]    gis:fill area 0 ;;RGB color
  gis:set-drawing-color [  64  64  64]    gis:draw area 1
end

to draw-daum-map
  import-drawing "GIS/4Daemoon1.png"
end

to add-labels
foreach gis:feature-list-of area [vector-feature ->
    let centroid gis:location-of gis:centroid-of vector-feature
       if not empty? centroid
      [ create-area-labels 1
        [ set xcor item 0 centroid
          set ycor item 1 centroid
          set size 0
          set label-color blue
          set label gis:property-value vector-feature "adm_dr_nm_"

        ]
      ]
    ask patches [set dong-code gis:property-value vector-feature "DONG_CODE"]
  ]
end

to activate-links
  ask links [
    set is-road? true
    let way list [line-start] of end1 [line-end] of end2
    let daero ["Jahamun-ro"  "Sajik-ro"  "Samil-daero"  "Yulgok-ro"  "Toegye-ro" "Saemunan-ro 3-gil" "Jangchungdan-ro"
      "Taepyeong-ro"  "Sejong-daero"  "Jong-ro"  "Eulji-ro"  "Seosomun-ro" "Donhwamun-ro" "Sejong-daero 23-gil"]

    foreach gis:feature-list-of roads [ vector-feature-sub ->
      let mspeed gis:property-value vector-feature-sub "MAX_SPD"
      let vector-start gis:property-value vector-feature-sub "UP_FROM_NO"
      let vector-end gis:property-value vector-feature-sub "UP_TO_NO"
      let start-end list vector-start vector-end
      let end-start list vector-end vector-start

      if way = start-end [set road-name gis:property-value vector-feature-sub "ROAD_NAME_"]
      if road-name = one-of daero [set thickness .1 set color black set Daero? true]
      if road-name = 0 or road-name = "" [set road-name [name] of end2 ]
      set max-spd read-from-string mspeed
         ]
  ]
end

to set-signals
; Set Signals in junctions

  ask nodes [
    ifelse count my-links > 2
      [set size 7
       set intersection? true
       set auto? random 300
    ]
      [set hidden? true
       set color grey
      ]
  ]

  ask nodes with [intersection? = true][
    if auto? >= 150 [set color green set green-light? true]
    if auto? <  150 [set color red set green-light? false]
    set pcolor black + 5
    ask neighbors [set pcolor black + 5]
    ask patches with [pcolor = black + 5] [set intersection true]
  ]
end

to set-cars
  set-default-shape cars "car"
  create-cars no-of-cars [
    set size 8
    set speed 0
    let l one-of links with [Daero? = true]
    set-next-car-link l [end2] of l
            ]

  ask n-of (int(.7 * count cars)) cars [
    set fueltype "Gasoline"
    let r random-float 1
    if (0   <= r and r < 0.4)[set class 1 + random 2]
    if (0.4 <= r and r < 0.8)[set class 3 + random 2]
    if (0.8 <= r      )[set class 5]
  ]

  ask cars with [fueltype != "Gasoline"][
    set fueltype "Diesel"
    let r random-float 1
    if (0   <= r and r < 0.8)[set class 3 + random 2]
    if (0.8 <= r      )[set class 5]
  ]

end




;;;;;;;;;;;
;;; go ;;;;
;;;;;;;;;;;

to set-signal-colours
  ask nodes with [intersection? = true] [
    set auto? auto? - 1
    if auto? >= 150 [set color green set green-light? true]
    if auto? <  150 [set color red set green-light? false]
    if auto? = 0 [set auto? 300]
  ]
end


;;-------------------Vehicle movement-----------------;;
to move [dist] ;; bus proc
  let dxnode distance to-node
  ifelse dxnode > dist [forward dist]
  [
    let nextlinks [my-links] of to-node

    ifelse count nextlinks = 1
    [ set-next-car-link cur-link to-node ]
    [ set-next-car-link one-of nextlinks with [self != [cur-link] of myself] to-node ]
    move dist - dxnode
   ]

end

to set-next-car-link [l n] ;; proc
  set cur-link l
  move-to n
  ifelse n = [end1] of l [set to-node [end2] of l] [set to-node [end1] of l]
  face to-node

end


to add-a-car
  set-default-shape cars "car"
  let hours item 1 table:get no2-stat (ticks + 1)
  let incoming-vehicles ""

  if hours >= 7 and hours <= 10 [set incoming-vehicles 5]
  if hours >= 11 and hours <= 17 [set incoming-vehicles 2]
  if hours >= 18 and hours <= 21 [set incoming-vehicles 5]
  if hours >= 22 or hours < 7 [set incoming-vehicles 0]

  if (count cars) < car-limit-number [
  create-cars incoming-vehicles [
    set size 8
    set speed random-float 2
    ifelse (count cars with [fueltype = "Diesel"] / count cars) <= 0.3 [
    set fueltype "Diesel"
    let ss random-float 1
    if (ss < 0.7)[set class 3 + random 2]
    if (ss >= 0.7 )[set class 5]
  ][
    set fueltype "Gasoline"
    let rr random-float 1
    if (rr < 0.4)[set class 1 + random 2]
    if (0.4 <= rr and rr < 0.8)[set class 3 + random 2]
    if (0.8 <= rr)[set class 5]
  ]
    let r random-float 1
    let l link 232 233
    if (0 <= r   and r < 0.1)[set l link 608 613] ; sajikro
    if (0.1 <= r and r < 0.2)[set l link 429 432] ; jahamunro
    if (0.2 <= r and r < 0.3)[set l link 213 214] ; yulgokro north(near ehwa)
    if (0.3 <= r and r < 0.4)[set l link 645 646] ; yulgokro east(near ddm)
    if (0.4 <= r and r < 0.5)[set l link 1490 1491] ; sowolro
    if (0.5 <= r and r < 0.6)[set l link 1185 1186] ; jongno
    if (0.6 <= r and r < 0.7)[set l link 1455 1456] ; samildaero
    if (0.7 <= r and r < 0.8)[set l link 1364 1365] ; seosomunro
    if (0.8 <= r and r < 0.9)[set l link 673 674] ; Changgyeonggung-ro
    if (0.9 <= r and r < 1.0)[set l link 1594 1595] ; Jangchungdan-ro
    set-next-car-link l [end1] of l
    ]
  ]

end


to kill-cars
let night item 1 table:get no2-stat (ticks + 1)
    if (night >= 22 and night < 24 or night < 4) [
    ask n-of (int(.01 * count cars)) cars [die]
  ]

end


to speed-up
  let max-speed 3
  let min-speed 0.5
  ask cars [
    set speed min-speed + random-float (max-speed - min-speed)
    let car-ahead one-of cars-on patch-ahead 1
    if car-ahead != nobody
      [ slow-down car-ahead]
;    let empty-patches neighbors with [not any? cars-here]
;    if any? empty-patches
;      [ stop-car empty-patches]

  ]
end

to slow-down [car-ahead ]
  ;; slow down so you are driving more slowly than the car ahead of you
  let deceleration 0 + random-float 1
  set speed [ speed ] of car-ahead - deceleration

end


to meet-traffic-lights
  ask cars [
  if any? nodes in-radius 2 with [green-light? = false][ set speed 0 ]
  if any? other nodes in-radius 1 with [green-light? = true]
    [set speed (speed + (speed-variation + random-float 1)) ]

  ]


end


to drive-out-of-hanyang
 ask cars [
    if distance min-one-of nodes with [who = 426 or who = 428 or who = 418 or who = 729 or
    who = 635 or who = 1570 or who = 1571 or who = 1527 or who = 1541 or who = 1540 or who = 602 or who = 595]
    [distance myself] < 1
    [die]
    ]
end




;;----------------Set exposure & Impact--------------;;
to calc-poll


  ask patches with [road_buffer = true][
    set no2_road (item 2 table:get no2-stat (ticks + 1)) + random-float (item 3 table:get no2-stat 1)
    if pcolor = 101 [set no2_road no2_road * 1.1]
    if pcolor = 102 [set no2_road no2_road * 1.3]
    if pcolor = 103 [set no2_road no2_road * 1.7]

  ]




end


to pollute
;Small Vehicles
  ask cars [
    let polluting one-of [link-neighbors] of to-node
    ask [link-with polluting] of to-node [set thickness 0.3]
    if class <= 2 [ask patches in-cone 2 60 [set pcolor 101]]
    if class = 3 and class = 4 [ask patches in-cone 2 60 [set pcolor 102]]
    if class = 5 [ask patches in-cone 3 90 [set pcolor 103 ]]
  ]

end


to impact
  ask patches with [pcolor = 101 or pcolor = 102 or pcolor = 103][
    ifelse countdown <= 0
      [ set pcolor white
        set countdown dilute ]
      [ set countdown countdown - 1 ]
  ]


end


to set-scenario
  if scenario? = "YES" and ticks mod 10 = 0[
  ask n-of (int(.9 * count cars with [class >= 5])) cars with [class >= 5]
  [ if is-research-area? = true
    [die]]
  ]
  if scenario? = "NO" [print "No restrictions"]


end


to set-scenario1
 ask n-of (int(.9 * count cars with [class >= 5])) cars with [class >= 5]
  [ if is-research-area? = true
    [die]]

end


to NO2-plot
  ;intersection ->  node246: 사직로, node217:율곡로, node849:종로, node1615:퇴계로, node1560: 삼일대로, node780:세종대로

  set-current-plot "NO2-plot"
  set-current-plot-pen "sajikro" plot [no2_road] of [patch-here] of node 91
  set-current-plot-pen "yulgokno" plot [no2_road] of [patch-here] of node 217
  set-current-plot-pen "jongno"   plot [no2_road] of [patch-here] of node 849
  set-current-plot-pen "twegero" plot [no2_road] of [patch-here] of node 1615
  set-current-plot-pen "samildaero" plot [no2_road] of [patch-here] of node 1560
  set-current-plot-pen "sejongdaero" plot [no2_road] of [patch-here] of node 1035
  set-current-plot-pen "roadmean" plot precision mean [no2_road] of patches with [road_buffer = true] 2

end





to traffic-count
  set-current-plot "Traffic-plot"
  set-current-plot-pen "cars_sajik" plot count cars-on node 91
  set-current-plot-pen "cars_yulgok" plot count cars-on node 217
  set-current-plot-pen "cars_jongno"   plot count cars-on node 849
  set-current-plot-pen "cars_twege" plot count cars-on node 1615
  set-current-plot-pen "cars_samil" plot count cars-on node 1560
  set-current-plot-pen "cars_sejong" plot count cars-on node 1035
end


@#$#@#$#@
GRAPHICS-WINDOW
437
62
1038
672
-1
-1
0.6
1
13
1
1
1
0
1
1
1
-300
300
-300
300
1
1
1
ticks
2000.0

BUTTON
18
33
85
66
NIL
setup
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
92
77
165
110
Shape
draw-4daemoon
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
170
76
231
109
Map-del
cd
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
19
77
86
110
Localmap
draw-daum-map
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
98
34
161
67
NIL
go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

SLIDER
21
133
193
166
speed-variation
speed-variation
0
3
0.4
.1
1
NIL
HORIZONTAL

BUTTON
169
33
232
66
step
go
NIL
1
T
OBSERVER
NIL
T
NIL
NIL
1

SLIDER
22
170
194
203
no-of-cars
no-of-cars
200
500
400.0
25
1
NIL
HORIZONTAL

MONITOR
29
214
100
259
total.cars
count cars
17
1
11

MONITOR
104
214
169
259
Gas 1-2
count cars with [class <= 2 and fueltype = \"Gasoline\"]
17
1
11

MONITOR
175
214
240
259
Gas 3-4
count cars with [class > 2 and class <= 4 and fueltype = \"Gasoline\"]
17
1
11

MONITOR
23
314
107
359
Date
item 0 table:get no2-stat (ticks + 1)
17
1
11

MONITOR
114
315
171
360
Hour
item 1 table:get no2-stat (ticks + 1)
17
1
11

MONITOR
178
316
253
361
NO2(est.)
precision mean [no2_road] of patches\n with [road_buffer = true] 2
17
1
11

CHOOSER
267
316
359
361
scenario?
scenario?
"NO" "YES"
0

PLOT
22
423
334
543
NO2-plot
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"sajikro" 1.0 0 -14070903 true "" ""
"yulgokno" 1.0 0 -7500403 true "" ""
"jongno" 1.0 0 -2674135 true "" ""
"twegero" 1.0 0 -955883 true "" ""
"sejongdaero" 1.0 0 -1184463 true "" ""
"samildaero" 1.0 0 -6459832 true "" ""
"roadmean" 1.0 0 -10899396 true "" ""

TEXTBOX
675
28
870
66
서울 녹색교통진흥지역
18
0.0
1

PLOT
21
553
336
673
Traffic-plot
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"cars_sajik" 1.0 0 -7500403 true "" ""
"cars_yulgok" 1.0 0 -2674135 true "" ""
"cars_jongno" 1.0 0 -955883 true "" ""
"cars_twege" 1.0 0 -6459832 true "" ""
"cars_samil" 1.0 0 -1184463 true "" ""
"cars_sejong" 1.0 0 -10899396 true "" ""

MONITOR
243
213
294
258
Gas 5
count cars with [class = 5 and fueltype = \"Gasoline\"]
17
1
11

MONITOR
104
262
173
307
Diesel 3-4
count cars with [class <= 4 and fueltype = \"Diesel\"]
17
1
11

MONITOR
178
261
238
306
Diesel 5
count cars with [class = 5 and fueltype = \"Diesel\"]
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person business
false
0
Rectangle -1 true false 120 90 180 180
Polygon -13345367 true false 135 90 150 105 135 180 150 195 165 180 150 105 165 90
Polygon -7500403 true true 120 90 105 90 60 195 90 210 116 154 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 183 153 210 210 240 195 195 90 180 90 150 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Line -16777216 false 172 90 161 94
Line -16777216 false 128 90 139 94
Polygon -13345367 true false 195 225 195 300 270 270 270 195
Rectangle -13791810 true false 180 225 195 300
Polygon -14835848 true false 180 226 195 226 270 196 255 196
Polygon -13345367 true false 209 202 209 216 244 202 243 188
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165

person student
false
0
Polygon -13791810 true false 135 90 150 105 135 165 150 180 165 165 150 105 165 90
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -1 true false 100 210 130 225 145 165 85 135 63 189
Polygon -13791810 true false 90 210 120 225 135 165 67 130 53 189
Polygon -1 true false 120 224 131 225 124 210
Line -16777216 false 139 168 126 225
Line -16777216 false 140 167 76 136
Polygon -7500403 true true 105 90 60 195 90 210 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="macro" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <enumeratedValueSet variable="scenario?">
      <value value="&quot;YES&quot;"/>
      <value value="&quot;NO&quot;"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
