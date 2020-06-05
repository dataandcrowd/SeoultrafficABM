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
### Resident Vehicle Sampling
* Question: How does the PM<sub>10</sub> differ by Sample Rates for Resident Vehicles?
* We generated 10%, 30%, and samples of resident vehicles for three fuel types Gasoline, Diesel, and LPG. 

| Fuel Type | 10% | 30% | 50%  |
|-----------|-----|-----|------|
| Gasoline  | 156 | 468 | 780  |
| Diesel    | 264 | 792 | 1320 |
| LPG       | 20  | 87  | 145  |
| Total Count | 440 | 1347 | 2245 |


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

![Subway](https://i.imgur.com/w0WnFO1.png)

In terms of health distribution, subway commuters experienced a sudden health decline between January 16th and 30th, and maintained until the end of the simulation. The great decline was due to the elevation of PM<sub>10</sub> that exceeded 100µg/m<sup>3</sup> about 2-3 days that did not happen in early January. The density of the curve varies can be seen by dates, but in fact varies by whether the agents are outdoors when PM<sub>10</sub> exceeds 100µg/m<sup>3</sup>. For example, the agents health on February 26th and March 12th is distributed across 0-110. 해당일의 PM<sub>10</sub> 값을 분석한 결과, 초과함.
![employees](https://i.imgur.com/qxOPNUW.png)



![Drivers](https://i.imgur.com/GaUvw40.png)
![](https://i.imgur.com/tGJXOba.png)

<br><br>


**Picked a random subway commuter to observe health change**

This figure shows the temporal trend of health during the simulation by health loss parameters. It is seen that the person has experienced a sudden arrgravation of health on the 17th of January, recovered up to a third of its original health status, but lost again the next day. Its health status plateus just above 100 most of the time but undergoes a numer of oscillations. This shape occurs due to the recovery function which only recovers when health is below the 100 threshold. This could mean that a commuter, whose health deteriorates due to a sudden PM<sub>10</sub> rise can have acute health crises until s/he gets a medical treatment. 

![](https://i.imgur.com/X7araPi.png)


**Picked a random driver to observe health change**

On the other hand, resident commuters who drive to their workplaces show a marginally decreasing trend of health during the simulation, although the raw data contains presents a noiser recover and decline. Thus, it is certain that, compared to the subway commuters, resident drivers experience less spikes of ambient PM<sub>10</sub> episodes due to the protection of buildings and transits as well as short commuting time.

![](https://i.imgur.com/38UdfuW.png)





## PM<sub>10</sub> Concentration
* Temporal: morning
![](https://i.imgur.com/8mUSSL7.png)

* Temporal: afternoon
![](https://i.imgur.com/o9TLnPj.png)

* Temporal: evening
![](https://i.imgur.com/K9sFdob.png)


**Q**: Why isn't the number of inbound vehicles proportionate to the PM<sub>10</sub> values in the afternoon and evening?
**A**: In the morning hours, there are only resident vehicles and a few of randomly moving vehicles that are present in the study domain. This will allow as many vehicle agents per minute as possible into the domain. Since the model does not contain an outflow function for vehicles, it would take much time for the vehicles to enter the CBD once the road capacity is full. That is why the number of vehicles in the afternoon does not have a systematic PM<sub>10</sub> rise in proportionate to the number of vehicles. In the evening, the temporal shape of the PM<sub>10</sub> is very alike to the number of cars with only a less than 10µg/m<sup>3</sup> difference on average. This is because the outbound effect removes the non-residental cars during the night hours. The model bascially removes 10% of the total non-residental cars every minute between 10pm and 4am. Hence, 저녁차량 감소 효과 때문에 모양이 같아진다고 할 수 있다.




## Spatial Output
The maps below shows the average and maximum PM<sub>10</sub> concentrations by an hourly aggregation on the 2nd of January, 2018. The background PM<sub>10</sub> maintained between 30 and 60µg/m<sup>3</sup> in the morning rush hours from 5am to the early afternoon hours, although the 01:00 was quite unusual. While the background PM<sub>10</sub> showed a small difference between the average and maximum, the figures in the maximum roadside was twice as higher than the average. The average PM<sub>10</sub> was ranged between 60-90µg/m<sup>3</sup> before noon, particularly at *Sejong daero (near Kyongbok Palace)*, *Jongno*, and *Samil daero*. However, the maximum PM<sub>10</sub> shows that all the roads had experienced over 60µg/m<sup>3</sup>, and the junctions in larger roads (Daero) have exceeded 90µg/m<sup>3</sup> during rush hours. It is carefully speculated that the junctions produce more PM<sub>10</sub> from the frequency of the driver's ac/de-celeration behaviour. According to this model, PM<sub>10</sub> can possibly go up to 300µg/m<sup>3</sup> by a minute scale.


Looking closer to a specific time, 10:00am on January the 2nd, there was a spatial variation on PM<sub>10</sub> in the CBD. Jongno and Samil were compared. Jongno is a 8-lane road that has inbound vehicles from the east and west. It is situated far from the junction but selected because a monitoring station was installed. Samil is a junction that expects inbound vehicles from the south. In the time-series plot, the difference between the two stations was observed in the average levels 왜냐하면 많은 차량들이 지나가는 시기에는 그 수치가 비슷하지만 러시아워가 지나가더라도 삼일대로에는 지속적인 차량통행이 있는 반면 종로지역에는 그것보단 조용했기 때문이다.

평균치를 살펴보면, 100µg/m<sup>3</sup>을 넘는 기간도 종로는 이틀, 삼일은 닷새로 차이가 있으며 1월초순의 평균 PM<sub>10</sub>이 50-75µg/m<sup>3</sup> 사이에 머무른 데 반해, 종로는 25-60µg/m<sup>3</sup> 사이에 분포하였다. 그래서 같은 날이라도 종로측정소 주변으로 통근하는 사람들의 건강 위해도가 삼일대로보다 낮을 수 있다는 것이며, 조금 더 확장하면 차량들이 감/가속할 가능성이 많은 교차로 지역 주변으로 다닐시에는 각별한 주의가 필요하다.


* Mean PM<sub>10</sub> by hours 
![](https://i.imgur.com/MeFDvj1.png)


* Max PM<sub>10</sub> by hours 
![](https://i.imgur.com/TkjoHaK.png)


* Mean PM<sub>10</sub> at 10PM + ts daily plot
![](https://i.imgur.com/6vkIpJI.png)


* Max PM<sub>10</sub> at 10PM + ts daily plot
![](https://i.imgur.com/6NDCeRX.png)

