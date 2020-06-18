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
![](https://i.imgur.com/ALBBXuj.png)



<br><br>


### Health Loss
**Q**. How much does the population at risk change by Health Loss parameters?
By the time the onset is discovered, the vast majority of agents have their nominal health decreased by 100, which is a third of the initial status. Thus, as the parameter rises, the earlier and more frequent the unwell population spike will appear. Health loss parameters `0.003`, `0.005`, `.01`, and `.05` have several peaks, but the shape of the curve looks similar. Additionally, since most of the agent's health centered around 100, there is a constant oscillation of risk population maintaining the figures e.g. almost 25% of the population at risk is observed in paramter `.01`. Also, the time when the population at risk peaked paralleled with the PM<sub>10</sub> exceeded 100µg/m<sup>3</sup>.

| With 5% cars | Zero Cars |
|-----------|--------|
|![Employees](https://i.imgur.com/TMBBHhP.png) |![](https://i.imgur.com/iCRSfir.png)  |
|![Drivers](https://i.imgur.com/H4cBFay.png) |![](https://i.imgur.com/jJJSSNv.png) |




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

![](https://i.imgur.com/1W69mxl.png)

