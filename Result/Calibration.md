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
According to the 2018 AADT (Annual Average Daily Traffic) statistics published by KTDB(Korean Transport Database), I got various plots that I can calibrate with.

The raw data comes from the KTDB survey, where they measure the Origins and Destinations. To clean the data ready for the CBD area, I filtered passenger car counts and the destination subdistricts to include CBD areas.


The first figure shows the total car estimation by hours. The pink and blue line represents the inflow and outflow. You can see that the inflow rises from 5:00am, peaks at 8am, and gradually decreases thereafter. The barplots below is a reference that show the weekly and monthly flow in 2018.

**Calibration Idea**: I am thinking of controlling the inbound vehicles based on the hourly plot. since there are 10 points and the input time is based on minutes, I can disaggregate the hourly stats into minutes. For example, the inflow stats at 8am is 1600, which is 26.6 cars per minute.

![](https://i.imgur.com/bswStew.png)
![](https://i.imgur.com/HsrkkHc.png)
![](https://i.imgur.com/Bm5OLkM.png)


## Traffic Speed
* Speed
![](https://i.imgur.com/Ikgjq98.png)




