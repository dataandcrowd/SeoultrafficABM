# Documentation: Sensitivity
## Input Parameters: Experimental setup

This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below

* resident cars: 10%, 30%, 50%
* temporary cars - morning: min / max
* temporary cars - afternoon: min / max
* temporary cars - evening: min / max
* health loss?


| Parameter           | Description                                       | Base value | Min    | Max   |
|---------------------|---------------------------------------------------|-----------:|-------:|------:|
| Registered Vehicles | Rate of Total registered vehicles in the CBD area | 30%        | 10%    | 50%   |
| Morning Cars        | Morning Inbound cars by minute                    | 15         | 10     | 200   |
| Afternoon Cars      | Afternoon Inbound cars by minute                  | 10         | 10     | 200   |
| Evening Cars        | Evening Inbound cars by minute                    | 3          | 10     | 200   |
| Health loss         | Health loss function for each agent               | .03        | .01    | .05   |


## Design: A two step process
This study considers two sensitivity tests, locally and globally. Local sensitivity, also known as one-factor-at-a-time method, adjusts one factor while holding the others. Global sensitivity looks at all the possible combinations.


![](https://i.imgur.com/3Ncy2dt.png)


## Local Sensitivity
### Non-Resident Vehicle Sampling
* Question: How does the PM<sub>10</sub> differ by Sample Rates for Non-Resident Vehicles?






* Overall Trend
    * Cannot see a noticeable difference with this graph
    * Seldom difference in background PM<sub>10</sub>
    * Marginal difference in roadside PM<sub>10</sub>
    * Jongno roadside: 52µg/m<sup>3</sup> (10%), 51µg/m<sup>3</sup> (30%), 51µg/m<sup>3</sup> (50%), 52µg/m<sup>3</sup> (90%) 

| Car ratio | 10%   | 30%   | 50%   | 90%   |
|-----------|-------|-------|-------|-------|
| Jongno    | 52.32 | 51.66 | 51.73 | 52.9  |
| Sejong    | 67.55 | 63.54 | 62.31 | 60.07 |
| Yulgok    | 65.44 | 65.79 | 65.99 | 66.77 |
| Samil     | 64.55 | 64.99 | 65.26 | 65.83 |
| Pirun     | 65.69 | 63.85 | 62.47 | 60.48 |


![](https://i.imgur.com/Shi8jqB.jpg)



<br><br>


### Health Loss
**Q**. How much does the population at risk change by Health Loss parameters?
By the time the onset is discovered, the vast majority of agents have their nominal health decreased by 100, which is a third of the initial status. Thus, as the parameter rises, the earlier and more frequent the unwell population spike will appear. Health loss parameters `0.003`, `0.005`, `0.007`, `.01`, and `.02` have a total of 8, 10, 11, 13, and 14 peaks respectively. Additionally, since most of the agent's health centered around 100, there is a constant oscillation of risk population maintaining the figures e.g. almost 25% of the population at risk is observed in paramter `.01`. Also, the time when the population at risk peaked paralleled with the PM<sub>10</sub> exceeded 100µg/m<sup>3</sup>.

![](https://i.imgur.com/UE88cLU.png)
![](https://i.imgur.com/RMyuIzP.png)



In terms of health distribution, subway commuters experienced a sudden health decline between January 16th and 30th, and maintained until the end of the simulation. The great decline was due to the elevation of PM<sub>10</sub> that exceeded 100µg/m<sup>3</sup> about 2-3 days that did not happen in early January. The density of the curve varies can be seen by dates, but in fact varies by whether the agents are outdoors when PM<sub>10</sub> exceeds 100µg/m<sup>3</sup>. For example, the agents health on February 26th and March 12th is distributed across 0-110. 해당일의 PM<sub>10</sub> 값을 분석한 결과, 초과함.
![](https://i.imgur.com/j9FXvrb.png)
![](https://i.imgur.com/aQdJcnE.png)



<br><br>


**Picked a random subway commuter to observe health change**

This figure shows the temporal trend of health during the simulation by health loss parameters. It is seen that the person has experienced a sudden arrgravation of health on the 17th of January, recovered up to a third of its original health status, but lost again the next day. Its health status plateus just above 100 most of the time but undergoes a numer of oscillations. This shape occurs due to the recovery function which only recovers when health is below the 100 threshold. This could mean that a commuter, whose health deteriorates due to a sudden PM<sub>10</sub> rise can have acute health crises until s/he gets a medical treatment. 


![](https://i.imgur.com/8QWfel6.png)


**Picked a random driver to observe health change**

On the other hand, resident commuters who drive to their workplaces show a marginally decreasing trend of health during the simulation, although the raw data contains presents a noiser recover and decline. Thus, it is certain that, compared to the subway commuters, resident drivers experience less spikes of ambient PM<sub>10</sub> episodes due to the protection of buildings and transits as well as short commuting time.

![](https://i.imgur.com/7gUZni7.png)




## PM<sub>10</sub> Concentration

<!--
**Q**: Why isn't the number of inbound vehicles proportionate to the PM<sub>10</sub> values in the afternoon and evening?
**A**: In the morning hours, there are only resident vehicles and a few of randomly moving vehicles that are present in the study domain. This will allow as many vehicle agents per minute as possible into the domain. Since the model does not contain an outflow function for vehicles, it would take much time for the vehicles to enter the CBD once the road capacity is full. That is why the number of vehicles in the afternoon does not have a systematic PM<sub>10</sub> rise in proportionate to the number of vehicles. In the evening, the temporal shape of the PM<sub>10</sub> is very alike to the number of cars with only a less than 10µg/m<sup>3</sup> difference on average. This is because the outbound effect removes the non-residental cars during the night hours. The model bascially removes 10% of the total non-residental cars every minute between 10pm and 4am. Hence, 저녁차량 감소 효과 때문에 모양이 같아진다고 할 수 있다.

-->
