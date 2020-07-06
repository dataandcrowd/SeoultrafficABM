# Documentation: Sensitivity
## Input Parameters: Experimental setup

This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below

* Non-resident cars: 2.5% 5% 10% 20%
* Emission Factors: 1, 5, 10, 20
* Health loss: .03, .05, .1, .15, .2


| Parameter           | Description                                       | Base value | Min    | Max   |
|---------------------|---------------------------------------------------|-----------:|-------:|------:|
| Non-registered Vehicles | Rate of Total registered vehicles in the CBD area | 5%        | 2.5%    | 20%   |
| Health loss         | Health loss function for each agent               | .1        | .03    | .2   |
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
| 0%        | 50.52  | 49.46  | 48.02  | 50.17 | 47.75 |
| 2.5%      | 59.50  | 60.03  | 60.34  | 60.90 | 61.36 |
| 5%        | 61.88  | 61.58  | 62.67  | 64.17 | 64.17  |
| 10%       | 62.25  | 61.84  | 63.35  | 64.43 | 64.43 |
| 20%       | 60.84  | 61.50  | 63.62  | 63.98 | 63.98 |


![](https://i.imgur.com/6StPV0M.png)


<br><br>


### Health Loss
**Q**. How much does the population at risk change by Health Loss parameters?
* The shape of the appearance and resurgence is proportionate to the parameter increase
* Below .05, less than 13% of the subway commuters experienced health problems due to high PM<sub>10</sub>
* In .1, the population at risk doubled the number of parameter .05
* Over .15, the population at risk soared to 100% at tis highest (around 10 times) when the commuters were exposed to high PM<sub>10</sub>
* This test indicates that the shape is similar between parameters and there is a tipping point between .1 and .15

| With 5% cars | Zero Cars |
|-----------|--------|
|![](https://i.imgur.com/Zha2t7i.png) |![](https://i.imgur.com/s8tAUhq.png) |
|![](https://i.imgur.com/ZX42O7W.png) |![](https://i.imgur.com/Zc9SKdQ.png) |
| Same Image but with different Y-axis compared to the Image above ↕ |Same Image but with different Y-axis compared to the Image above ↕ |
|![](https://i.imgur.com/zLzb9yz.png) |![](https://i.imgur.com/5ZRDY9m.png) |




**Q**. Why is there a difference between the subway commuters and resident drivers?

* While the subway commuters are constantly affected by the background PM<sub>10</sub> levels during their commute, the resident drivers have relatively short period of commute time during the weekend but have an extreme exposure to PM<sub>10</sub>, which result in rapid health loss over time. 

<br><br>

 **Choosing a Random Person**

* Red: Health of a random subway commuter
* Blue: Health of a random driver
* 붉은색 dip은 부분부분 나타나는 데 반해 파란색의 dip은 조금이지만 길게 나타남
* 전체적으로 지하철 승객의 건강이 더 빠르게 안좋아진 것으로 보임
* Zero Cars와 평균치에서 차이는 거의 드러나지 않았지만, 차량 운전자의 건강상태가 조금 다르게 나타난다. 

| With 5% cars | Zero Cars |
|-----------|--------|
|![](https://i.imgur.com/rhBHTWD.png) |![](https://i.imgur.com/UnMXKXy.png)
 |







## PM<sub>10</sub> Concentration


| Emission | Jongno | Sejong | Yulgok | Samil | Pirun |
|-----------------|--------|--------|--------|-------|-------|
| 1               | 43.4   | 43.2   | 42.8   | 42.8  | 42.9  |
| 5               | 60.0   | 60.1   | 62.0   | 61.6  | 61.7  |
| 10              | 81.4   | 81.2   | 85.6   | 85.3  | 85.2  |
| 20              | 123.3  | 122.6  | 134.1  | 132.7 | 133.4 |

![](https://i.imgur.com/XngGO12.png)
