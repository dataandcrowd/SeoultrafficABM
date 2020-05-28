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

![](https://i.imgur.com/MAcTVvg.png)

* PM<sub>10</sub> by Sample Rates
    * Seldom difference in background PM<sub>10</sub>
    * Marginal difference in roadside PM<sub>10</sub>
    * Jongno roadside: 68µg/m<sup>3</sup> (10%), 71µg/m<sup>3</sup> (30%), 74µg/m<sup>3</sup> (50%) 
    * Seoul Station roadside: 51µg/m<sup>3</sup> (10%), 50µg/m<sup>3</sup> (30%), 51µg/m<sup>3</sup> (50%)

<!--
![Boxplot](https://i.imgur.com/Abo0Jyp.png)

| Rate | Mean PM10_mean | Jongno Back_mean | Jung Back_mean | Jongno Kerb_mean | Seoul Stn_mean | Mean PM10_sd | Jongno Back_sd | Jung Back_sd | Jongno Kerb_sd | Seoul Stn_sd |
|--------------------|----------------|------------------|----------------|------------------|----------------|--------------|----------------|--------------|----------------|--------------|
| 10%                | 49.82          | 46.39            | 46.38          | 68.97            | 51.19          | 25.41        | 25.3           | 25.29        | 48.51          | 32.52        |
| 30%                | 49.57          | 46.38            | 46.39          | 71.57            | 50.62          | 25.39        | 25.3           | 25.31        | 49.67          | 31.7         |
| 50%                | 49.47          | 46.38            | 46.4           | 74.14            | 51.51          | 25.38        | 25.3           | 25.33        | 50.57          | 32.5         |

-->
<br><br>


### Health Loss
* Question: How much does the population at risk change by Health Loss parameters?
* Health-loss: .005
    * 8 times peak happened during the simulation
    * Once the risk population reaches 100% (all unwell) and falls, it tends to stay near 15%
    * This means that 15% tend to experience a recurrent after being sick
* Health-loss: .01
    * 12 times peak happened during the simulation
    * 25% sick people were identified after the population at risk first peaked
* Health-loss: .03 and 0.5
    * Most people got sick after January 20th (19000 ticks)

![Subway](https://i.imgur.com/eB7NKgd.png)
![Drivers](https://i.imgur.com/uJdTduL.png)

<br><br>


* Picked a random subway commuter to observe health change
<!-- ![](https://i.imgur.com/whlrUxG.png) -->
![](https://i.imgur.com/9T68SXW.png)


* Picked a random driver to observe health change
<!-- ![](https://i.imgur.com/CSYqNDB.png) -->
![](https://i.imgur.com/P6nGTPO.png)



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
* Aggregated from minutes to hours


* Mean PM<sub>10</sub>
![](https://i.imgur.com/K7SCJty.png)


* Max PM<sub>10</sub>
![](https://i.imgur.com/J2acpRq.png)

### January 2nd 10:00
* Mean PM<sub>10</sub>
![](https://i.imgur.com/o4gJPKP.png)


* Max PM<sub>10</sub>
![](https://i.imgur.com/h35UjEE.png)

