library(tidyverse)
library(data.table)
library(rstatix)

pm10 <- fread("pm10_comparison btw stations.csv")

pm10 %>% 
  pivot_longer(cols = everything(),
               names_to = "Station",
               values_to = "PM10") %>% 
  group_by(Station) %>% 
  get_summary_stats()


pm10 %>% 
  mutate(ratio_Jongno = round(JongnoKerb_p / back_pm10_sample, 2),
         ratio_Sejong = round(Sejong_p / back_pm10_sample, 2)) %>% 
  slice(-1) %>% # first tick is the setup
  get_summary_stats(ratio_Jongno, ratio_Sejong)

