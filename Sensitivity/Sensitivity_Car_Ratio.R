library(data.table)
library(tidyverse)
library(feather)
library(janitor)
library(reshape2)

unzip(zipfile = "CBD_CarRatio_819.zip")

p <- read_feather("CBD_CarRatio_819.feather") %>% 
  clean_names() %>% 
  select(step, car_ratio, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) %>% 
  mutate(car_ratio = case_when(car_ratio == 0 ~ "0%",
                               car_ratio == .025 ~ "2.5%",
                               car_ratio == .05 ~ "5%",
                               car_ratio == .1 ~ "10%",
                               car_ratio == .2 ~ "20%"),
         car_ratio = factor(car_ratio, levels = c("0%", "2.5%", "5%", "10%", "20%")))


p %>% 
  group_by(car_ratio) %>% 
  select(-step) %>% 
  summarise_all(list(mean = mean, sd = sd)) %>% 
  rename_at(vars(ends_with("_mean")), 
            funs(str_replace(., "_mean", ""))) -> summary_stat

summary_stat %>% 
  mutate_if(is.numeric, round, 2) -> summary_stat

write_csv(summary_stat, "carratio.csv")


p_melt <- p %>% 
  melt(id = c("step", "car_ratio"), variable.name = "Station", value.name = "pm10")


p_melt %>% 
  filter(step < 41000) %>% 
  ggplot(aes(step, pm10)) +
  geom_line(aes(colour = car_ratio),alpha = .1) +
  geom_smooth(aes(colour = car_ratio),method = 'gam', formula = y ~ s(x, bs = "cs")) +
  facet_grid(Station ~ .) +
  labs(title = "Sensitivity Analysis: Time-series PM10 by Vehicle Sample Sizes",
       subtitle = "0%, 2.5%, 5% 10% 20% Sampling of Registered Vehicles in January 2018",
       caption = "PM10 Source: January 2018",
       x = "",
       y = "PM10 (µg/m3)") +
  scale_x_discrete(breaks = c(0, 10000, 20000, 30000, 40000), 
                   labels = c("Jan 2nd","Jan 9th", "Jan 16th", "Jan 23rd", "Jan 30th")) +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 15),
        axis.text = element_text(size = 15),
        legend.title=element_text(size=15), 
        legend.text=element_text(size=15)) -> ratio_line

ggsave("car_ratio_line.png", ratio_line, width = 7, height = 8, dpi = 300)  
  


p_melt %>% 
  ggplot(aes(car_ratio, pm10)) +
  geom_boxplot(aes(fill = Station)) +
  labs(title = "Sensitivity Analysis: Time-series PM10 by Vehicle Sample Sizes",
       subtitle = "0%, 2.5%, 5% 10% 20% Sampling of Registered Vehicles in January 2018",
       caption = "PM10 Source: January 2018",
       x = "",
       y = "PM10 (µg/m3)") +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 15)) -> ratio_box
        
ggsave("car_ratio_box.png", ratio_box, width = 8, height = 8, dpi = 300)  

