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

- NEE~Tyre~: Total emissions for the defined time and spatial boundary (g)
- N~j~: Number of vehicles in category _j_ within the defined spatial boundary
- M~j~: Mileage (km) driven by each vehicle in category j during the defined time _(not used)_
- EF~Tyre~, j: TSP mass emission factor for vehicles in category _j_ (g/km)
- F~s,i~: Mass fraction of particles that can be attributed to particle size class _i_
- S(V): Correction factor for a mean vehicle travelling speed _V_

This equation was designed to measure the bulk emissions from a number of vehicles (e.g. 20g/km from 10 vehicles in a 5km trip between 10:00-15:00). However, it is inappropriate to measure the emissions of vehicles that have separate journeys. To find a solution, this study manipulates N~j~ at an appropriate number based on sensitivity analysis, converts emission levels from g/km to µg/30m (equal to a size of one patch in the simulation), and spatial and temporal units at 30m and on a minute-by-minute basis. For example, one passenger car (j) has an emission factor of .0107 (.0067-.0162) (g/km) (see Table 1), and to get an estimate of PM~10~, the size distribution F~s,i~ converts the TSP estimate to PM~10~ multiplying by a fraction of 0.6 (see Table 2). This can result in 32.1µg/m3 per patch with an uncertainty range of 20.1 - 48.6.


In terms of vehicle speed, EEA sets the parameter V at 1.39 below 40km/h, and declining effect of (-0.00974 * V + 1.78) between 40-90km/h. It assumes that frequent brakes and accelerations are expected below 40km/h but less as the vehicle speeds up. Mileage (M~j~) was not used for this study as this study focuses on the emission and the immediate dispersion of particles, not the activity of vehicles. 

```{=html}
<template id="3db9d927-f048-45b9-a55f-af6e7825e015"><style>
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
</style><div class="tabwid"><style>.cl-f8d9b998{}.cl-f8d6e10a{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-f8d6eaa6{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-f8d70220{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70221{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7022a{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7022b{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7022c{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70234{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70235{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70236{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70237{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70238{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7023e{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7023f{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70248{width:153.2pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d70249{width:107.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8d7024a{width:128.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-f8d9b998'>
```
<caption class="">

(\#tab:table-emission-factors)TSP (Total Suspended Particles) emission factors for source category road vehicle tyre wear [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-f8d7024a"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Vehicle class (j)</span></p></td><td class="cl-f8d70248"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">TSP emission factor (g/km)</span></p></td><td class="cl-f8d70249"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Uncertainty range</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-f8d70221"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Two-wheeled vehicles</span></p></td><td class="cl-f8d7022a"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0046</span></p></td><td class="cl-f8d70220"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0042-0.0053</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8d7022b"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Passenger cars</span></p></td><td class="cl-f8d70234"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0107</span></p></td><td class="cl-f8d7022c"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0067-0.0162</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8d70235"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Light-duty trucks</span></p></td><td class="cl-f8d70236"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0169</span></p></td><td class="cl-f8d70237"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0088-0.0217</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8d7023f"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Heavy-duty vehicles</span></p></td><td class="cl-f8d70238"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">Separate equation</span></p></td><td class="cl-f8d7023e"><p class="cl-f8d6eaa6"><span class="cl-f8d6e10a">0.0227-0.0898</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="999ddbd8-60bd-4378-82d2-b42f01eff398"></div>
<script>
var dest = document.getElementById("999ddbd8-60bd-4378-82d2-b42f01eff398");
var template = document.getElementById("3db9d927-f048-45b9-a55f-af6e7825e015");
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
<template id="b25b730c-c429-41fc-b849-b3aa2f0d7ad8"><style>
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
</style><div class="tabwid"><style>.cl-f8e28eb0{}.cl-f8e074fe{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-f8e07a80{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-f8e07a8a{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-f8e08bec{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08bf6{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08bf7{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08bf8{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c00{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c01{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c02{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c03{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c0a{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c0b{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c0c{width:126.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e08c0d{width:120.8pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-f8e28eb0'>
```
<caption class="">

(\#tab:table-emission-particles)Size distribution of tyre wear particles [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-f8e08c0d"><p class="cl-f8e07a80"><span class="cl-f8e074fe">Particle size class (i)</span></p></td><td class="cl-f8e08c0c"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">Mass Fraction of TSP</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-f8e08bf6"><p class="cl-f8e07a80"><span class="cl-f8e074fe">TSP</span></p></td><td class="cl-f8e08bec"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">1.000</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e08bf7"><p class="cl-f8e07a80"><span class="cl-f8e074fe">PM10</span></p></td><td class="cl-f8e08bf8"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">0.600</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e08c00"><p class="cl-f8e07a80"><span class="cl-f8e074fe">PM2.5</span></p></td><td class="cl-f8e08c01"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">0.420</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e08c03"><p class="cl-f8e07a80"><span class="cl-f8e074fe">PM1</span></p></td><td class="cl-f8e08c02"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">0.060</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e08c0b"><p class="cl-f8e07a80"><span class="cl-f8e074fe">PM0.1</span></p></td><td class="cl-f8e08c0a"><p class="cl-f8e07a8a"><span class="cl-f8e074fe">0.048</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="f6e990be-053b-4e5b-ae7b-79ddf06be1a1"></div>
<script>
var dest = document.getElementById("f6e990be-053b-4e5b-ae7b-79ddf06be1a1");
var template = document.getElementById("b25b730c-c429-41fc-b849-b3aa2f0d7ad8");
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
<template id="5235e097-3fd1-4b16-ac91-f6248f1acbd8"><style>
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
</style><div class="tabwid"><style>.cl-f8eaa97e{}.cl-f8e868ee{font-family:'Helvetica';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-f8e86fec{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-f8e880ea{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e880eb{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e880f4{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e880f5{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e880fe{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e880ff{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e88100{width:103.4pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-f8e88108{width:93.3pt;background-color:transparent;vertical-align: middle;border-bottom: 2pt solid rgba(102, 102, 102, 1.00);border-top: 2pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}</style><table class='cl-f8eaa97e'>
```
<caption class="">

(\#tab:table-speed)Speed Correction [@EMEP/EEA2019]

</caption>
```{=html}
<thead><tr style="overflow-wrap:break-word;"><td class="cl-f8e88108"><p class="cl-f8e86fec"><span class="cl-f8e868ee">Velocity (km/h)</span></p></td><td class="cl-f8e88100"><p class="cl-f8e86fec"><span class="cl-f8e868ee">Factors (V)</span></p></td></tr></thead><tbody><tr style="overflow-wrap:break-word;"><td class="cl-f8e880eb"><p class="cl-f8e86fec"><span class="cl-f8e868ee">V&lt;40</span></p></td><td class="cl-f8e880ea"><p class="cl-f8e86fec"><span class="cl-f8e868ee">1.39</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e880f5"><p class="cl-f8e86fec"><span class="cl-f8e868ee">40 ≤ V ≤ 90</span></p></td><td class="cl-f8e880f4"><p class="cl-f8e86fec"><span class="cl-f8e868ee">-0.00974*V+1.78</span></p></td></tr><tr style="overflow-wrap:break-word;"><td class="cl-f8e880ff"><p class="cl-f8e86fec"><span class="cl-f8e868ee">V &gt;90</span></p></td><td class="cl-f8e880fe"><p class="cl-f8e86fec"><span class="cl-f8e868ee">0.902</span></p></td></tr></tbody></table></div></template>
<div class="flextable-shadow-host" id="1192b78e-c862-4af9-aa4e-8df39e6cadb2"></div>
<script>
var dest = document.getElementById("1192b78e-c862-4af9-aa4e-8df39e6cadb2");
var template = document.getElementById("5235e097-3fd1-4b16-ac91-f6248f1acbd8");
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






