library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(data.table)
library(cowplot)

unzip(zipfile = "CBD_InCone_1_5773.zip")

emission <- read_feather("CBD_InCone_1_5773.feather") %>% clean_names() %>% 
  select(emission_factor, poll_cone, step, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) 


emission %>% 
  select(-step) %>% 
  group_by(poll_cone, emission_factor) %>% 
  summarise_all(list(mean )) -> emission_date

emission_date


emission %>% 
  select(-step) %>%
  group_by(poll_cone, emission_factor) -> emission_plot



emission_plot %>% 
  reshape2::melt(id = c("emission_factor", "poll_cone"), 
                 variable.name = "Station", 
                 value.name = "PM10")  -> emission_long


######

emission_long %>%
  filter(PM10 <= 59) %>%
  mutate(poll_cone = as.factor(poll_cone)) %>% 
  ggplot(aes(PM10)) +
  geom_histogram(aes(fill = poll_cone, group = poll_cone), position="dodge2", binwidth = 10) +
  facet_grid(Station ~ .) +
  labs(title = "Sensitivity: PM10 by Dispersion Range",
       #subtitle = "",
       x = "",
       y = "Freqency",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_plot1


#ggsave("InCone.png", emission_plot, width = 6, height = 8, dpi = 300)


######

emission_long %>%
  filter(PM10 >= 129) %>% 
  mutate(poll_cone = as.factor(poll_cone)) %>% 
  ggplot(aes(PM10)) +
  geom_histogram(aes(fill = poll_cone, group = poll_cone), position="dodge2", binwidth = 10) +
  facet_grid(Station ~ .) +
  labs(title = "Sensitivity: PM10 by Dispersion Range(>120µg/m3)",
       #subtitle = "Over 120µg/m3",
       x = "",
       y = "Freqency",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_plot2


#ggsave("InCone_over100.png", emission_plot, width = 6, height = 8, dpi = 300)

plot_grid(emission_plot1, emission_plot2, labels = c('A', 'B'), label_size = 12) -> plot_emp
save_plot("InCone.png", plot_emp, base_width = 14, base_height = 8, dpi = 300, type = "cairo")

