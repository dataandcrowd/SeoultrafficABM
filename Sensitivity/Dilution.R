library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(data.table)
library(cowplot)



emission <- read_feather("CBD_Dilution_1_1490.feather") %>% clean_names() %>% 
  select(emission_factor, countdown_param, step, Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p) 



##

emission %>% 
  select(-step) %>% 
  group_by(countdown_param, emission_factor) %>% 
  summarise_all(list(median )) -> emission_date

emission_date


emission %>% 
  select(-step) %>%
  group_by(countdown_param, emission_factor) -> emission_plot



emission_plot %>% 
  reshape2::melt(id = c("emission_factor", "countdown_param"), 
                 variable.name = "Station", 
                 value.name = "PM10")  -> emission_long


########

emission_long %>%
  #filter(Station == "Yulgok") %>% 
  ggplot(aes(PM10)) +
  geom_density(aes(fill = factor(countdown_param)), alpha = .4, adjust = 1/10) +
  facet_grid(Station ~.) +
  labs(title = "Sensitivity: Dilution",
       #subtitle = "",
       x = "",
       y = "Density",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_plot


#ggsave("Dilution1.png", emission_plot, width = 5, height = 8, dpi = 300)

######

emission_long %>%
  mutate(countdown_param = as.factor(countdown_param)) %>% 
  ggplot(aes(PM10)) +
  geom_histogram(aes(fill = countdown_param, group = countdown_param), position="dodge2", binwidth = 3) +
  facet_grid(Station ~ ., scales = "free") +
  labs(title = "Sensitivity: Dilution",
       #subtitle = "",
       x = "",
       y = "Freqency",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=15)) -> emission_plot


#ggsave("Dilution_Overall.png", emission_plot, width = 6, height = 8, dpi = 300)

######

emission_long %>%
  filter(PM10 >= 99) %>% 
  mutate(countdown_param = as.factor(countdown_param)) %>% 
  ggplot(aes(PM10)) +
  geom_histogram(aes(fill = countdown_param, group = countdown_param), position="dodge2", binwidth = 3) +
  facet_grid(Station ~ ., scales = "free") +
  labs(title = "Sensitivity: Pollution Clearance by Minutes (>100µg/m3)",
       #subtitle = "",
       x = "",
       y = "Freqency",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=14)) -> emission_plot1


#ggsave("Dilution_over100.png", emission_plot, width = 6, height = 8, dpi = 300)

######

emission_long %>%
  filter(PM10 <= 49) %>% 
  mutate(countdown_param = as.factor(countdown_param)) %>% 
  ggplot(aes(PM10)) +
  geom_histogram(aes(fill = countdown_param, group = countdown_param), position="dodge2", binwidth = 3) +
  facet_grid(Station ~ ., scales = "free") +
  labs(title = "Sensitivity: Pollution Clearance by Minutes (<50µg/m3)",
       #subtitle = "",
       x = "",
       y = "Freqency",
       caption = "") +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=14)) -> emission_plot2


#ggsave("Dilution_under20.png", emission_plot, width = 6, height = 8, dpi = 300)
plot_grid(emission_plot2, emission_plot1, labels = c('A', 'B'), label_size = 12) -> plot_emp
save_plot("Dilution.png", plot_emp, base_width = 14, base_height = 8, dpi = 300, type = "cairo")

