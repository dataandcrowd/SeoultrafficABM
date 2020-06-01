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

| Car ratio | Jongno | Sejong | Yulgok | Samil | Pirun |
|-----------|--------|--------|--------|-------|-------|
| 10%       | 52.32  | 67.55  | 65.44  | 64.55 | 65.69 |
| 30%       | 51.66  | 63.54  | 65.79  | 64.99 | 63.85 |
| 50%       | 51.73  | 62.31  | 65.99  | 65.26 | 62.47 |
| 90%       | 52.9   | 60.07  | 66.77  | 65.83 | 60.48 |

![](https://i.imgur.com/Shi8jqB.jpg)



<br><br>


### Health Loss
**Q**. How much does the population at risk change by Health Loss parameters?
By the time the onset is discovered, the vast majority of agents have their nominal health decreased by 100, which is a third of the initial status. Thus, as the parameter rises, the earlier and more frequent the unwell population spike will appear. Health loss parameters `0.003`, `0.005`, `0.007`, `.01`, and `.02` have a total of 8, 10, 11, 13, and 14 peaks respectively. Additionally, since most of the agent's health centered around 100, there is a constant oscillation of risk population maintaining the figures e.g. almost 25% of the population at risk is observed in paramter `.01`. 그리고 전체 인구가 피크를 찍을 때는 항상 PM<sub>10</sub>이 100µg/m<sup>3</sup>을 넘었을 때와 거의 패럴랠하다.

![Subway](https://i.imgur.com/w0WnFO1.png)
![Drivers](https://i.imgur.com/GaUvw40.png)

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



### January 2nd, 2018 by hours
The maps below shows the average and maximum PM<sub>10</sub> concentrations by an hourly aggregation on the 2nd of January, 2018. The background PM<sub>10</sub> maintained between 40 and 80µg/m<sup>3</sup> in the morning rush hours from 7am to 11am.

주로 교차로와 대로변의 PM10이 160-200이며, 분당으로 계산했을때는 최대 400까지 간다.
교차로는 아무래도 신호대기와 출발하면서 미세먼지 발생량을 높이기 때문이며 대로변에는 진입차량의 증가로 컨제스천이 생긴 까닭이다.

10시의 사례를 보면 도로/비도로, 평균/최대값 



* Mean PM<sub>10</sub>
![](https://i.imgur.com/K7SCJty.png)


* Max PM<sub>10</sub>
![](https://i.imgur.com/J2acpRq.png)

### January 2nd 10:00
* Mean PM<sub>10</sub>
![](https://i.imgur.com/o4gJPKP.png)


* Max PM<sub>10</sub>
![](https://i.imgur.com/h35UjEE.png)

