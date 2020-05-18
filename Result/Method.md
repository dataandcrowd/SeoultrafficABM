Methodology: Non-exhaust Emission and Dilution
===

## Methodology: Non-exhaust Emission and Dilution
Non-exhaust emissions depend on the weight of the vehicle, how congested the traffic is, and speed. It would be likely that air quality can be worse during rush hours when all types of vehicles idling in huge traffic congestion.


Recently, the [Air Quality Experts (2019)](https://uk-air.defra.gov.uk/assets/documents/reports/cat09/1907101151_20190709_Non_Exhaust_Emissions_typeset_Final.pdf) argued that non-exhaust emissions are equally exacerbating human health but there is less regulation compared to that of exhaust emission. This report and the publication from the [EEA (2019)](https://www.eea.europa.eu/publications/emep-eea-guidebook-2019/part-b-sectoral-guidance-chapters/1-energy/1-a-combustion/1-a-3-b-vi/view) both agreed that non-exhaust emission is equally important as exhaust emission and that there are four main sources that contribute to air pollution (Directly quoted from (Amato, 2018)):
* Direct brake wear: the fraction of pad, disc, and clutch wear particles that are directly airborne
* Direct tire wear: the fraction of TWPs that are directly airborne 
* Direct road wear: the fraction of road wear particles (RWPs) that are directly airborne
* Road (dust) suspension: any particle on (paved) road surface that is suspended to air by vehicles or wind, including deposited brake/tire/road wear particles and other depos- ited particles from various origin (salt, sand, exhaust, secondary, other mineral dust, etc.)


<!--배기가스의 규제로 인한 차량의 배기가스 배출보다는 운전자의 성향에 따른 미세먼지 배출이 훨씬 더 중요해졌다고--> 


As such, this study grouped emission sources into three categories: tyre wear, brake wear, and road surface wear ([Air Quality Experts, 2019](https://uk-air.defra.gov.uk/assets/documents/reports/cat09/1907101151_20190709_Non_Exhaust_Emissions_typeset_Final.pdf)). Some publications include resuspension as a fourth contributor from the emission side, but for this study, resuspension part will be articulated in the dispersion section. In the following sections, we will look closer to the algorithms by each vehicle components.



![algorithm](https://i.imgur.com/50iCqKN.jpg)


### 1. A Simplified Algorithm to Measure Non-exhaust Emission
The total emission attributed to non-exhausted sources can be articulated with the following equation.


\begin{align}
E_{total} = E_{Tyre} + E_{Brake} + E_{Road} + E_{Resus}
\end{align}

* $E_{Total}$: the total non-exhuast PM emission
* $E_{Tyre}$: PM emission from tyre wear
* $E_{Brake}$: PM emission from brake wear
* $E_{Road}$: PM emission due to road abtrasion
* $E_{Resus}$: Corresponds to resuspension emissions


<br>

#### Tyre Wear
\begin{align}
E_{Tyre} = \sum_{i=1}N_j \times M_j \times EF_{Tyre,j} \times F_{s,i} \times S(V)
\end{align}


* $TE$: Total emission for the defined time period and spatial boundary (g)
* $N_j$: Number of vehicles in category $j$ within the defined spatial boundary
* $M_j$: mileage (km) driven by each vehicle in category $j$ during the defined time period
* $EF_{Tyre, j}$ = TSP mass emission factor for vehicles in category $j$ (g/km)
* $F_{s,i}$ = mass fraction of Particles that can be attributed to particle size class $i$
* $S(V)$: Correction factor for a mean vehicle travelling speed V

<br>

From the model settings section<!-- Cite the section-->, we know that a vehicle represents 10 vehicles in reality, and each patch (or grid cell) represents 30m resolution. Since there is a discrepancy on the units between the scientific reports (g) and the monitoring stations (µg), it is also worthwhile to align the units. Here we convert km to 30m, grams to micrograms, and always multiply 10 to give accurate results.


According to the table below, one passenger car (j) has an emission factor of .0107 (.0067-.0162) (g/km). In NetLogo, this can be converted to 32.1 per patch with an uncertainty range of 20.1 - 48.6. The size distribution $F_{s,i}$ can be converted by a fraction of 6 for PM<sub>10</sub>. 


In terms of vehicle speed, EEA sets the parameter *V* by 1.39 below 40km/h, and declining effect of (-0.00974 $\times$ V + 1.78) between 40-90km/h. This slope speculates that speed associates with traffic mass.

**Table** *TSP emission factors for source category road vehicle tyre wear* (European Environment Agency, 2019)
| Vehicle class (j)   | TSP emission factor (g/km) | Uncertainty range |
|---------------------|----------------------------|-------------------|
| Two-wheel vehicles  | 0.0046                     | .0042 - .0053     |
| ==Passenger cars==  | ==0.0107==                | ==.0067 - .0162==  |
| Light-duty trucks   | 0.0169                     | .0088 - .0217     |
| Heavy-duty vehicles | Separate Equation          | .0227 - .0898     |


<br>

**Table** *Size distribution of tyre wear particles*
| Particle size class (i) | Mass Fraction of TSP |
|-------------------------|------------------------|
| TSP                     | 1                      |
| PM<sub>10</sub>         | 0.6                    |
| PM<sub>2.5</sub>        | 0.42                   |
| PM<sub>1</sub>          | 0.06                   |
| PM<sub>0.1</sub>        | 0.048                  |


<br>

**Equation** *Speed Correction*

| Velocity (km/h) | Factors (V)         |
|-----------------|---------------------|
| $V$ < 40        | 1.39                |
| 40≤ $V$ ≤90     | -0.00974 $\times$ $V$ + 1.78 |
| $V$ >90         | 0.902               |

![](https://i.imgur.com/CLrUsx6.png)


#### Brake wear
The equation for brake wear is exactly the same as tyre wear, which only has a few differences in parameters.

\begin{align}
E_{Brake} = \sum_{i=1}N_j \times M_j \times EF_{Br,j} \times S(V)
\end{align}

* $E_{Brake}$: Total emission for the defined time period and spatial boundary (g/km)
* $N_j$: Number of vehicles in category $j$ within the defined spatial boundary
* $M_j$: mileage (km) driven by each vehicle in category $j$ during the defined time period
* $EF_{Br,j}$ = TSP mass emission factor from road wear for vehicles in category $j$ (g/km)
* $F_{s,i}$ = mass fraction of TSP that can be attributed to particle size class $i$
* $S(V)$: Correction factor for a mean vehicle travelling speed V


As mentioned in the Tyre wear section, emission factors for passenger cars has to fit to a unit set in the virtual environment. Thus the EF value .0075(g/km) converts to 21.5(µg/patch). The size distribution of PM<sub>10</sub> is 0.98. The brake wear, particularly from the linings, are worn out quickly when the driver acclerates and decelerates frequently, and this tends to happen when the traffic volume is high.

<br>

**Table** *TSP emission factors for source category road vehicle brake wear*
| Vehicle class (j)   | TSP emission factor (g/km) | Uncertainty range |
|---------------------|----------------------------|-------------------|
| Two-wheel vehicles  | 0.0037                     | .0022 - .0050     |
| ==Passenger cars==  | ==0.0075==                 | ==.0044 - .0010==     |
| Light-duty trucks   | 0.0117                     | .0088 - .0145     |
| Heavy-duty vehicles | Separate Equation          | .0235 - .0420     |


<br>

**Table** *Size distribution of brake wear particles*
| Particle size class (i) | Mass Fraction of TSP |
|-------------------------|------------------------|
| TSP                     | 1                      |
| PM<sub>10</sub>         | 0.98                   |
| PM<sub>2.5</sub>        | 0.39                   |
| PM<sub>1</sub>          | 0.10                   |
| PM<sub>0.1</sub>        | 0.08                   |


<br>

**Equation** *Speed Correction*

| Velocity (km/h) | Factors (V)         |
|-----------------|---------------------|
| $V$ < 40        | 1.67                |
| 40≤ $V$ ≤95     | -0.0270 $\times$ $V$ + 2.75 |
| $V$ >95         | 0.185               |


![](https://i.imgur.com/0h8XARo.png)

<br>


#### Surface wear (i.e. Road Abrasion)
Road surface wear is caused by the appearance of wheel marks when the vehicle passes or destroyed by heavy vehicles. The formula is as follows.


\begin{align}
E_{Surface} = \sum_{i=1}N_j \times M_j \times EF_{SW,j} 
\end{align}

* $E_{Surface}$: Total emission for the defined time period and spatial boundary (g)
* $N_j$: Number of vehicles in category $j$ within the defined spatial boundary
* $M_j$: mileage (km) driven by each vehicle in category $j$ during the defined time period
* $EF_{SW,j}$ = TSP mass emission factor from surface wear for vehicles in category $j$ (g/km)
* $F_{s,i}$ = mass fraction of TSP that can be attributed to particle size class $i$

0.0150 -> 45µg/m<sup>3</sup> in NetLogo.



**Table** *TSP emission factors from road surface wear*
| Vehicle class ($j$)   | TSP emission factor (g/km) |
|---------------------|----------------------------|
| Two-wheel vehicles  | 0.0060                     |
| Passenger cars      | 0.0150                     |
| Light-duty trucks   | 0.0150                     |
| Heavy-duty vehicles | 0.0760                     |


<br>

**Table** *Size distribution of raod surface wear particles*
| Particle size class ($i$) | Mass fraction ($f_{R,i}$) of TSP |
|-------------------------|-----------------------------|
| TSP                     | 1                           |
| PM<sub>10</sub>         | 0.5                         |
| PM<sub>2.5</sub>        | 0.27                        |


### 2. Dispersion and Dilution
There are many dispersion models applicable for exhaust emissions, but according to the works of  [Beevers et al., (2013)](https://www.nature.com/articles/jes20136), [Panko et al., (2019)](https://www.mdpi.com/2073-4433/10/2/99) so far, many things related to non-exhaust dispersion remain unknown. [University of California, Riverside (UCR) team](https://ww2.arb.ca.gov/resources/documents/brake-tire-wear-emissions) is conducting an on-going project to understand the severity of non-exhaust emission at nearer roads, and they are attempting to apply the non-exhaust parameters in their existing dispersion model but we don't know what the result is yet. Thus, this study attempted to disperse the pollution with the embedded spread function, `in-cone`, in NetLogo, as resuspension.

The dilution process really differs by various conditions such as weather or water-spraying trucks, but in general, takes 110 seconds to dilute completely ([Nikolova et al., 2014](http://aaqr.org/files/article/592/13_AAQR-13-06-OA-0221_145-155.pdf)). In NetLogo, this is assigned as 2 ticks.



### 3. Application in NetLogo
In NetLogo, a passenger car will emit  

* One passenger car
    * Tyre Wear:
    * Brake Wear
    * Surface Wear: 



[Dillution paper - 110 seconds](http://aaqr.org/files/article/592/13_AAQR-13-06-OA-0221_145-155.pdf)




![](https://i.imgur.com/KN5p1fH.png)
![](https://i.imgur.com/njMHMdN.png)
