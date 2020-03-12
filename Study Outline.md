# Model Description
## Pathfinding Algorithms: Dijkstra and A*
Dijkstra algorithm and A-star algorithm are the most widely used path-finding algorithms to find the shortest path from their vertices and segments, which in real life may represent road networks. 

Dijkstra calculates the lowest cost of distance to its destination at every unvisited vertex and updates the distance if the cost is smaller. The only downside is that it takes longer to caculate the cost when the road nextworks gets complicated. 
A-star algorithm is based upon Dijkstra, but uses the heuristic framework to shorten the calculation time and optimising the shortest path. In this context, an individual's heuristy is measured as a shortest euclidean distance to its destination. 


## Pathfinding in NetLogo: an example
This model implements travel patterns of different transport modes from their origin to destination. Vehicles are used as an example for this test run and each vehicle is assumed to find its destination according to the path finding algorithm.

NetLogo has a pathfinding model embedded in the **network extension** which takes into account the shortest routes from the length of links.

* Extensions and agent settings
* Setup (Set GIS, Set roads, Set vehicles and their OD)
* Move to Destination
* Head to Origin

### Extensions and agent settings

```scala
extensions [gis csv table nw]

globals [
  districtCar
  districtadminCode
  pollution-data
  area
  roads
  dilute
  building-layer
  arrived

]

breed [nodes node]
breed [area-labels area-label]
breed [buildings building]
breed [cars car]


links-own [
  road-name
  is-road?
  max-spd
  Daero?
  weight
]

patches-own [
  is-research-area?
  intersection
  countdown
  dong-name
  dong-code
  road_buffer

  centroid? ;;is it the centroid of a building?
  id   ;;if it is a centroid of a building, it has an ID that represents the building
  entrance ;;nearest vertex on road. only for centroids.
]

cars-own [
  speed
  class
  fueltype

  district_name district_code
  origin ;;a vertex. where the vehicle begins the trip
  destination ;; allocated destination
  goal  ;;the entrance of the destination on the road
  path-work ;; an agentset containing nodes to visit in the shortest path
  path-home
  nodes-remaining
  current
  to-node
  myroad
  current-link
  next-link
  links-left
]

nodes-own [
  name
  dong_code
  line-start
  line-end
  auto?
  green-light?
  intersection?
  entrance?
  dist-original  ;;distance from original point to here
]

```


### Setup


```javascript
to setup
  ca
  set-gis
  activate-links
  vehicles
  set-OD
  set-path-node
  set-path-link
  reset-ticks
end
```


### Set GIS



1. Call shape files and set projections
```javascript
to set-gis
  ask patches [ set pcolor white ] ;; set a white background

  gis:load-coordinate-system (word "GIS/hanyangwall_dong.prj")
  set area  gis:load-dataset "GIS/Seoul_4daemoonArea.shp"
  set roads gis:load-dataset "GIS/Seoul_4DaemoonLink.shp"
  gis:set-world-envelope (gis:envelope-union-of gis:envelope-of roads)
  set building-layer gis:load-dataset "GIS/seoulCBD_Buildings1.shp"
  gis:set-drawing-color 5  gis:fill building-layer 1.0
  ask patches gis:intersecting area [set is-research-area? true]
      foreach gis:feature-list-of area [vector-feature ->
  ask patches[ if gis:intersects? vector-feature self [set dong-name gis:property-value vector-feature "adm_dr_nm_"
                                 set dong-code gis:property-value vector-feature "DONG_CODE"]
 ]]
  ask patches gis:intersecting roads [set road_buffer true ]
  ask patches with [road_buffer != true] [
    if any? neighbors with [road_buffer = true][set road_buffer true]]
  ask patches with [road_buffer != true][set road_buffer false]

```


2. Identify centroids of the buildings and assign IDs to centroids

```javascript
   foreach gis:feature-list-of building-layer [ feature ->
    let centroid gis:location-of gis:centroid-of feature
    if not empty? centroid [
      create-buildings 1 [
        set xcor item 0 centroid
        set ycor item 1 centroid
        set size 0
        set centroid? true
        set id gis:property-value feature "ID"
      ]
      ]
  ]
  ask patches with [centroid? != true][set centroid? false set ID "not given"  ]
```

3. Create turtles representing the nodes. Create links to connect them

```scala=
  foreach gis:feature-list-of roads [ vector-feature ->
    let first-vertex gis:property-value vector-feature "UP_FROM_NO"
    let last-vertex gis:property-value vector-feature "UP_TO_NO"

    foreach  gis:vertex-lists-of vector-feature [ vertex ->
      let previous-node nobody

      foreach vertex [ point ->
        let location gis:location-of point
        if not empty? location
        [
          create-nodes 1 [
            set xcor item 0 location
            set ycor item 1 location
            set size 0.05
            set shape "circle"
            set color one-of base-colors
            set hidden? false
            set line-start first-vertex
            set line-end last-vertex


        ifelse previous-node = nobody
                 [] ; first vertex in feature
                 [create-link-with previous-node] ; create link to previous node
                  set previous-node self]
        ]
      ] ; end of foreach vertex
      ] ; end of foreach  gis:vertex-lists-of vector-feature
      ] ; end of foreach gis:feature-list-of roads


  ;;delete duplicate vertices
  ;;(there may be more than one vertice on the same patch due to reducing size of the map).
  ;;therefore, this map is simplified from the original map.

    ask nodes [
    if count nodes-here > 1 [
      ask other nodes-here  [
        ask myself [create-links-with other [link-neighbors] of myself]
        die]
      ]
    ]

    ;;find nearest node to become entrance
  ask patches with [centroid? = true][set entrance min-one-of nodes in-radius 200 [distance myself]
    ask entrance [set entrance? true]
  ]
  ask patches with [centroid? = false][ask nodes [set entrance? false]]
    ;if show_nodes? [ask vertices [set hidden? false]]
    ;if show_entrances? [ask entrance [set hidden? false set shape "star" set size 0.5]]]

end
```


```javascript
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
      if road-name = one-of daero [set Daero? true]
      if road-name = 0 or road-name = "" [set road-name [name] of end2 ]
      set max-spd read-from-string mspeed
         ]
  ]
end
```

### Vehicle setup

**1. Setup vehicles**

   The model used a 10% sample of vehicle registration by fuel type in the CBD area. The model allocate Unleaded, Diesel, or LPG, despite a growing number of hybrid vehicles (e.g EV with undleaded or diesel) accounting for the recent manufacturers industry.

   The vehicles will be located in one of the links as a starting point, and will have its own fuel type.


```javascript
to vehicles
  let vehicle csv:from-file "GIS/Seoul_Vehicle_sample.csv"
  let rawheader item 0 vehicle
  let carTT remove-item 0 rawheader
  let carstat remove-item 0 vehicle

  set districtCar table:make
  set districtadminCode table:make


  foreach carstat [ code ->
    let gasdiesel list (item 2 code)(item 3 code)
    let total lput item 4 code gasdiesel
    table:put districtCar item 0 code total
    table:put districtadminCode item 0 code item 1 code
  ]


    foreach table:keys districtCar [ v ->
    let carGroupID 0
    foreach table:get districtCar v [ xx ->
      create-cars xx [
        setupCarGroup carGroupID
        set size 2
        set district_code v
        set district_name table:get districtadminCode v
        set shape "car"
        set origin one-of nodes with [dong_code = [district_code] of myself]
        set destination nobody
      ]
      set carGroupID carGroupID + 1
    ]]

  ask cars [ifelse origin != nobody [move-to origin]
    [set origin one-of nodes with [dong_code = 1101054]
    move-to origin
    ]
  ]
end


to setupCarGroup [Car_ID]
  if Car_ID = 0 [set fueltype "Gasoline" set color green]
  if Car_ID = 1 [set fueltype "Diesel" set color black + 1]
  if Car_ID = 2 [set fueltype "LPG" set color blue + 2]
end
```


**2. Setup Origin-Destination**

This model uses an OD matrix (mode-based) provided by the Korean Transport Database. This study transforms the estimated numbers to a list of fractions so that the sampled data can be correctly identified and allocated. Using two variables *passenger cars* and *carpooled passengers*, this matrix picks the fraction of the sample and allocates the origin and the destinated subdistrict.

*Disclaimer*: There are a number of vehicles whose destination is not allocated properly, which is removed for the time being. 



```javascript
to set-OD   ;; Decomposing matrix
  let odcar csv:from-file "GIS/od_car.csv"
  let rawheader item 0 odcar
  let destinationNames remove-item 0 rawheader
  let ODMat remove-item 0 odcar

  let ODMatrix table:make
  foreach ODMat [ origin-chart ->
    let number remove-item 0 origin-chart
    table:put ODMatrix item 0 origin-chart number
  ]

  foreach table:keys ODMatrix [originName ->
    let matrix-loop 0
    let Num count cars with [district_code = originName]
    let totalUsed 0
    let number 0

  foreach table:get ODMatrix originName [ percent ->
      let newDestination item matrix-loop destinationNames
      ifelse (newDestination != 1102060)
          [set number precision (percent * Num) 0 set totalUsed totalUsed + number]
          [set number Num - totalUsed]

      let carsRemaining cars with [district_code = originName and destination = nobody]
      ;if count carsRemaining > 0 and count carsRemaining <= number [ set number count carsRemaining ]
               ;if number < 0  [ set number 0]

      ask n-of number carsRemaining [
        set destination one-of patches with [dong-code = newDestination and centroid? = true]
        set goal [entrance] of destination
        while [goal = origin] [set destination one-of patches with [centroid? = true]
          set goal [entrance] of destination]
        set path-work []
        set path-home []
        set myroad []
       ]

     set matrix-loop matrix-loop + 1
    ]
output-type totalused output-type " " output-type Num output-type " " output-print originName
  ]


  ;;;; Kill cars for the time being
  ask cars with [destination = nobody][die]
 type "Cars not able to find their destinations were killed for the time being"
```

### Set Path-node


```javascript
to set-path-node
    ask cars [
    ; Randomly choose a target node to walk to
    let target [goal] of self
    ;print target
    if target != nobody [
      ; Remember the starting node
      set current one-of nodes-here
      ; Define a path variable from the current node- take all but
      ; the first item (as first item is current node)
      let path nobody
      ask links [ set weight link-length ]
      ask current [
        set path but-first nw:turtles-on-weighted-path-to target weight
      ]

      ; Indicate the end node
      ask last path [
        set color [color] of self
        set entrance? true
        set size 0.5 ]

      let path-work0 lput path path-work ;; assign all the nodes that leads to the destination node
      set path-work item 0 path-work0
      set to-node first path ;; or can code as ---> item 0 item 0 path-work
      ;let path-home0 fput path path-work
      ;output-print path-home0
      ;set path-home item 0 path-home0
    ]

      set nodes-remaining length [path-work] of self
      set current-link link [who] of [current] of self [who] of [to-node] of self
      face to-node

      let points n-values [nodes-remaining] of self [x -> ([nodes-remaining] of self - 1) - x]
    foreach points [ x ->
      set path-home lput item x [path-work] of self path-home
    ]

    set path-home lput origin path-home
   ]

end
```







### Move to Destination
The `foreach` function asks the vehicles to move their neighbouring node at each `tick`. The simulation will run depending on the remainder of vehicles node's arrival to destination.



```javascript
to to-work
  let high max-one-of cars with [current != goal][nodes-remaining]
  let highest [nodes-remaining] of high

  let points (range 0 highest)
  let carlist [self] of cars

   foreach points [ nnode ->
      ask cars [if nnode < [nodes-remaining] of self [
          face item nnode path-work
          move-to item nnode path-work
          wait .001

          set current one-of nodes-here
          set current-link one-of [my-links] of current
  ]]
  tick
  ]
   if (all? cars [current = goal]) [output-print "All at work"]
end
```


### Head to Origin

```javascript
to head-home
  let high max-one-of cars with [current != origin][nodes-remaining]
  let highest [nodes-remaining] of high
  let points (range 0 highest)

   foreach points [ nnode ->
      ask cars [if nnode < ([nodes-remaining] of self) [
          face item nnode path-home
          move-to item nnode path-home
          wait .001

          set current one-of nodes-here
          set current-link one-of [my-links] of current
  ]]
  tick
  ]

  if (all? cars [current = to-node]) [output-print "All at Home"]
end
```
