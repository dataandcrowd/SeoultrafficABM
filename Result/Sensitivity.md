# Documentation: Sensitivity
## Input Parameters: Experimental setup

This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below

* Non-resident cars: 2.5% 5% 10% 20%
* Emission Factors: 1, 5, 10, 20
* health loss?


| Parameter           | Description                                       | Base value | Min    | Max   |
|---------------------|---------------------------------------------------|-----------:|-------:|------:|
| Non-registered Vehicles | Rate of Total registered vehicles in the CBD area | 5%        | 2.5%    | 20%   |
| Health loss         | Health loss function for each agent               | .03        | .01    | .05   |
|Emission Factor         | Vehicle's emission     | 5        | 1    | 20   |

<!--
## Design: A two step process
This study considers two sensitivity tests, locally and globally. Local sensitivity, also known as one-factor-at-a-time method, adjusts one factor while holding the others. Global sensitivity looks at all the possible combinations.


![](https://i.imgur.com/3Ncy2dt.png)
-->

## Local Sensitivity
### Non-Resident Vehicle Sampling
* Question: How does the PM<sub>10</sub> differ by Sample Rates for Non-Resident Vehicles?
* Overall Trend


| car_ratio | Jongno | Sejong | Yulgok | Samil | Pirun |
|-----------|--------|--------|--------|-------|-------|
| 0%        | 49.91  | 53.78  | 49.56  | 55.97 | 51.35 |
| 2.5%      | 57.85  | 71.71  | 75.61  | 72.68 | 73.72 |
| 5%        | 59.79  | 74.75  | 78.31  | 74.56 | 77.8  |
| 10%       | 59.37  | 75.21  | 78.96  | 74.48 | 78.03 |
| 20%       | 57.68  | 74.43  | 78.24  | 71.49 | 77.4  |



![](https://i.imgur.com/35I7i0V.png)
<!--
![](https://i.imgur.com/ALBBXuj.png)
-->


<br><br>


### Health Loss
**Q**. How much does the population at risk change by Health Loss parameters?
By the time the onset is discovered, the vast majority of agents have their nominal health decreased by 100, which is a third of the initial status. Thus, as the parameter rises, the earlier and more frequent the unwell population spike will appear. Health loss parameters `0.003`, `0.005`, `.01`, and `.05` have several peaks, but the shape of the curve looks similar. Additionally, since most of the agent's health centered around 100, there is a constant oscillation of risk population maintaining the figures e.g. almost 25% of the population at risk is observed in paramter `.01`. Also, the time when the population at risk peaked paralleled with the PM<sub>10</sub> exceeded 100µg/m<sup>3</sup>.

| With 5% cars | Zero Cars |
|-----------|--------|
|![Employees](https://i.imgur.com/TMBBHhP.png) |![](https://i.imgur.com/iCRSfir.png)  |
|![Drivers](https://i.imgur.com/H4cBFay.png) |![](https://i.imgur.com/jJJSSNv.png) |

**Q**. Why is there a difference between the subway commuters and resident drivers?
* There isn't much difference on the subway commuter's health because most of the time the commuters are walking across the background zones not the roadside
* Drivers are experiencing higher chances of extreme levels of PM<sub>10</sub> emission and this can be compared in the 0.01 plot. 30% difference is observed
* The Drivers, although with no extra cars coming in to the CBD, have 25%, 50% at risk. This can be due to the effect of background PM10 but also other resident driver's emission
* In short, while the subway commuters are constantly affected by the background PM<sub>10</sub> levels during their commute, the resident drivers have relatively short period of commute time during the weekend but have an extreme exposure to PM<sub>10</sub>, which result in rapid health loss over time. 


### Random Person
**Picked a random subway commuter to observe health change**

This figure shows the temporal trend of health during the simulation by health loss parameters. It is seen that the person has experienced a sudden arrgravation of health on the 17th of January, recovered up to a third of its original health status, but lost again the next day. Its health status plateus just above 100 most of the time but undergoes a numer of oscillations. This shape occurs due to the recovery function which only recovers when health is below the 100 threshold. This could mean that a commuter, whose health deteriorates due to a sudden PM<sub>10</sub> rise can have acute health crises until s/he gets a medical treatment. 

| Near | Far |
|-----------|--------|
|![](https://i.imgur.com/6XW0Yp6.png) | ![](https://i.imgur.com/nVBdprG.png)
|


**Picked a random driver to observe health change**

On the other hand, resident commuters who drive to their workplaces show a marginally decreasing trend of health during the simulation, although the raw data contains presents a noiser recover and decline. Thus, it is certain that, compared to the subway commuters, resident drivers experience less spikes of ambient PM<sub>10</sub> episodes due to the protection of buildings and transits as well as short commuting time.


| Near | Far |
|-----------|--------|
|![](https://i.imgur.com/EewT5u2.png)|![](https://i.imgur.com/PsAirV0.png) |



## PM<sub>10</sub> Concentration
The figure below shows how different emission factors affect PM10 concentrations. Apart from `emission = 1`, emissions 5, 10, and 20 show a linearly increased PM10. For instance, taking PM10 levels on January the 8th, 15th, 22nd, and 29th at 10am, Emission 5 일때는 100, 100, 100, 100 였지만, 10일 때는 100, 100, 100, 100 이었고, 20일 때는 100, 100, 100, 100으로 나타났다. 또한 종로를 제외하고는 대부분의 8차선 대로들의 농도는 비슷한 것으로 밝혀졌다. 한 가지 차이라면 차량정체가 심한곳과 덜 심한 곳일 수도 있지만 어쨌건 겁나 차이 난다. 호호호

| Date       	| Emission factor 	| Jongno 	| Sejong 	| Yulgok 	| Samil 	| Pirun 	|
|------------	|-----------------	|--------	|--------	|--------	|-------	|-------	|
| Overall    	| 1               	| 48.8   	| 51.7   	| 52.5   	| 51.8  	| 52.1  	|
| Overall    	| 5               	| 58.3   	| 72.9   	| 77     	| 73.6  	| 74.8  	|
| Overall    	| 10              	| 70     	| 99.1   	| 108    	| 101   	| 103   	|
| Overall    	| 20              	| 93.7   	| 152    	| 169    	| 156   	| 160   	|
| 2018-01-08 	| 1               	| 55.2   	| 58.0   	| 59.0   	| 58.4  	| 58.6  	|
| 2018-01-08 	| 5               	| 64.1   	| 78.5   	| 82.3   	| 79.8  	| 81.0  	|
| 2018-01-08 	| 10              	| 74.9   	| 102.5  	| 112.3  	| 106.7 	| 109.0 	|
| 2018-01-08 	| 20              	| 96.8   	| 154.8  	| 170.9  	| 160.7 	| 163.8 	|
| 2018-01-15 	| 1               	| 66.0   	| 68.7   	| 69.7   	| 69.2  	| 69.3  	|
| 2018-01-15 	| 5               	| 74.5   	| 88.7   	| 93.3   	| 90.5  	| 91.3  	|
| 2018-01-15 	| 10              	| 85.7   	| 113.0  	| 123.4  	| 116.9 	| 119.0 	|
| 2018-01-15 	| 20              	| 107.9  	| 162.5  	| 182.8  	| 170.2 	| 175.0 	|
| 2018-01-22 	| 1               	| 41.6   	| 44.3   	| 45.4   	| 44.7  	| 44.9  	|
| 2018-01-22 	| 5               	| 50.6   	| 64.4   	| 69.2   	| 66.3  	| 67.2  	|
| 2018-01-22 	| 10              	| 61.4   	| 89.7   	| 99.1   	| 93.4  	| 95.2  	|
| 2018-01-22 	| 20              	| 83.6   	| 139.1  	| 157.9  	| 147.1 	| 150.9 	|

![](https://i.imgur.com/1W69mxl.png)

