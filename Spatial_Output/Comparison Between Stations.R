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


