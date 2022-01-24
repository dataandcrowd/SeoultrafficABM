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
  get_summary_stats(ratio_Jongno, ratio_Sejong)


# Simply test PM10 on the 2nd of January
pm10 %>% 
  slice(1:1440) %>% 
  mutate(ratio_Jongno = round(back_pm10_sample / JongnoKerb_p, 2),
         ratio_Sejong = round(back_pm10_sample / Sejong_p, 2)) %>% 
  get_summary_stats(ratio_Jongno, ratio_Sejong)
