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
| Morning Cars        | Morning Inbound cars by minute                            | 15         | 5      | 30    |
| Afternoon Cars      | Afternoon Inbound cars by minute                            | 10         | 5      | 20    |
| Evening Cars        | Evening Inbound cars by minute                            | 3          | 3      | 9     |
| Health loss         | Health loss function for each agent               | .00005     | .00001 | .0001 |



## Expected outcome

![](https://i.imgur.com/5Ho2tgW.png)
