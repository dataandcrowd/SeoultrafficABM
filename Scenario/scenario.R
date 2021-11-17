library(tidyverse)
library(feather)
library(janitor)
library(data.table)
unzip(zipfile = "ScenarioFile.zip")
s <- read_feather("Scenario.feather") %>% clean_names()


dt_road <- fread("../GIS/jongno_pm10.csv") %>% 
  mutate(date = as.Date(date),
         month = month(date)) %>% 
  filter(type == "Road") %>% 
  select(1,3:5, pm10_rd = pm10_mean) %>% 
  select(-pm10_rd)


s %>% 
  left_join(dt_road, by = c("step" = "counter")) %>% 
  mutate(health_loss = as.factor(as.character(health_loss))) %>%  
  select(step, awareness, car_ratio, Jongno = jongno_kerb_p, 
       Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) %>% 
  mutate(car_ratio = case_when(car_ratio == .005 ~ "90% Restriction",
                               car_ratio == .025 ~ "50% Restriction",
                               car_ratio == .050 ~ "Business as Usual"),
         car_ratio = factor(car_ratio, levels = c("Business as Usual", "50% Restriction", "90% Restriction"))) -> sc




##

sc %>% 
  filter(awareness == "no") %>% 
  group_by(car_ratio) %>% 
  select(-c(step, awareness)) %>% 
  #summarise_all(list(mean = mean, sd = sd)) %>%
  summarise_all(list(mean = mean)) %>% 
  rename_at(vars(ends_with("_mean")), 
            funs(str_replace(., "_mean", ""))) %>% 
  mutate_if(is.numeric, round, 2) -> summary_stat

summary_stat


car_melt <- sc %>% 
  filter(awareness == "no") %>% 
  select(-awareness) %>% 
  reshape2::melt(id = c("step", "car_ratio"), variable.name = "Station", value.name = "pm10")


car_melt %>% 
  ggplot(aes(step, pm10)) +
  geom_line(aes(colour = car_ratio),alpha = .1) +
  geom_smooth(aes(colour = car_ratio),method = 'gam', formula = y ~ s(x, bs = "cs")) +
  facet_grid(Station ~ .) +
  ylim(0,200) +
  labs(title = "Scenario Output",
       subtitle = "How can 50% 90% of Vehicle Restrictions Change Air Quality?",
       caption = "PM10 Source: National Institute of Environmental Research (NIER)",
       x = "",
       y = "PM10 (µg/m3)") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 15),
        axis.text = element_text(size = 13),
        legend.title=element_text(size=15), 
        legend.text=element_text(size=15)) -> ratio_line

ggsave("car_ratio_line.png", ratio_line, width = 7, height = 8, dpi = 300)  




car_melt %>% 
  ggplot(aes(Station, pm10)) +
  geom_boxplot(aes(fill = car_ratio)) +
  labs(title = "Scenario Output",
       subtitle = "How can 50% 90% of Vehicle Restrictions Change Air Quality?",
       caption = "PM10 Source: National Institute of Environmental Research (NIER)",
       x = "",
       y = "PM10 (µg/m3)") +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 15),
        axis.text = element_text(size = 13),
        legend.title=element_text(size=13), 
        legend.text=element_text(size=13)) -> ratio_box

ggsave("car_ratio_box.png", ratio_box, width = 7, height = 7, dpi = 300)  


##################################

s %>% 
  left_join(dt_road, by = c("step" = "counter")) %>% 
  mutate(health_loss = as.factor(as.character(health_loss))) -> hl

# subway commuters
hl %>% 
  ggplot(aes(step, walkers_p)) +
  geom_line(aes(colour = awareness)) +
  facet_grid(awareness ~ .) +
  labs(title = "Assessing Subway Commuters Health at Risk",
       subtitle = "Scenario: How will the Pisk Population Change with/without Awareness",
       x = "",
       y = "Population at risk (%)",
       caption = "Population at risk = Subway Commuters whose health is below a-third of original status") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "none") -> plot_commuters

ggsave("Awareness_employees.png", plot_commuters, width = 7, height = 4, dpi = 300, type = "cairo")

# Drivers
hl %>% 
  ggplot(aes(step, drivers_p)) +
  geom_line(aes(colour = awareness)) +
  ylim(0,20) +
  facet_grid(awareness ~ .) +
  labs(title = "Assessing Resident Drivers Health at Risk",
       subtitle = "Scenario: How will the Pisk Population Change with/without Awareness",
       x = "",
       y = "Population at risk (%)",
       caption = "Population at risk = Subway Commuters whose health is below a-third of original status") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  annotate("text", x = 126000, y = 9, label = "peaked at\n88%", size = 2.5) +
  theme_bw() +
  theme(legend.position = "none") -> plot_drivers

ggsave("Awareness_drivers.png", plot_drivers, width = 7, height = 4, dpi = 300, type = "cairo")

