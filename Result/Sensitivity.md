# Sensitivity Analysis 작성하기
## Introduction
Here, I calibrate my simulation model to data on roadside PM<sub>10</sub> from NIER under the assumption that the monitoring stations have well reflected the traffic to the observation. We focus on model solutions which take into consideration the fraction of vehicles, the number of temporary visiting cars, and the control of traffic signals, with the intension of exploring the sensitivity of the system to the actual fraction of the population vulnerable to acute air pollution rise.


Although this simulation does not have the patient’s health status to compare with, the relationship between the traffic volume and the traffic control can be used to determine how many people will require hospitalisation after being continuously exposed to the frequent PM<sub>10</sub> exceedance that harms human health. 


## Method: Latin Hypercube Sampling
When performing a sensitivity analysis over many parameters, it is very much important to understand the combination of each parameters to observe the difference from the input variable values (Gangel et al 2014).
Full factorial design can be an ideal method to visualise the model behaviour in a systematic way (Thiele et al., 2014), however, the number of parameters have to be kept small enough to get the result without performing 2<sup>k</sup>-1 number of simulations, which would be impractical.


One way to avoid full factorial experiment but to get a valuable result is using a sampling method that would reduce the dimensionality of the parameter combination. Amongst many sampling methods, this study experimented **Latin Hypercube sampling**. Latin Hypercube sampling (LHS) is a stratified sampling method without a replacement (Thiele et al., 2014). 


LHS was developed by McKay, Beckman and Conovor (1979), which was similar to the time when the ABM was founded. Since the birth and evolution happened around the same time, they never had a chance to cross reference each other's work (Gangel et al., 2013). 


The intention is to recreate a valuable output as the full factorial with fewer samples. The key to this method is to stratify the parameters at an equal interval, and as the term *Latin Square* stands <!-- an n × n array filled with n different symbols, each occurring exactly once in each row and exactly once in each column -->, the sample should be collected once in each row and column. As an illustration below, Figure I is an example of random sampling (monte-carlo) and II is an example of Latin Hypercube sampling. As the monte-carlo sampling picks a sample regardless of its location, this model requires less memory during the sampling process. LHS, on the other hand, takes more memory because it has to remember which location the sample in the previous stratification had chosen.(어디에 "불확실성도 나름 컨트롤 수 있음" 추가) Nevertheless, 메모리로 차지하는 용량이 랜덤샘플 많이 n 갯수가 적기 때문에 결과적으로 비교하자면 LHS가 차지하는 스토리지는 작은 것이다. 보다 자세한 수식은 [Gangel et al. (2014)](https://sci-hub.tw/10.1080/15427560.2013.791296?key=be0ef6915d1b2200a248b7195d01ef22)를 참고하길 바란다.

![](https://i.imgur.com/qNtqDfx.png)


For an ABM research, 어떠한 변수는 continuous할 수도 있고 discrete 할수도 있는데, LHS는 모두 시뮬레이션이 가능하다. 또한 HPC머신이 아무리 크더라도 넷로고 가용 노드가 하나이고 iteration을 거듭할 수록 캐쉬가 적재되어 속도가 느려지기 때문에 batch 허용시간을 초과하여 실패할 가능성도 높아지끼 때문에 LHS가 최적의 조합이 될 것이다.


이 연구는 먼저 어떠한 변수가 더 민감한지를 확인하기 위해 local sensitivity 혹은 one-factor-at-a-time (OAT) sensitivity 분석을 먼저 시행하고, 그 다음 변수들간의 조합을 고려하는 Global sensitivity를 실시한다. Global sensitivity has its input variables varied over a full range of possible values. That is, GS not only takes the main effects into consideration but also considers interaction effects between the main effect, which could not be discovered by local sensitivity.



## Preliminaries: Experimental setup
This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below



## Local Sensitivity: OAT
This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below. 


* resident cars: min / max
* temporary cars - morning: min / max
* temporary cars - afternoon: min / max
* temporary cars - evening: min / max
* health loss?


| Parameter           | Description                                       | Base value | Min    | Max   |
|---------------------|---------------------------------------------------|------------|--------|-------|
| Registered Vehicles | Rate of Total registered vehicles in the CBD area | 0.3        | 0.1    | 0.5   |
| Morning Cars        | Morning Inbound cars by minute                            | 15         | 5      | 30    |
| Afternoon Cars      | Afternoon Inbound cars by minute                            | 10         | 5      | 20    |
| Evening Cars        | Evening Inbound cars by minute                            | 3          | 3      | 9     |
| Health loss         | Health loss function for each agent               | .00005     | .00001 | .0001 |



## Global Sensitivity: Regression analysis
### Partial (rank) correlation coefficient

Correlation analysis measures the linear relationship between the input and the output variables. The result is clear. However, **Partial correlation** is used to correlate two or more input variables, but want to understand the strength and the direction of each variable without being affecting each other (Saltelli et al. 2004).


파셜코릴리에션도 코릴레이션과 마찬가지로 두가지 측정방법이 있는데, 두 변수가 선형관계를 보인다면 피어슨 상관관계를 사용해도된다. 그렇지만 non-linear 관계가 보인다면(expected), then partial rank correlation needs to be used.

### Codes

코드는 다음과 같다.
```ruby=
test = 1:10

```

### Results
결과는 다음과 같다.