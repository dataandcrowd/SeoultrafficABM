library(nlrx)
library(tidyverse)
library(janitor)
library(ggridges)

options(scipen = 100)
load("HC.RData")


results %>% 
  unnest(metrics.employees) %>% 
  clean_names() %>% 
  select(step, awareness, health) %>% 
  mutate(step = case_when(step == 1 ~ "Jan 2nd",
                          step == 10000 ~ "Jan 9th",
                          step == 20000 ~ "Jan 16th",
                          step == 30000 ~ "Jan 23rd",
                          step == 40000 ~ "Jan 30th",
                          step == 50000 ~ "Feb 5th",
                          step == 60000 ~ "Feb 12th",
                          step == 70000 ~ "Feb 19th",
                          step == 80000 ~ "Feb 26th",
                          step == 90000 ~ "Mar 5th",
                          step == 100000 ~ "Mar 12th",
                          step == 110000 ~ "Mar 19th",
                          step == 120000 ~ "Mar 26th"),
         step = factor(step, levels = c("Mar 26th", "Mar 19th", "Mar 12th", "Mar 5th", 
                                        "Feb 26th", "Feb 19th", "Feb 12th", "Feb 5th", "Jan 30th", 
                                        "Jan 23rd", "Jan 16th", "Jan 9th", "Jan 2nd"))) %>% 
  filter(step %in% c("Jan 2nd", "Jan 9th", "Jan 16th", "Jan 30th", "Feb 12th", 
                     "Feb 26th", "Mar 12th", "Mar 26th"))  -> employees


results %>% 
  unnest(metrics.drivers) %>% 
  clean_names() %>% 
  select(step, awareness, health) %>% 
  mutate(step = case_when(step == 1 ~ "Jan 2nd",
                          step == 10000 ~ "Jan 9th",
                          step == 20000 ~ "Jan 16th",
                          step == 30000 ~ "Jan 23rd",
                          step == 40000 ~ "Jan 30th",
                          step == 50000 ~ "Feb 5th",
                          step == 60000 ~ "Feb 12th",
                          step == 70000 ~ "Feb 19th",
                          step == 80000 ~ "Feb 26th",
                          step == 90000 ~ "Mar 5th",
                          step == 100000 ~ "Mar 12th",
                          step == 110000 ~ "Mar 19th",
                          step == 120000 ~ "Mar 26th"),
         step = factor(step, levels = c("Mar 26th", "Mar 19th", "Mar 12th", "Mar 5th", 
                                        "Feb 26th", "Feb 19th", "Feb 12th", "Feb 5th", "Jan 30th", 
                                        "Jan 23rd", "Jan 16th", "Jan 9th", "Jan 2nd"))) %>% 
  filter(step %in% c("Jan 2nd", "Jan 9th", "Jan 16th", "Jan 30th", "Feb 12th", 
                     "Feb 26th", "Mar 12th", "Mar 26th")) -> drivers


ggplot(employees, aes(x = health, y = step, fill = stat(x))) +
  geom_density_ridges_gradient() +
  scale_fill_viridis_c(name = "Health", option = "A") +
  labs(title = 'Health Status of Subway Commuters who Travel to Seoul CBD',
       subtitle = "Health density compared with the de/activation of agent's awareness to sudden pollution rise\n",
       x = "Health",
       y = '',
       caption = 'Awareness scenario turned on: "yes"\n Awareness scenario turned off: "no" ') +
  facet_grid(.~awareness) + 
  scale_y_discrete(expand = c(0, 0)) +
  coord_cartesian(xlim= c(0,300), clip = "off") + 
  theme_ridges(grid = FALSE, center_axis_labels = TRUE) +
  theme(plot.title = element_text(size = 20),#hjust = 0.5),
        strip.text = element_text(size = 15),
        axis.text.y = element_text(vjust=-.5),
        panel.spacing = unit(4, "lines")) -> plot_employees

ggsave("Health_change_employees.png", plot_employees, width = 10, height = 7, dpi = 300)  
  
  
ggplot(drivers, aes(x = health, y = step, fill = stat(x))) +
  geom_density_ridges_gradient() +
  scale_fill_viridis_c(name = "Health", option = "A") +
  labs(title = 'Health Status of Local Residents who Drive to Workplace',
       subtitle = "Health density compared with the de/activation of agent's awareness to sudden pollution rise\n",
       x = "Health",
       y = '',
       caption = 'Awareness Scenario turned on: "yes"\n Awareness Scenario turned off: "no" ') +
  facet_grid(.~awareness) + 
  scale_x_continuous(expand = c(0, 0), breaks = c(0,100,200,300)) +
  scale_y_discrete(expand = c(0, 0)) +
  coord_cartesian(xlim= c(0,350), clip = "off") + 
  theme_ridges(grid = FALSE, center_axis_labels = TRUE) +
  theme(plot.title = element_text(size = 20),
        strip.text = element_text(size = 15),
        axis.text.y = element_text(vjust=-.5),
        panel.spacing = unit(10, "lines")) -> plot_drivers

ggsave("Health_change_drivers.png", plot_drivers, width = 10, height = 7, dpi = 300)  

