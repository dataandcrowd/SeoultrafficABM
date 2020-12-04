## WHAT IS IT?
The purpose of this model is to understand commuter’s exposure to non-exhaust PM<sub>10</sub> emissions, and to make a preliminary estimate of their health effects. This model tests whether reducing traffic can alleviate the pollution levels and whether taking a polluted but quicker path or less polluted but longer path makes a difference to pedestrians' exposure levels.

## HOW IT WORKS
* Agent behaviour
    - As the simulation executes, the pedestrians will start moving from their home to work. You will see 'people at home' are decreasing rapidly, which means they are somewhere heading to the office or have started working. Pedestrians will appear on one of the 26 subway entrances in the study area. Pedestrians who have arrived at their offices will disappear after 80 ticks. This to avoid any visual clutter on the screen. Do not worry, they will appear after work. If you want to check the remainder of the agents work hours, simply inspect the attributes and check 'time-at-work'.
    - The resident vehicles that appeared right after the setup, will start their journey to their workplaces as per the A* algorithm. The vehicles will arrive and stop on the node that is closest to their workplace. They will return home after work. 
    - Non-residents have a free trip in the city centre and drive out randomly. The input of the vehicles is controlled according to the traffic count data provided from Seoul Traffic Monitoring Service.

* Exposure
    - PM<sub>10</sub> levels are amplified in near road areas when a vehicle passes by.
    - Pedestrians who are within 1 radius (<30 metres) from the vehicles will be exposed to high PM<sub>10</sub>
    - Agents who are exposed to 100µg/m3 or over will lose their health


## HOW TO USE IT
Once the Netlogo interface is loaded, you will see three buttons on the top row setup, go, step. 
Please click on the setup to load the vehicles. You can untick the "view updates" tick box right next to the speed slider. Once you see the map and vehicles ready, it is time to click go. You can also click step instead of go if you fancy to look into each step. 

Once the simulation is running, you would see that the date, hours and minutes are changing.

You will see to screens in the middle displayed as Unwell% and Unwell.Car, each of which is accounts for pedestrians and resident vehicle drivers. This will change over time.

The **health loss** slide will change the level of health degrading. Since an individual's initial health begins with 300, I would say the maximum to be 0.2. But feel free to toggle the slides. **Medication** is the temporary recovery level when an individual arrives indoors. This assumes that people take medicine when they feel unwell. **Emission factor** is a parameter that can control the level of PM<sub>10</sub>. Parameter 1 refers to no effect while 20 is almost 3 times higher than the ambient level. This has been fully tested through the sensitivity test. **car-ratio** controls the level of incoming vehicles (non-resident) to the CBD. 


## THINGS TO NOTICE
Note that these vehicles will move freely during the weekend but to put them back to the A* algorithmic route, we had to coerce the vehicles. As a result, you can see vehicles flying back home.


## THINGS TO TRY
As mentioned earlier, feel free to toggle any sliders. Note that **car-ratio** is the only parameter that gives an immediate difference on the screen, while the others require some time to before the change takes an effect.

## EXTENDING THE MODEL
The model extended the Seoul Air Pollution Exposure model published in JASSS (http://jasss.soc.surrey.ac.uk/22/1/12.html). The NetLogo model is also released in ComSES model library (https://www.comses.net/codebases/cb6c2243-fb44-4543-a372-6fee5f034c40/releases/1.1.0/). The published model only requested people to move between origin points and destination points (2 point movement) due to the lack of travel information. Out new model narrowed down the spatial extent but added movement patterns and elaborated temporal scales to a minute basis.

Another model that inspired me was the Venice model (https://www.gisagents.org/2009/02/agent-based-models-for-venice.html). 


## NETLOGO FEATURES
nw and gis extension


## RELATED MODELS
Seoul Air Pollution model https://www.comses.net/codebases/cb6c2243-fb44-4543-a372-6fee5f034c40/releases/1.1.0/


## CREDITS AND REFERENCES

Thanks to Andrew Crooks for achiving the Venice model. The model was deprecated for some reason, but thanks to you I managed to learn the codes and developed it for this study.
