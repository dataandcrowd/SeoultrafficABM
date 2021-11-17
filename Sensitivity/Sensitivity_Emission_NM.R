library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(data.table)
library(cowplot)



nm0 <- read_feather("CBD_Nomove_3396.feather") %>% clean_names() %>% 
  select(emission_factor, step, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) 


dt_road <- fread("../GIS/jongno_pm10.csv") %>% 
  mutate(date = as.Date(date),
         month = month(date)) %>% 
  filter(type == "Road") %>% 
  select(1,3:5, pm10_rd = pm10_mean)


nm0 %>% 
  left_join(dt_road, by = c("step" = "counter")) -> nm



emission0 <- read_feather("CBD_Emission.feather") %>% clean_names() %>% 
  select(emission_factor, step, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) 


emission0 %>% 
  left_join(dt_road, by = c("step" = "counter")) -> emission



##
emission %>% slice(1:1000)-> e1
nm %>% slice(1:1000) -> e2
e1 - e2 -> ee
