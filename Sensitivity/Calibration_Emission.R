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


################################################################################
#-- Calibration 

emission %>% 
  select(emission_factor, date, Jongno, pm10_rd) %>% 
  group_by(date, emission_factor) %>% 
  summarise_all(list(mean)) -> emission_date_cali

emission_date_cali %>% 
  mutate(MSE = (Jongno - pm10_rd)^2 / 2) %>% 
  filter(date %in% c(as.Date("2018-01-08"), 
                     as.Date("2018-01-15"),
                     as.Date("2018-01-22"),
                     as.Date("2018-01-29"))
  ) -> EC

EC

#write_csv(EC, "cali.csv")

emission_long %>%
  filter(Station %in% c("Jongno","pm10_rd")) %>% 
  ggplot(aes(dh, PM10)) +
  geom_line(aes(colour = Station, group = Station), size = 1, alpha = .7) +
  facet_grid(emission_factor ~ .) +
  labs(title = "Calibration: PM10 Levels by Stations and Emission Factors",
       #subtitle = "",
       x = "",
       y = "µg/m3",
       caption = "") +
  scale_x_datetime(date_labels = "%b %d") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_cali

#ggsave("emission_test.png", emission_cali, width = 8, height = 8, dpi = 300)



## Scatter Plot
emission %>% 
  select(-c(step)) %>% 
  group_by(date,hour,emission_factor) %>% 
  summarise_all(list(mean)) -> scatter


scatter %>% filter(emission_factor == 1) %>% with(cor(Jongno, pm10_rd)^2) %>% round(3)
scatter %>% filter(emission_factor == 5) %>% with(cor(Jongno, pm10_rd)^2) %>% round(3)
scatter %>% filter(emission_factor == 10) %>% with(cor(Jongno, pm10_rd)^2) %>% round(3)
scatter %>% filter(emission_factor == 20) %>% with(cor(Jongno, pm10_rd)^2) %>% round(3)


scatter %>% 
  reshape2::melt(id = c("emission_factor", "date", "hour", "pm10_rd"), 
                 variable.name = "Station", 
                 value.name = "PM10") -> scatter_long


scatter_long %>%
  filter(Station == "Jongno") %>% 
  ggplot(aes(pm10_rd, PM10)) +
  geom_smooth(method=lm, se=FALSE, size = 1.5, alpha = .2) +
  geom_abline(intercept=0, slope=1, linetype="dashed") +
  geom_point(aes(colour = Station), colour = "grey", alpha = .3)+
  xlim(0,200)+
  ylim(0,200)+
  facet_grid(.~emission_factor) +
  geom_text(aes(x, y, label=lab),
            data=data.frame(y=30, x=150, lab=c("r2=.94","r2=.913","r2=.8","r2=.56"),
                            emission_factor=c(1,5,10,20)), vjust=1) +
  labs(title = "Calibration: Observation vs Modelled Outcome by Emission Factors",
       subtitle = "Jongno Roadside Station",
       x = "Observation",
       y = "Modelled",
       caption = "") +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(size=14)) -> scatter_plot

#ggsave("emission_scatter.png", scatter_plot, width = 10, height = 4, dpi = 300)


plot_grid(emission_cali, scatter_plot, ncol = 1, labels = c('A', 'B'), label_size = 12, rel_heights = c(2/3, 1/3)) -> plot_finale
ggsave("Emission_Calibration.png", plot_finale, width = 8, height = 10, dpi = 300)
