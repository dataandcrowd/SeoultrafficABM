# Calibration
## Road names in Seoul CBD

There are 10 entry points that enable vehicles to enter the CBD. The roads include *Chang Ui Moon-ro*, *Samcheong-ro*, *Changgyonggung-ro*, *Jongn-o*, *Dongho-ro*, *Samil-daero*, *Sogong-ro*, *Twegye-ro*, *Saemuman-ro*, and *Sajik-ro*.

* Inside NetLogo
    * Changuimun-ro: `Patch 14 181`
    * Samcheong-ro: `Patch 58 184`
    * Changgyeonggung-ro: `Patch 131 164`
    * Jongno: `Patch 149 99`
    * Dongho-ro: `Patch 140 66`
    * Samil-daero: `Patch 102 17`
    * Sogong-ro: `Patch 63 34`
    * Saemunan-ro: `Patch 18 86`
    * Sajik-ro: `Patch 2 103`

![](https://i.imgur.com/aQaxKPd.png)


## Traffic Count
According to the 2018 Traffic Monitoring Center at Seoul Metropolitan Government, I got various plots that I can calibrate with.

![](https://i.imgur.com/TIZLbml.png)



## Comparison with Roadside station

* By Emission Factors
    - The *N* assumes the emission from the number of vehicles
    - Thus, in the ABM, one vehicle will represent *N* number of vehicles
    - *N*(number of cars) in the Emission formula was tested in 1, 5, 10, and 20
    - Observation was imported from Jongno station so we will match the value with Jongno's result
    - `Emission 1` was comparable across road points with less than 1µg/m<sup>3</sup> difference, while `Emission 20` had almost twice as higher in all stations except Jongno
    - `Emission 5` in Jongno at 51.94 and this was the closest value for the observation value at 50.36.
    - The figures below show a more visual comparison between the emission factors
    - Scatter plots inform a correlation coeffient by emission factors: `r` score in `Emission 5` was the second highest. 
    - But as per the statistics and the time-series plot we think that `Emission 5` was the most appropriate value

| Emission | Jongno | pm10_rd |
|----------|--------|---------|
| 1        | 43.4   | 50.4    |
| 5        | 60.0   | 50.4    |
| 10       | 81.4   | 50.4    |
| 20       | 123.3  | 50.4    |
**pm10_rd: Observation data**


![](https://i.imgur.com/27GZwnX.png)
