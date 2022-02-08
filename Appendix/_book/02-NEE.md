# Non-Exhaust Emissions and Dispersion

Recent studies from the UK and Europe equally documented the main sources of non-exhaust emissions such as tyre wear, brake wear, and road surface wear [@AirQualityExpertGroup2019; @EMEP/EEA2019]. A few papers included resuspension as a fourth contributor, but this study articulates resuspension in the dispersion section below. Figure \@ref(fig:nee) illustrates the non-exhaust emissions, dispersion, and dilution.

<div class="figure" style="text-align: center">
<img src="Figs/method_nee.png" alt="Graphical explanation of non-exhaust emissions, dispersion, and dilution" width="80%" />
<p class="caption">(\#fig:nee)Graphical explanation of non-exhaust emissions, dispersion, and dilution</p>
</div>

According to @EMEP/EEA2019, the total of non-exhaust emissions is estimated with the following equation \@ref(eq:nee-total).

\begin{equation}
(\#eq:nee-total)
NEE_{total}=NEE_{Tyre}+NEE_{Brake}+NEE_{Road}
\end{equation}

* NEE~Total~: the total non-exhaust PM emissions
* NEE~Tyre~: PM emissions from tyre wear
* NEE~Brake~: PM emissions from brake wear
* NEE~Road~: PM emissions due to road abrasion

Each component will be investigated in the following sections.

## Tyre Wear

\begin{equation}
  NEE_{Tyre}=\sum_{i=1}^{n}N_j \times M_j \times EF_{Tyre,j} \times F_{s,i} \times S(V)
  (\#eq:nee_tyre)
\end{equation}

- NEE~Tyre~: Total emissions for the defined time and spatial boundary (g)
- N~j~: Number of vehicles in category _j_ within the defined spatial boundary
- M~j~: Mileage (km) driven by each vehicle in category j during the defined time _(not used)_
- EF~Tyre~, j: TSP mass emission factor for vehicles in category _j_ (g/km)
- F~s,i~: Mass fraction of particles that can be attributed to particle size class _i_
- S(V): Correction factor for a mean vehicle travelling speed _V_

This equation was designed to measure the bulk emissions from a number of vehicles (e.g. 20g/km from 10 vehicles in a 5km trip between 10:00-15:00). However, it is inappropriate to measure the emissions of vehicles that have separate journeys. To find a solution, this study manipulates N~j~ at an appropriate number based on sensitivity analysis, converts emission levels from g/km to µg/30m (equal to a size of one patch in the simulation), and spatial and temporal units at 30m and on a minute-by-minute basis. For example, one passenger car (j) has an emission factor of .0107 (.0067-.0162) (g/km) (see Table 1), and to get an estimate of PM~10~, the size distribution F~s,i~ converts the TSP estimate to PM~10~ multiplying by a fraction of 0.6 (see Table 2). This can result in 32.1µg/m3 per patch with an uncertainty range of 20.1 - 48.6.


In terms of vehicle speed, EEA sets the parameter V at 1.39 below 40km/h, and declining effect of (-0.00974 * V + 1.78) between 40-90km/h. It assumes that frequent brakes and accelerations are expected below 40km/h but less as the vehicle speeds up. Mileage (M~j~) was not used for this study as this study focuses on the emission and the immediate dispersion of particles, not the activity of vehicles. 

```{=html}
<template id="e0772012-95c1-4f3d-b7a7-2f44843be7cc"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d1525b0e{}.cl-d14f6d4a{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d14f766e{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d14f8c3a{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c44{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c45{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c46{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c4e{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c4f{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c50{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c51{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c58{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c59{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c5a{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c5b{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c5c{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c62{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d14f8c63{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d1525b0e'>
```
<caption class="">

(\#tab:table-emission-factors)TSP (Total Suspended Particles) emission factors for source category road vehicle tyre wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d14f8c63"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Vehicle class (j)</span></p></td><td class="cl-d14f8c5c"><p class="cl-d14f766e"><span class="cl-d14f6d4a">TSP emission factor (g/km)</span></p></td><td class="cl-d14f8c62"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Uncertainty range</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d14f8c44"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Two-wheeled vehicles</span></p></td><td class="cl-d14f8c45"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0046</span></p></td><td class="cl-d14f8c3a"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0042-0.0053</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d14f8c46"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Passenger cars</span></p></td><td class="cl-d14f8c4f"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0107</span></p></td><td class="cl-d14f8c4e"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0067-0.0162</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d14f8c50"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Light-duty trucks</span></p></td><td class="cl-d14f8c51"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0169</span></p></td><td class="cl-d14f8c58"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0088-0.0217</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d14f8c5b"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Heavy-duty vehicles</span></p></td><td class="cl-d14f8c59"><p class="cl-d14f766e"><span class="cl-d14f6d4a">Separate equation</span></p></td><td class="cl-d14f8c5a"><p class="cl-d14f766e"><span class="cl-d14f6d4a">0.0227-0.0898</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="f61ef612-1b9e-4c31-b839-0ac7b145a597"></div>
<script>
var dest = document.getElementById("f61ef612-1b9e-4c31-b839-0ac7b145a597");
var template = document.getElementById("e0772012-95c1-4f3d-b7a7-2f44843be7cc");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```


```{=html}
<template id="29b9f0a9-1e64-4783-a837-a1cdfb1cdef1"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d15b1b90{}.cl-d158db46{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d158e10e{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d158e10f{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d158f2f2{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f2f3{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f2fc{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f2fd{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f310{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f311{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f31a{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f31b{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f31c{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f31d{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f324{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d158f325{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d15b1b90'>
```
<caption class="">

(\#tab:table-emission-particles)Size distribution of tyre wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d158f325"><p class="cl-d158e10e"><span class="cl-d158db46">Particle size class (i)</span></p></td><td class="cl-d158f324"><p class="cl-d158e10f"><span class="cl-d158db46">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d158f2f3"><p class="cl-d158e10e"><span class="cl-d158db46">TSP</span></p></td><td class="cl-d158f2f2"><p class="cl-d158e10f"><span class="cl-d158db46">1.000</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d158f2fc"><p class="cl-d158e10e"><span class="cl-d158db46">PM10</span></p></td><td class="cl-d158f2fd"><p class="cl-d158e10f"><span class="cl-d158db46">0.600</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d158f310"><p class="cl-d158e10e"><span class="cl-d158db46">PM2.5</span></p></td><td class="cl-d158f311"><p class="cl-d158e10f"><span class="cl-d158db46">0.420</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d158f31b"><p class="cl-d158e10e"><span class="cl-d158db46">PM1</span></p></td><td class="cl-d158f31a"><p class="cl-d158e10f"><span class="cl-d158db46">0.060</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d158f31d"><p class="cl-d158e10e"><span class="cl-d158db46">PM0.1</span></p></td><td class="cl-d158f31c"><p class="cl-d158e10f"><span class="cl-d158db46">0.048</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="b5798e1d-8ca2-41ad-b512-02312c5acba6"></div>
<script>
var dest = document.getElementById("b5798e1d-8ca2-41ad-b512-02312c5acba6");
var template = document.getElementById("29b9f0a9-1e64-4783-a837-a1cdfb1cdef1");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```

```{=html}
<template id="97fd8738-23c5-4a2c-8869-44a342ba90a7"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d1633fb4{}.cl-d16115fe{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d1611b8a{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d1612ab2{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612ab3{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612abc{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612abd{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612ac6{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612ac7{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612ac8{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d1612ac9{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d1633fb4'>
```
<caption class="">

(\#tab:table-speed)Speed Correction [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d1612ac9"><p class="cl-d1611b8a"><span class="cl-d16115fe">Velocity (km/h)</span></p></td><td class="cl-d1612ac8"><p class="cl-d1611b8a"><span class="cl-d16115fe">Factors (V)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d1612ab3"><p class="cl-d1611b8a"><span class="cl-d16115fe">V&lt;40</span></p></td><td class="cl-d1612ab2"><p class="cl-d1611b8a"><span class="cl-d16115fe">1.39</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d1612abd"><p class="cl-d1611b8a"><span class="cl-d16115fe">40 ≤ V ≤ 90</span></p></td><td class="cl-d1612abc"><p class="cl-d1611b8a"><span class="cl-d16115fe">-0.00974*V+1.78</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d1612ac7"><p class="cl-d1611b8a"><span class="cl-d16115fe">V &gt;90</span></p></td><td class="cl-d1612ac6"><p class="cl-d1611b8a"><span class="cl-d16115fe">0.902</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="4d51aae9-9f2f-477b-b80d-688f0c79cb12"></div>
<script>
var dest = document.getElementById("4d51aae9-9f2f-477b-b80d-688f0c79cb12");
var template = document.getElementById("97fd8738-23c5-4a2c-8869-44a342ba90a7");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```


## Brake Wear
The equation for brake wear is the same as tyre wear and has only a few differences in parameters.

\begin{equation} 
  NEE_{Brake}=\sum_{i=1}^{n}N_j \times M_j \times EF_{Brake,j} \times F_{s,i} \times S(V)
  (\#eq:brake-wear)
\end{equation} 

* NEE~Tyre~: Total emission for the defined time and spatial boundary (g/km)
* N~j~: Number of vehicles in category j within the defined spatial boundary
* M~j~: Mileage (km) driven by each vehicle in category j during the defined time (not used)
* EF~Tyre,j~: TSP mass emission factor for vehicles in category j (g/km)
* F~s,i~: mass fraction of Particles that can be attributed to particle size class i
* S(V): Correction factor for a mean vehicle travelling speed \textit{V}


As mentioned in the tyre wear equation, emission factors for passenger cars must fit a unit set in the virtual environment. Thus, the EF~Br,j~ value of .0075 (g/km) converts to 21.5 (µg/patch). The size distribution of PM~10~ is 0.98. The brake wear, particularly from the linings, are worn out quickly when the driver accelerates and decelerates frequently, and this tends to happen when the traffic volume is high. Again, mileage (M~j~) was not used for this study as this study focuses on the emission and the immediate dispersion of particles, not the activity of vehicles.


```{=html}
<template id="808eebb0-8cc5-4d8c-a209-a2bfa18992f2"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d16bd75a{}.cl-d169ae8a{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d169b592{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d169c82a{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c82b{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c834{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c835{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c836{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c837{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c83e{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c83f{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c840{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c841{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c848{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c849{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c84a{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c852{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d169c853{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d16bd75a'>
```
<caption class="">

(\#tab:table-emission-factors1)TSP (Total Suspended Particles) emission factors for source category road vehicle brake wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d169c853"><p class="cl-d169b592"><span class="cl-d169ae8a">Vehicle class (j)</span></p></td><td class="cl-d169c84a"><p class="cl-d169b592"><span class="cl-d169ae8a">TSP emission factor (g/km)</span></p></td><td class="cl-d169c852"><p class="cl-d169b592"><span class="cl-d169ae8a">Uncertainty range</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d169c82b"><p class="cl-d169b592"><span class="cl-d169ae8a">Two-wheeled vehicles</span></p></td><td class="cl-d169c834"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0037</span></p></td><td class="cl-d169c82a"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0022-0.0050</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d169c835"><p class="cl-d169b592"><span class="cl-d169ae8a">Passenger cars</span></p></td><td class="cl-d169c837"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0075</span></p></td><td class="cl-d169c836"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0044-0.0010</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d169c83e"><p class="cl-d169b592"><span class="cl-d169ae8a">Light-duty trucks</span></p></td><td class="cl-d169c83f"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0117</span></p></td><td class="cl-d169c840"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0088-0.0145</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d169c849"><p class="cl-d169b592"><span class="cl-d169ae8a">Heavy-duty vehicles</span></p></td><td class="cl-d169c841"><p class="cl-d169b592"><span class="cl-d169ae8a">Separate equation</span></p></td><td class="cl-d169c848"><p class="cl-d169b592"><span class="cl-d169ae8a">0.0235-0.0420</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="a541c927-6958-46a4-a28c-1c4b92cb42b7"></div>
<script>
var dest = document.getElementById("a541c927-6958-46a4-a28c-1c4b92cb42b7");
var template = document.getElementById("808eebb0-8cc5-4d8c-a209-a2bfa18992f2");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```


```{=html}
<template id="706294ae-5cc6-474f-832c-b3dac3a6a18f"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d173e850{}.cl-d171ca48{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d171d006{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d171d007{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d171e1a4{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1a5{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1a6{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1ae{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1af{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1b0{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1b8{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1b9{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1ba{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1bb{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1c2{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d171e1c3{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d173e850'>
```
<caption class="">

(\#tab:table-emission-particles1)Size distribution of brake wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d171e1c3"><p class="cl-d171d006"><span class="cl-d171ca48">Particle size class (i)</span></p></td><td class="cl-d171e1c2"><p class="cl-d171d007"><span class="cl-d171ca48">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d171e1a5"><p class="cl-d171d006"><span class="cl-d171ca48">TSP</span></p></td><td class="cl-d171e1a4"><p class="cl-d171d007"><span class="cl-d171ca48">1.00</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d171e1a6"><p class="cl-d171d006"><span class="cl-d171ca48">PM10</span></p></td><td class="cl-d171e1ae"><p class="cl-d171d007"><span class="cl-d171ca48">0.98</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d171e1af"><p class="cl-d171d006"><span class="cl-d171ca48">PM2.5</span></p></td><td class="cl-d171e1b0"><p class="cl-d171d007"><span class="cl-d171ca48">0.39</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d171e1b9"><p class="cl-d171d006"><span class="cl-d171ca48">PM1</span></p></td><td class="cl-d171e1b8"><p class="cl-d171d007"><span class="cl-d171ca48">0.10</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d171e1bb"><p class="cl-d171d006"><span class="cl-d171ca48">PM0.1</span></p></td><td class="cl-d171e1ba"><p class="cl-d171d007"><span class="cl-d171ca48">0.08</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="b038b450-f9c2-4e5e-b549-d13208792d05"></div>
<script>
var dest = document.getElementById("b038b450-f9c2-4e5e-b549-d13208792d05");
var template = document.getElementById("706294ae-5cc6-474f-832c-b3dac3a6a18f");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```

```{=html}
<template id="508de6a0-7422-4476-987f-540add726cc3"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d17c6a0c{}.cl-d17a10ae{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d17a16da{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d17a26e8{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26e9{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26f2{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26f3{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26f4{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26fc{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26fd{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d17a26fe{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d17c6a0c'>
```
<caption class="">

(\#tab:table-speed1)Speed Correction [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d17a26fe"><p class="cl-d17a16da"><span class="cl-d17a10ae">Velocity (km/h)</span></p></td><td class="cl-d17a26fd"><p class="cl-d17a16da"><span class="cl-d17a10ae">Factors (V)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d17a26e9"><p class="cl-d17a16da"><span class="cl-d17a10ae">V&lt;40</span></p></td><td class="cl-d17a26e8"><p class="cl-d17a16da"><span class="cl-d17a10ae">1.67</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d17a26f3"><p class="cl-d17a16da"><span class="cl-d17a10ae">40 ≤ V ≤ 90</span></p></td><td class="cl-d17a26f2"><p class="cl-d17a16da"><span class="cl-d17a10ae">-0.0270*V+2.75</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d17a26fc"><p class="cl-d17a16da"><span class="cl-d17a10ae">V &gt;90</span></p></td><td class="cl-d17a26f4"><p class="cl-d17a16da"><span class="cl-d17a10ae">0.185</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="d69849ab-d3ab-4abd-b41a-ab7d65ea761e"></div>
<script>
var dest = document.getElementById("d69849ab-d3ab-4abd-b41a-ab7d65ea761e");
var template = document.getElementById("508de6a0-7422-4476-987f-540add726cc3");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```


## Surface Wear (i.e. Road Abrasion)

Road surface wear is caused by the appearance of wheel marks when the vehicle passes over the road or parts of the road are destroyed by heavy vehicles. The formula is as follows.


\begin{equation}
   NEE_{Surface}=\sum_{i=1}^{n}N_j \times M_j \times EF_{SW,j}
   (\#eq:nee_surface)
\end{equation}

*	NEE~Surface~: Total emissions for the defined time and spatial boundary (g)
*	N~j~: Number of vehicles in category j within the defined spatial boundary
*	M~j~: Mileage (km) driven by each vehicle in category j during the defined time (not used)
*	EF~SW,j~ = TSP mass emission factor from surface wear for vehicles in category j (g/km)
*	F~s,i~ = Mass fraction of TSP that can be attributed to particle size class i



```{=html}
<template id="c3a4a62e-ca4d-4510-b94f-176e68a3d6c4"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d1858f60{}.cl-d1828fe0{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d18296a2{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d18296ac{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d182aa3e{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa3f{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa48{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa49{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa52{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa53{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa54{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa55{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa5c{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d182aa5d{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d1858f60'>
```
<caption class="">

(\#tab:table-emission-factors3)TSP (Total Suspended Particles) emission factors for source category road surface wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d182aa5d"><p class="cl-d18296a2"><span class="cl-d1828fe0">Vehicle class (j)</span></p></td><td class="cl-d182aa5c"><p class="cl-d18296ac"><span class="cl-d1828fe0">TSP emission factor (g/km)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d182aa3e"><p class="cl-d18296a2"><span class="cl-d1828fe0">Two-wheeled vehicles</span></p></td><td class="cl-d182aa3f"><p class="cl-d18296ac"><span class="cl-d1828fe0">0.0006</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d182aa48"><p class="cl-d18296a2"><span class="cl-d1828fe0">Passenger cars</span></p></td><td class="cl-d182aa49"><p class="cl-d18296ac"><span class="cl-d1828fe0">0.0015</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d182aa52"><p class="cl-d18296a2"><span class="cl-d1828fe0">Light-duty trucks</span></p></td><td class="cl-d182aa53"><p class="cl-d18296ac"><span class="cl-d1828fe0">0.0015</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d182aa55"><p class="cl-d18296a2"><span class="cl-d1828fe0">Heavy-duty vehicles</span></p></td><td class="cl-d182aa54"><p class="cl-d18296ac"><span class="cl-d1828fe0">0.0076</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="3f1555ef-25b3-48fc-ae86-8f2bf91f462b"></div>
<script>
var dest = document.getElementById("3f1555ef-25b3-48fc-ae86-8f2bf91f462b");
var template = document.getElementById("c3a4a62e-ca4d-4510-b94f-176e68a3d6c4");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```


```{=html}
<template id="7dd1b661-1493-47b1-8928-cb1b7ec20c13"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d18df5f6{}.cl-d18b96c6{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d18b9eaa{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d18b9eb4{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d18bb7aa{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7b4{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7be{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7bf{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7c0{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7c8{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7c9{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d18bb7ca{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d18df5f6'>
```
<caption class="">

(\#tab:table-emission-particles3)Size distribution of surface wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d18bb7ca"><p class="cl-d18b9eaa"><span class="cl-d18b96c6">Particle size class (i)</span></p></td><td class="cl-d18bb7c9"><p class="cl-d18b9eb4"><span class="cl-d18b96c6">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d18bb7b4"><p class="cl-d18b9eaa"><span class="cl-d18b96c6">TSP</span></p></td><td class="cl-d18bb7aa"><p class="cl-d18b9eb4"><span class="cl-d18b96c6">1.00</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d18bb7bf"><p class="cl-d18b9eaa"><span class="cl-d18b96c6">PM10</span></p></td><td class="cl-d18bb7be"><p class="cl-d18b9eb4"><span class="cl-d18b96c6">0.50</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d18bb7c8"><p class="cl-d18b9eaa"><span class="cl-d18b96c6">PM2.5</span></p></td><td class="cl-d18bb7c0"><p class="cl-d18b9eb4"><span class="cl-d18b96c6">0.27</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="98f57d0c-3f88-4f0c-9bac-d7bbbd33f681"></div>
<script>
var dest = document.getElementById("98f57d0c-3f88-4f0c-9bac-d7bbbd33f681");
var template = document.getElementById("7dd1b661-1493-47b1-8928-cb1b7ec20c13");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```

## Dispersion and Dilution
There are many dispersion models applicable for exhaust emissions, but according to early research [@Beevers2013a; @Panko2013] , many things related to non-exhaust dispersion remain unknown. The University of California, Riverside (UCR) team is conducting an ongoing project to understand the severity of non-exhaust emissions at nearer roads and is currently testing non-exhaust parameters in their existing dispersion model ([link](https://ww2.arb.ca.gov/resources/documents/brake-tire-wear-emissions)). In line with the UCR project, this study also attempts to disperse pollution with a spread function, in-cone in NetLogo, as a surrogate of dust resuspension.


Dilution with non-combustible dust varies by meteorological or ventilation conditions. Less road dust would be generated on rainy days due to the additional weight that is deposited by the particle substances on the ground, and during night hours when there is less traffic. Cities like Seoul have employed water spraying trucks to spray moisture on the roads on dry days, which adheres to the particles on the ground as well as keeps the resuspension low as possible. Since this study does not consider humidity or rain effects, the model will use the case from [@Nikolova2014], where it takes 110 seconds to dilute completely. In NetLogo, this is assigned as three random ticks – ranging between 0-2 minutes. This study further investigates the sensitivity of road PM~10~ by controlling both dispersion ranges and the extension of dilution.


## Application Inside the Simulation
It is worth mentioning that the units change inside the *in silico* environment. Since one patch is equivalent to 30 metres and one car represents 10 vehicles, a car moving from one patch to the next means 10 cars moving 30 metres. The vehicle speed inside the simulation is assigned in Table\@ref(tab:table-netlogo-speed).


```{=html}
<template id="880f73b7-8788-4088-9fa8-71e0bd4dbfce"><style>
.tabwid table{
  border-spacing:0px !important;
  border-collapse:collapse;
  line-height:1;
  margin-left:auto;
  margin-right:auto;
  border-width: 0;
  display: table;
  margin-top: 1.275em;
  margin-bottom: 1.275em;
  border-color: transparent;
}
.tabwid_left table{
  margin-left:0;
}
.tabwid_right table{
  margin-right:0;
}
.tabwid td {
    padding: 0;
}
.tabwid a {
  text-decoration: none;
}
.tabwid thead {
    background-color: transparent;
}
.tabwid tfoot {
    background-color: transparent;
}
.tabwid table tr {
background-color: transparent;
}
</style><div class="tabwid"><style>.cl-d1973a62{}.cl-d194c714{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-d194cebc{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d194cec6{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-d194e8a2{width:71.9pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8ac{width:58.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8ad{width:71.9pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8b6{width:58.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8c0{width:58.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8c1{width:71.9pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8c2{width:58.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-d194e8ca{width:71.9pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-d1973a62'>
```
<caption class="">

(\#tab:table-netlogo-speed)Conversion of Vehicle Speed in NetLogo

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-d194e8c2"><p class="cl-d194cebc"><span class="cl-d194c714">Original</span></p></td><td class="cl-d194e8ca"><p class="cl-d194cec6"><span class="cl-d194c714">Simulation</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-d194e8ac"><p class="cl-d194cebc"><span class="cl-d194c714">5km/h</span></p></td><td class="cl-d194e8a2"><p class="cl-d194cec6"><span class="cl-d194c714">0.25</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d194e8b6"><p class="cl-d194cebc"><span class="cl-d194c714">10km/h</span></p></td><td class="cl-d194e8ad"><p class="cl-d194cec6"><span class="cl-d194c714">0.50</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d194e8b6"><p class="cl-d194cebc"><span class="cl-d194c714">20km/h</span></p></td><td class="cl-d194e8ad"><p class="cl-d194cec6"><span class="cl-d194c714">1.00</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-d194e8c0"><p class="cl-d194cebc"><span class="cl-d194c714">40km/h</span></p></td><td class="cl-d194e8c1"><p class="cl-d194cec6"><span class="cl-d194c714">2.00</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="105f8b22-8f8c-424d-aff5-0c4b3dcc915d"></div>
<script>
var dest = document.getElementById("105f8b22-8f8c-424d-aff5-0c4b3dcc915d");
var template = document.getElementById("880f73b7-8788-4088-9fa8-71e0bd4dbfce");
var caption = template.content.querySelector("caption");
if(caption) {
  caption.style.cssText = "display:block;text-align:center;";
  var newcapt = document.createElement("p");
  newcapt.appendChild(caption)
  dest.parentNode.insertBefore(newcapt, dest.previousSibling);
}
var fantome = dest.attachShadow({mode: 'open'});
var templateContent = template.content;
fantome.appendChild(templateContent);
</script>

```

In published studies, the emissions are calculated by g/km based on the total distance of which the car has travelled [@Srimuruganandam2010;@Ferm2015]. @Smit2010 argued that the atmospheric pollution is combined with emissions, humidity, wind, temperature, and other uncertain factors, and therefore the calibration process is normally tested in places where there are fewer confounding variables, e.g. tunnels. Calibration with observational values can be inaccurate, but more than 15 studies have chosen this method due to restricted conditions [@SMITH2020105188].

