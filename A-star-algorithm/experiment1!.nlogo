globals
[
  p-valids   ; Valid Patches for moving not wall)
  Start      ; Starting patch
  Final-Cost ; The final cost of the path given by A*
]


breed[people person]

patches-own
[
  father     ; Previous patch in this partial path
  visited?   ; has the path been visited previously? That is,
             ; at least one path has been calculated going through this patch
  active?    ; is the patch active? That is, we have reached it, but
             ; we must consider it because its children have not been explored
  step
  Cost-path  ; Stores the cost of the path to the current patch
  Heuristic

]

people-own
[
  origin
  destination
  h-distance
  Total-cost
  track
]


; Prepares the world and starting point
to setup
  ca
  ; Initial values of patches for A*

  ; Generation of random obstacles
  ask n-of 50 patches
  [
    set pcolor brown
    ask patches in-radius random 10 [set pcolor brown]
  ]
  ; Se the valid patches (not wall)
  set p-valids patches with [pcolor != brown]

  ask patches
  [
    set father nobody
    set Cost-path 0
    set visited? false
    set active? false
  ]



  create-people 1
  [
    set shape "person"
    set size 1
    setxy random-xcor random-ycor
    set color one-of base-colors
    if [pcolor] of patch-here = brown [move-to one-of patches with [pcolor != brown]]
    set origin patch-here
    set destination one-of patches with [pcolor != brown]
    set h-distance distance destination
  ]

ask people [
    let current [origin] of self
    let target [destination] of self
    if target != nobody [
      let path nobody
      ask current [
        set pcolor red
        set visited? true
        set step 0
      ]
      ask target [set pcolor green set visited? false]
    ]
  ]


  let recov [self] of patches with [pcolor != brown]
  let target [destination] of people


  foreach recov [ xx ->
    let imsi [destination] of people
    ask xx
      [set Heuristic distance item 0 imsi]
    ]



end

to path-to-goal
  ask people [
  let %target get-target
  ifelse (%target = nobody) [
    ;handle this case
  ] [
    face %target move-to %target
  ]
  ]
end

to-report get-target
  let %close patches in-radius 1 with [
    pcolor != brown and self != [patch-here] of myself]
  ifelse (any? %close) [
    report min-one-of %close [distance myself]
  ] [
    report nobody
  ]
end


to set-path
  ifelse any? patches with
  [pcolor = red and any? neighbors with [pcolor = yellow]][stop]
  [
  ask patches with [pcolor = black and pcolor != green] [
    if any? neighbors4 with [ pcolor = green ] or
       any? neighbors4 with [ pcolor = yellow ]
    [ set pcolor yellow
      set step 1
        ]]]

  ask patches with [pcolor = yellow][set step step + 1
    set plabel step set plabel-color black]


end





to test
  ask people [
    ask patch-here [
      set father self
      set visited? true
      set active? true
      let exists? true
    ]
      let options p-valids with [active? = false]
    ask min-one-of options with [Total-expected-cost ][distance myself]
      [
      set father myself
            set visited? true
            set active? true
    ]
  ]






end


to Total-expected-cost
 report Cost-path + Heuristic

end



; Axiliary procedure to lunch the A* algorithm between random patches
to Look-for-Goal
  ; Take one random Goal
  let Goal one-of p-valids
  ; Compute the path between Start and Goal
  let path "off" ;A* Start Goal p-valids
  ; If any...
  if path != false [
    ; Take a random color to the drawer turtle
    ask turtle 0 [set color (lput 150 (n-values 3 [100 + random 155]))]
    ; Move the turtle on the path stamping its shape in every patch
    foreach path [ x ->
      ask turtle 0 [
        move-to x
        stamp]]
    ; Set the Goal and the new Start point
    set Start Goal
  ]


end

; Auxiliary procedure to clear the paths in the world
to clean
  cd
  ask patches with [pcolor != black and pcolor != brown] [set pcolor black]
  ask Start [set pcolor white]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
622
423
-1
-1
4.0
1
10
1
1
1
0
0
0
1
0
100
0
100
0
0
1
ticks
30.0

BUTTON
15
10
105
43
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
110
10
195
43
Next
Look-for-Goal
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
15
125
97
158
NIL
set-path
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

OUTPUT
5
215
200
440
11

BUTTON
105
125
187
158
NIL
set-path
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
105
60
168
93
NIL
test
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

square
true
0
Rectangle -7500403 true true 0 0 300 300
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
1
@#$#@#$#@
