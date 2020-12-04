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
  Cost-path  ; Stores the cost of the path to the current patch
  visited?   ; has the path been visited previously? That is,
             ; at least one path has been calculated going through this patch
  active?    ; is the patch active? That is, we have reached it, but
             ; we must consider it because its children have not been explored

  distance-goal
  step
]

people-own
[
  origin
  destination
   h-distance

]


; Prepares the world and starting point
to setup
  ca
  ; Initial values of patches for A*
  ask patches
  [
    set father nobody
    set Cost-path 0
    set visited? false
    set active? false
  ]
  ; Generation of random obstacles
  ask n-of 50 patches
  [
    set pcolor brown
    ask patches in-radius random 10 [set pcolor brown]
  ]
  ; Se the valid patches (not wall)
  set p-valids patches with [pcolor != brown]

  ; Create a random start

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
      [set distance-goal distance item 0 imsi]
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



to set-shortest

  ;if any? patches with [pcolor = yellow and any? neighbors with [pcolor = red]] [
  ask patches with [pcolor = yellow and pcolor = red][
    let lowest min-one-of neighbors [distance-goal]
    ;output-print lowest
    ;output-print [distance-goal] of lowest
    ;output-print mean [distance-goal] of neighbors
    ;if [distance-goal] of lowest <  mean [distance-goal] of neighbors [
      ask lowest [
      set pcolor green
      ;face lowest
      ;move-to lowest
    ]
  ]


 ; ask patches with [pcolor = green and visited? = false] [
 ;   if any? neighbors with [pcolor = yellow ] [
 ;     let tset neighbors with [pcolor = yellow]
 ;     ask min-one-of tset [finding][set pcolor green]
 ;     set visited? true
 ;   ]
 ; ]

end


; Patch report to estimate the total expected cost of the path starting from
; in Start, passing through it, and reaching the #Goal
to-report Total-expected-cost [#Goal]
  report Cost-path + Heuristic #Goal
end

; Patch report to reurtn the heuristic (expected length) from the current patch
; to the #Goal
to-report Heuristic [#Goal]
  report distance #Goal
end

; A* algorithm. Inputs:
;   - #Start     : starting point of the search.
;   - #Goal      : the goal to reach.
;   - #valid-map : set of agents (patches) valid to visit.
; Returns:
;   - If there is a path : list of the agents of the path.
;   - Otherwise          : false

to-report A* [#Start #Goal #valid-map]
  ; clear all the information in the agents
  ask #valid-map with [visited?]
  [
    set father nobody
    set Cost-path 0
    set visited? false
    set active? false
  ]
  ; Active the staring point to begin the searching loop
  ask #Start
  [
    set father self
    set visited? true
    set active? true
  ]
  ; exists? indicates if in some instant of the search there are no options to
  ; continue. In this case, there is no path connecting #Start and #Goal
  let exists? true
  ; The searching loop is executed while we don't reach the #Goal and we think
  ; a path exists
  while [not [visited?] of #Goal and exists?]
  [
    ; We only work on the valid pacthes that are active
    let options #valid-map with [active?]
    ; If any
    ifelse any? options
    [
      ; Take one of the active patches with minimal expected cost
      ask min-one-of options [Total-expected-cost #Goal]
      [
        ; Store its real cost (to reach it) to compute the real cost
        ; of its children
        let Cost-path-father Cost-path
        ; and deactivate it, because its children will be computed right now
        set active? false
        ; Compute its valid neighbors
        let valid-neighbors neighbors with [member? self #valid-map]
        ask valid-neighbors
        [
          ; There are 2 types of valid neighbors:
          ;   - Those that have never been visited (therefore, the
          ;       path we are building is the best for them right now)
          ;   - Those that have been visited previously (therefore we
          ;       must check if the path we are building is better or not,
          ;       by comparing its expected length with the one stored in
          ;       the patch)
          ; One trick to work with both type uniformly is to give for the
          ; first case an upper bound big enough to be sure that the new path
          ; will always be smaller.
          let t ifelse-value visited? [ Total-expected-cost #Goal] [2 ^ 20]
          ; If this temporal cost is worse than the new one, we substitute the
          ; information in the patch to store the new one (with the neighbors
          ; of the first case, it will be always the case)
          if t > (Cost-path-father + distance myself + Heuristic #Goal)
          [
            ; The current patch becomes the father of its neighbor in the new path
            set father myself
            set visited? true
            set active? true
            ; and store the real cost in the neighbor from the real cost of its father
            set Cost-path Cost-path-father + distance father
            set Final-Cost precision Cost-path 3
          ]
        ]
      ]
    ]
    ; If there are no more options, there is no path between #Start and #Goal
    [
      set exists? false
    ]
  ]
  ; After the searching loop, if there exists a path
  ifelse exists?
  [
    ; We extract the list of patches in the path, form #Start to #Goal
    ; by jumping back from #Goal to #Start by using the fathers of every patch
    let current #Goal
    set Final-Cost (precision [Cost-path] of #Goal 3)
    let rep (list current)
    While [current != #Start]
    [
      set current [father] of current
      set rep fput current rep
    ]
    report rep
  ]
  [
    ; Otherwise, there is no path, and we return False
    report false
  ]
end

; Axiliary procedure to lunch the A* algorithm between random patches
to Look-for-Goal
  ; Take one random Goal
  let Goal one-of p-valids
  ; Compute the path between Start and Goal
  let path  A* Start Goal p-valids
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

BUTTON
20
165
102
198
shortest
set-shortest
NIL
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
