extensions [nw]

; In this case, we will work with turtles, not patches.
; Specifically with two types of turtles
breed[nodes node]         ; to represent the nodes of the network
breed[searchers searcher] ; to represent the agents that will make the search
breed[cars car]
links-own [ weight ]

; We don't need any extra property in the nodes. All the information will be stored
; in the searchers, and to know if a node has been explored it is enough to see of there
; is a searcher on it.

; Searchers will have som additional properties for their functioning.
searchers-own [
  memory               ; Stores the path from the start node to here
  cost                 ; Stores the real cost from the start
  total-expected-cost  ; Stores the total exepcted cost from Start to the Goal that is being computed
  localization         ; The node where the searcher is
  active?              ; is the seacrher active? That is, we have reached the node, but
                       ; we must consider it because its neighbors have not been explored
]

cars-own [
 origin
 destination
 myFN

]

; Setup procedure: simply create the geometric network based on the number of random located nodes
; and the maximum radius to connect two any nodes of the network
to setup
  ca
  create-nodes Num-nodes [
    setxy random-xcor random-ycor
    set shape "circle"
    set size .5
    set color blue]
  ask nodes [
    create-links-with other nodes in-radius radius]

  create-cars 2 [
    set shape "car"
    set color one-of base-colors
    set size 2
    set myFN 0
  ]

  ask nodes [set color blue set size .5]
  ask links with [color = yellow][set color grey set thickness 0]


  ask cars [
    set origin one-of nodes
    move-to origin
    let start [origin] of cars
    let goal max-one-of other nodes [distance myself]
    set destination goal
    ask goal [set color [color] of myself set size 1]
    set myFN distance goal

  ]

  reset-ticks

end

to move1
  tick
  ask cars [
    ; Randomly choose a target node to walk to
    let target max-one-of other nodes [distance myself]
    if target != nobody [
      ; Remember the starting node
      let current one-of nodes-here
      ; Define a path variable from the current node- take all but
      ; the first item (as first item is current node)
      let path nobody
      ask links [ set weight link-length ]
      ask current [
        set path but-first nw:turtles-on-weighted-path-to target weight
        print path
      ]
      ; Indicate the end node
      ask last path [
        set color red
        set size 2.5
      ]
      ; Move along the path node-to-node
      foreach path [
        next-target ->
        face next-target
        move-to next-target
        wait .1
        ask next-target [
        set color yellow
        ]
      ]
    ]
    ;wait .1
    ; Reset
    ask nodes [ set color blue ]
    ask one-of nodes-here [ set color green ]
  ]
end


;;https://stackoverflow.com/questions/52070634/make-turtles-move-to-another-node-depending-on-their-current-node
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
23
83
86
116
NIL
setup\n
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

SLIDER
22
10
194
43
radius
radius
0
10
1.6
.1
1
NIL
HORIZONTAL

SLIDER
22
43
194
76
Num-Nodes
Num-Nodes
0
1000
1000.0
50
1
NIL
HORIZONTAL

BUTTON
24
119
84
152
NIL
move1
NIL
1
T
OBSERVER
NIL
G
NIL
NIL
1

@#$#@#$#@
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

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
