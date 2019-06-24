extensions [gis csv table]
globals [pollution-data area roads rate dilute car-limit-number pm10-stat no2-stat o3-stat test]
breed [nodes node]
breed [area-labels area-label]
breed [cars car]
nodes-own [name line-start line-end auto? green-light? intersection?]
links-own [road-name is-road? max-spd Daero?]
cars-own  [to-node cur-link speed reg-year]
patches-own [is-research-area? intersection countdown dong-code pm10 no2 o3]


to setup
  ca
  import-drawing "GIS/4Daemoon1.png"
  set-gis
  add-labels
  activate-links
  set-signals
  set-cars
  accelerate
  set car-limit-number no-of-cars * 5
  set rate .01
  set dilute random 15
  reset-ticks
end


to go
  ask cars [move speed]
  set-signal-colours
  add-a-car
  adjust-speed
  set-speed-variation
  ;calc-poll
  pollute
  impact



  tick
end

;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;

to set-gis
  ask patches [ set pcolor white ] ;; set a white background

  gis:load-coordinate-system (word "GIS/Seoul_4daemoonArea.prj")
  set area  gis:load-dataset "GIS/Seoul_4daemoonArea.shp"
  set roads gis:load-dataset "GIS/Seoul_4DaemoonLink.shp"
  let pm10-data  gis:load-dataset "GIS/pm10.asc"
  let no2-data  gis:load-dataset "GIS/no2.asc"
  let o3-data  gis:load-dataset "GIS/o3.asc"
  gis:set-world-envelope (gis:envelope-union-of gis:envelope-of roads)

  ask patches gis:intersecting area [set is-research-area? true]

  foreach gis:feature-list-of roads [ vector-feature ->
    ; First, grab the names of the starting and ending node for the current
    ; vector feature in order to assign common names to all nodes within
    ; the feature
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
              set name gis:property-value vector-feature "ROAD_NAME_"

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
          ]]]]]

;; Display Pollution Data
  gis:apply-raster pm10-data pm10
  gis:apply-raster no2-data no2
  gis:apply-raster o3-data o3
  ;let min-pm10-data gis:minimum-of pm10-data
  ;let max-pm10-data gis:maximum-of pm10-data
  ;ask patches
  ;  [if (pm10 <= 0) or (pm10 >= 0)
  ;  [set pcolor scale-color black pm10 min-pm10-data max-pm10-data]]
  ;ask patches with [pm10 > 0] [set is-research-area? true]

  let t csv:from-file "GIS/test.csv"
  let t1 remove-item 0 t
  let repeats 0
  set test table:make

  foreach t1 [ttest ->
    let counter item 0 ttest ;; counter
    let diff item 1 ttest
    table:put test counter diff
  ]
  set repeats repeats + 1

  ; Import daily pollution
  let p0 csv:from-file "GIS/poll-stats.csv"
  let poll-value remove-item 0 p0  ;;remove headers in the csv file
  let rep 0  ;; loop
  set pm10-stat table:make
  set no2-stat table:make
  set o3-stat table:make

  foreach poll-value [poll ->
    if item 1 poll = "pm10" [
    let counter item 0 poll ;; counter
    let date/hour list (item 2 poll)(item 3 poll) ;; add date and place
    let value lput item 4 poll date/hour
    let diff lput item 5 poll value
    table:put pm10-stat counter diff
  ]
    if item 1 poll = "no2" [
    let counter item 0 poll ;; counter
    let date/hour list (item 2 poll)(item 3 poll) ;; add date and place
    let value lput item 4 poll date/hour
    let diff lput item 5 poll value
    table:put no2-stat counter diff
  ]
    if item 1 poll = "o3" [
     let counter item 0 poll ;; counter
    let date/hour list (item 2 poll)(item 3 poll) ;; add date and place
    let value lput item 4 poll date/hour
    let diff lput item 5 poll value
    table:put o3-stat counter diff
  ]
  ]
  set rep rep + 1


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
    let 대로 ["Jahamun-ro"  "Sajik-ro"  "Samil-daero"  "Yulgok-ro"  "Toegye-ro" "Saemunan-ro 3-gil" "Jangchungdan-ro"
      "Taepyeong-ro"  "Sejong-daero"  "Jong-ro"  "Eulji-ro"  "Seosomun-ro" "Donhwamun-ro" "Sejong-daero 23-gil"]

    foreach gis:feature-list-of roads [ vector-feature-sub ->
      let mspeed gis:property-value vector-feature-sub "MAX_SPD"
      let vector-start gis:property-value vector-feature-sub "UP_FROM_NO"
      let vector-end gis:property-value vector-feature-sub "UP_TO_NO"
      let start-end list vector-start vector-end
      let end-start list vector-end vector-start

      if way = start-end [set road-name gis:property-value vector-feature-sub "ROAD_NAME_"]
      if road-name = one-of 대로 [set thickness .1 set color black set Daero? true]
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
    set reg-year 2010 + random 10
    let l one-of links with [Daero? = true]
    set-next-car-link l [end1] of l
            ]
end


to accelerate
  let max-speed 5
  let min-speed 0.5
  ask cars [set speed min-speed + random-float (max-speed - min-speed)
             ;let l one-of links
    ]
end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; go ;;;;


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
  if (random-float 1) < rate and no-of-cars < car-limit-number [
  create-cars 1 [
    set size 8
    set speed random-float 2

    let r random-float 1
    let l link 232 233
    if (r > 0.2)[set l link 425 426]
    if (r > 0.4)[set l link 417 418]
    if (r > 0.6)[set l link 728 729]
    if (r > 0.8)[set l link 1629 1630]
    set-next-car-link  l [end2] of l
    ]
  ]

end


to adjust-speed
  ;; if there is a car right ahead of you, match its speed then slow down
  ask cars [
    ;let a acceleration
    ;if angle > 27 [set a deceleration * 10  set angle 0]
    ;let car-ahead min-one-of other cars in-cone 1 120 [distance myself]
  ]

end


to set-speed-variation
ask cars [
    if any? nodes in-radius 1 with [green-light? = false][ set speed 0 ]
    if any? other nodes in-radius 1 with [green-light? = true]
      [set speed (speed + (0.3 + random-float 1)) ]
  ]
end



;;----------------Set exposure & Impact--------------;;
to calc-poll
  ask patches with [pm10 >= 0]
    [if ticks > 0
    [set pm10 pm10 + (item 3 table:get pm10-stat (ticks + 1))
        + random-float 0.01 * (random-float (item 3 table:get pm10-stat (ticks + 1))
        - random-float (item 3 table:get pm10-stat (ticks + 1)))
     set no2 no2 + (item 3 table:get no2-stat (ticks + 1))
        + random-float 0.01 * (random-float (item 3 table:get no2-stat (ticks + 1))
        - random-float (item 3 table:get no2-stat (ticks + 1)))
     set o3 o3 + (item 3 table:get o3-stat (ticks + 1))
        + random-float 0.01 * (random-float (item 3 table:get o3-stat (ticks + 1))
        - random-float (item 3 table:get o3-stat (ticks + 1)))
  ]]

end


to pollute
;Small Vehicles
  ask cars [
    let polluting one-of [link-neighbors] of to-node
    ask [link-with polluting] of to-node [set thickness 0.3]
    ask patch-here [set pcolor black + 1]
  ]

end


to impact
  ask patches with [pcolor = black + 1][
    ifelse countdown <= 0
      [ set pcolor white
        set countdown dilute ]
      [ set countdown countdown - 1 ]
  ]


end
@#$#@#$#@
GRAPHICS-WINDOW
259
29
860
639
-1
-1
0.8
1
10
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
30.0

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
29
133
201
166
speed-variation
speed-variation
0
5
0.03
1
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
30
170
202
203
no-of-cars
no-of-cars
0
100
50.0
10
1
NIL
HORIZONTAL

CHOOSER
29
207
167
252
PM10-parameters
PM10-parameters
80 100 150
0

MONITOR
36
288
107
333
total.cars
count cars
17
1
11

MONITOR
111
288
209
333
cars-bf-2009
count cars with [reg-year < 2009]
17
1
11

MONITOR
111
338
192
383
cars-af-09
count cars with [reg-year >= 2009]
17
1
11

SWITCH
84
433
200
466
scenario?
scenario?
0
1
-1000

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
NetLogo 6.0.4
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
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
