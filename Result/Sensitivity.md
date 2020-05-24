# Sensitivity analysis
## Design
This study considers two sensitivity tests, locally and a globally. Local sensitivity, also known as one-factor-at-a-time method, adjusts one factor while holding the others. Global sensitivity looks at all the possible combinations.


![](https://i.imgur.com/3Ncy2dt.png)

## Input Parameters: Experimental setup

This study selected three parameters: Registered Vehicles, Morning Inbound Cars, Afternoon Inbound Cars, and Evening Inbound Cars. The value ranges, base value, and the interval between each parameter value covered by the sensitivity analysis are in the table below

* resident cars: 10%, 30%, 50%
* temporary cars - morning: min / max
* temporary cars - afternoon: min / max
* temporary cars - evening: min / max
* health loss?


| Parameter           | Description                                       | Base value | Min    | Max   |
|---------------------|---------------------------------------------------|------------|--------|-------|
| Registered Vehicles | Rate of Total registered vehicles in the CBD area | 0.3        | 0.1    | 0.5   |
| Morning Cars        | Morning Inbound cars by minute                    | 15         | 5      | 30    |
| Afternoon Cars      | Afternoon Inbound cars by minute                  | 10         | 5      | 20    |
| Evening Cars        | Evening Inbound cars by minute                    | 3          | 3      | 9     |
| Health loss         | Health loss function for each agent               | .03        | .01    | .05   |



## Expected outcome

<!--![](https://i.imgur.com/5Ho2tgW.png) -->

### Registered Vehicles
#### Profile
We generated 10%, 30%, and samples of resident vehicles for three fuel types Gasoline, Diesel, and LPG. 
* For a 10% sample,
    * 156 Gasoline vehicles, 
    * 264 Diesel vehicles, 
    * 20 LPG vehicles were created
* For a 30% sample, 
    * 468 Gasoline vehicles, 
    * 792 Diesel vehicles, 
    * 87 LPG vehicles were created
* For a 50% sample, 
    * 780 Gasoline vehicles, 
    * 1320 Diesel vehicles, 
    * 145 LPG vehicles were created.

#### Overall PM<sub>10</sub> Trend
![Line](https://i.imgur.com/2ltFMpc.png)




#### PM<sub>10</sub> by Sample Rates
![Boxplot](https://i.imgur.com/Abo0Jyp.png)

| resident_car_ratio | Mean PM10_mean | Jongno Back_mean | Jung Back_mean | Jongno Kerb_mean | Seoul Stn_mean | Mean PM10_sd | Jongno Back_sd | Jung Back_sd | Jongno Kerb_sd | Seoul Stn_sd |
|--------------------|----------------|------------------|----------------|------------------|----------------|--------------|----------------|--------------|----------------|--------------|
| 10%                | 49.82          | 46.39            | 46.38          | 68.97            | 51.19          | 25.41        | 25.3           | 25.29        | 48.51          | 32.52        |
| 30%                | 49.57          | 46.38            | 46.39          | 71.57            | 50.62          | 25.39        | 25.3           | 25.31        | 49.67          | 31.7         |
| 50%                | 49.47          | 46.38            | 46.4           | 74.14            | 51.51          | 25.38        | 25.3           | 25.33        | 50.57          | 32.5         |
