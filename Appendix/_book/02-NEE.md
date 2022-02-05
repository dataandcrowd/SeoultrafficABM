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
<template id="1a611560-ad89-4658-8052-c4bc7223f4d4"><style>
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
</style><div class="tabwid"><style>.cl-ec325250{}.cl-ec2f89f8{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec2f9498{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec2fab0e{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab0f{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab18{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab19{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab1a{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab22{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab23{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab24{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab25{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab26{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab2c{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab2d{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab2e{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab2f{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec2fab30{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec325250'>
```
<caption class="">

(\#tab:table-emission-factors)TSP (Total Suspended Particles) emission factors for source category road vehicle tyre wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec2fab30"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Vehicle class (j)</span></p></td><td class="cl-ec2fab2e"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">TSP emission factor (g/km)</span></p></td><td class="cl-ec2fab2f"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Uncertainty range</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec2fab0f"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Two-wheeled vehicles</span></p></td><td class="cl-ec2fab18"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0046</span></p></td><td class="cl-ec2fab0e"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0042-0.0053</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2fab19"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Passenger cars</span></p></td><td class="cl-ec2fab22"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0107</span></p></td><td class="cl-ec2fab1a"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0067-0.0162</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2fab23"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Light-duty trucks</span></p></td><td class="cl-ec2fab24"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0169</span></p></td><td class="cl-ec2fab25"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0088-0.0217</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec2fab2d"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Heavy-duty vehicles</span></p></td><td class="cl-ec2fab26"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">Separate equation</span></p></td><td class="cl-ec2fab2c"><p class="cl-ec2f9498"><span class="cl-ec2f89f8">0.0227-0.0898</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="ae200fef-e2af-417f-bba8-c78db5654523"></div>
<script>
var dest = document.getElementById("ae200fef-e2af-417f-bba8-c78db5654523");
var template = document.getElementById("1a611560-ad89-4658-8052-c4bc7223f4d4");
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
<template id="b76929c9-1981-4781-a893-b741931d0342"><style>
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
</style><div class="tabwid"><style>.cl-ec3aeeba{}.cl-ec38d3aa{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec38d936{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec38d937{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec38eaf2{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eafc{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eafd{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eafe{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eaff{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb06{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb07{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb08{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb10{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb11{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb12{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec38eb13{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec3aeeba'>
```
<caption class="">

(\#tab:table-emission-particles)Size distribution of tyre wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec38eb13"><p class="cl-ec38d936"><span class="cl-ec38d3aa">Particle size class (i)</span></p></td><td class="cl-ec38eb12"><p class="cl-ec38d937"><span class="cl-ec38d3aa">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec38eafc"><p class="cl-ec38d936"><span class="cl-ec38d3aa">TSP</span></p></td><td class="cl-ec38eaf2"><p class="cl-ec38d937"><span class="cl-ec38d3aa">1.000</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec38eafd"><p class="cl-ec38d936"><span class="cl-ec38d3aa">PM10</span></p></td><td class="cl-ec38eafe"><p class="cl-ec38d937"><span class="cl-ec38d3aa">0.600</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec38eaff"><p class="cl-ec38d936"><span class="cl-ec38d3aa">PM2.5</span></p></td><td class="cl-ec38eb06"><p class="cl-ec38d937"><span class="cl-ec38d3aa">0.420</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec38eb08"><p class="cl-ec38d936"><span class="cl-ec38d3aa">PM1</span></p></td><td class="cl-ec38eb07"><p class="cl-ec38d937"><span class="cl-ec38d3aa">0.060</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec38eb11"><p class="cl-ec38d936"><span class="cl-ec38d3aa">PM0.1</span></p></td><td class="cl-ec38eb10"><p class="cl-ec38d937"><span class="cl-ec38d3aa">0.048</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="0f412265-dd56-4146-87b1-8ad1f8e26534"></div>
<script>
var dest = document.getElementById("0f412265-dd56-4146-87b1-8ad1f8e26534");
var template = document.getElementById("b76929c9-1981-4781-a893-b741931d0342");
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
<template id="bb15d5b2-9318-4bca-8e3a-e5a323d6db52"><style>
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
</style><div class="tabwid"><style>.cl-ec42da26{}.cl-ec40cbfa{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec40d190{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec40e054{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e055{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e056{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e05e{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e05f{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e068{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e069{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec40e06a{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec42da26'>
```
<caption class="">

(\#tab:table-speed)Speed Correction [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec40e06a"><p class="cl-ec40d190"><span class="cl-ec40cbfa">Velocity (km/h)</span></p></td><td class="cl-ec40e069"><p class="cl-ec40d190"><span class="cl-ec40cbfa">Factors (V)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec40e055"><p class="cl-ec40d190"><span class="cl-ec40cbfa">V&lt;40</span></p></td><td class="cl-ec40e054"><p class="cl-ec40d190"><span class="cl-ec40cbfa">1.39</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec40e05e"><p class="cl-ec40d190"><span class="cl-ec40cbfa">40 ≤ V ≤ 90</span></p></td><td class="cl-ec40e056"><p class="cl-ec40d190"><span class="cl-ec40cbfa">-0.00974*V+1.78</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec40e068"><p class="cl-ec40d190"><span class="cl-ec40cbfa">V &gt;90</span></p></td><td class="cl-ec40e05f"><p class="cl-ec40d190"><span class="cl-ec40cbfa">0.902</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="ecc6f731-22a4-4083-be7b-5d4fb0eb9f80"></div>
<script>
var dest = document.getElementById("ecc6f731-22a4-4083-be7b-5d4fb0eb9f80");
var template = document.getElementById("bb15d5b2-9318-4bca-8e3a-e5a323d6db52");
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
<template id="83247617-48f7-48e7-9028-0405e6f1f7a6"><style>
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
</style><div class="tabwid"><style>.cl-ec4b2ed8{}.cl-ec490d06{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec4912a6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec492282{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec49228c{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec49228d{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec49228e{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec492296{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec492297{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec492298{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec492299{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922a0{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922a1{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922a2{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922aa{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922ab{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922ac{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec4922ad{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec4b2ed8'>
```
<caption class="">

(\#tab:table-emission-factors1)TSP (Total Suspended Particles) emission factors for source category road vehicle brake wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec4922ad"><p class="cl-ec4912a6"><span class="cl-ec490d06">Vehicle class (j)</span></p></td><td class="cl-ec4922ab"><p class="cl-ec4912a6"><span class="cl-ec490d06">TSP emission factor (g/km)</span></p></td><td class="cl-ec4922ac"><p class="cl-ec4912a6"><span class="cl-ec490d06">Uncertainty range</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec49228c"><p class="cl-ec4912a6"><span class="cl-ec490d06">Two-wheeled vehicles</span></p></td><td class="cl-ec49228d"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0037</span></p></td><td class="cl-ec492282"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0022-0.0050</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec49228e"><p class="cl-ec4912a6"><span class="cl-ec490d06">Passenger cars</span></p></td><td class="cl-ec492297"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0075</span></p></td><td class="cl-ec492296"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0044-0.0010</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec492298"><p class="cl-ec4912a6"><span class="cl-ec490d06">Light-duty trucks</span></p></td><td class="cl-ec492299"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0117</span></p></td><td class="cl-ec4922a0"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0088-0.0145</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec4922aa"><p class="cl-ec4912a6"><span class="cl-ec490d06">Heavy-duty vehicles</span></p></td><td class="cl-ec4922a1"><p class="cl-ec4912a6"><span class="cl-ec490d06">Separate equation</span></p></td><td class="cl-ec4922a2"><p class="cl-ec4912a6"><span class="cl-ec490d06">0.0235-0.0420</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="611a1c79-9fb5-4f42-b1f5-1578b10a65b5"></div>
<script>
var dest = document.getElementById("611a1c79-9fb5-4f42-b1f5-1578b10a65b5");
var template = document.getElementById("83247617-48f7-48e7-9028-0405e6f1f7a6");
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
<template id="17928de5-ece1-49d9-a09d-e6d83585cd6a"><style>
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
</style><div class="tabwid"><style>.cl-ec53020c{}.cl-ec50d7b6{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec50dd6a{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec50dd74{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec50efb2{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efb3{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efbc{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efbd{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efbe{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efbf{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efc6{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efc7{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efc8{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efc9{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efd0{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec50efd1{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec53020c'>
```
<caption class="">

(\#tab:table-emission-particles1)Size distribution of brake wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec50efd1"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">Particle size class (i)</span></p></td><td class="cl-ec50efd0"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec50efb3"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">TSP</span></p></td><td class="cl-ec50efb2"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">1.00</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec50efbc"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">PM10</span></p></td><td class="cl-ec50efbd"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">0.98</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec50efbe"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">PM2.5</span></p></td><td class="cl-ec50efbf"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">0.39</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec50efc7"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">PM1</span></p></td><td class="cl-ec50efc6"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">0.10</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec50efc9"><p class="cl-ec50dd6a"><span class="cl-ec50d7b6">PM0.1</span></p></td><td class="cl-ec50efc8"><p class="cl-ec50dd74"><span class="cl-ec50d7b6">0.08</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="fae86dee-8bed-4d45-8a5d-d6adcdecf428"></div>
<script>
var dest = document.getElementById("fae86dee-8bed-4d45-8a5d-d6adcdecf428");
var template = document.getElementById("17928de5-ece1-49d9-a09d-e6d83585cd6a");
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
<template id="7b38b454-6fbf-4b13-b347-4714dc68bb5f"><style>
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
</style><div class="tabwid"><style>.cl-ec5ae76a{}.cl-ec58d218{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-ec58d876{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-ec58e85c{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e85d{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e85e{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e866{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e867{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e868{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e869{width:97.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-ec58e86a{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-ec5ae76a'>
```
<caption class="">

(\#tab:table-speed1)Speed Correction [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-ec58e86a"><p class="cl-ec58d876"><span class="cl-ec58d218">Velocity (km/h)</span></p></td><td class="cl-ec58e869"><p class="cl-ec58d876"><span class="cl-ec58d218">Factors (V)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-ec58e85d"><p class="cl-ec58d876"><span class="cl-ec58d218">V&lt;40</span></p></td><td class="cl-ec58e85c"><p class="cl-ec58d876"><span class="cl-ec58d218">1.67</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec58e866"><p class="cl-ec58d876"><span class="cl-ec58d218">40 ≤ V ≤ 90</span></p></td><td class="cl-ec58e85e"><p class="cl-ec58d876"><span class="cl-ec58d218">-0.0270*V+2.75</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-ec58e868"><p class="cl-ec58d876"><span class="cl-ec58d218">V &gt;90</span></p></td><td class="cl-ec58e867"><p class="cl-ec58d876"><span class="cl-ec58d218">0.185</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="8b41dedf-15f3-48d4-93a4-854903f9ca92"></div>
<script>
var dest = document.getElementById("8b41dedf-15f3-48d4-93a4-854903f9ca92");
var template = document.getElementById("7b38b454-6fbf-4b13-b347-4714dc68bb5f");
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

