library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(data.table)
library(cowplot)

unzip(zipfile = "Sensitivity_Emission.R")

emission0 <- read_feather("CBD_Emission.feather") %>% clean_names() %>% 
  select(emission_factor, step, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) 

#emission <- read_feather("CBD_Emission.feather") %>% 
#  clean_names() %>% 
#  select(emission_factor, step, mean_pm10, jongno_kerb_p, samil_p, sejong_p, pirum_p, yulgok_p )


dt_road <- fread("../GIS/jongno_pm10.csv") %>% 
  mutate(date = as.Date(date),
         month = month(date)) %>% 
  filter(type == "Road") %>% 
  select(1,3:5, pm10_rd = pm10_mean)


emission0 %>% 
  left_join(dt_road, by = c("step" = "counter")) -> emission
  

##

emission %>% 
  select(-c(step)) %>% 
  group_by(date,hour,emission_factor) %>% 
  summarise_all(list(mean)) -> emission_date

emission_date

emission_date %>% 
  reshape2::melt(id = c("emission_factor", "date", "hour"), 
       variable.name = "Station", 
       value.name = "PM10") %>% 
  mutate(dh = paste(date, hour, sep = "_"),
         dh = lubridate::parse_date_time(dh, "Ymd HMS", 
                                    truncated = 3, tz = "Asia/Seoul")) -> emission_long


########

emission_long %>%
  filter(Station != "pm10_rd") %>% 
  ggplot(aes(dh, PM10)) +
  geom_line(aes(colour = Station, group = Station), size = 1, alpha = .7) +
  facet_grid(emission_factor ~ .) +
  labs(title = "Sensitivity: PM10 Levels by Stations and Emission Factors",
       #subtitle = "",
       x = "",
       y = "µg/m3",
       caption = "") +
  scale_x_datetime(date_labels = "%b %d") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_plot

ggsave("Emission_Sensitivity.png", emission_plot, width = 8, height = 8, dpi = 300)


