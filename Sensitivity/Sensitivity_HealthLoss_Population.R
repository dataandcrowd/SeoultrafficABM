library(data.table)
library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(cowplot)

#########################
hl <- read_feather("CBD_HL.feather")# %>% clean_names()


dt <- fread("../GIS/jongno_pm10.csv") %>% 
  filter(type == "Back") %>% 
  select(1,3:5)


hl %>% 
  left_join(dt, by = c("step" = "counter")) %>% 
  mutate(health_loss = as.factor(as.character(health_loss))) -> hl

# subway commuters
hl %>% 
  ggplot(aes(step, walkers_p)) +
  geom_line(aes(colour = health_loss)) +
#  geom_ribbon(aes(ymin = walkers_p - walkers_p_sd, ymax = walkers_p + walkers_p_sd),alpha=0.5) +
  facet_grid(health_loss~.) +
#  ylim(0,7) +
  labs(title = "Sensitivity Analysis: Assessing Subway Commuters Health at Risk",
       subtitle = "Health Loss Parameters: .03 .05 .01 .15 .2",
       x = "",
       y = "Population at risk (%)",
       caption = "Population at risk = Subway Commuters whose health is below a-third of original status") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "none") -> plot_commuters

ggsave("Health_loss_employees.png", plot_commuters, width = 7, height = 7, dpi = 300, type = "cairo")


# Drivers
dat_text <- data.frame(
  label = c("peaked at\n55%", "peaked at\n86%", "peaked at\n86%", "peaked at\n86%", "peaked at\n86%"),
  health_loss = c(.03, .05, .1, .15, .2)
)


hl %>% 
  ggplot(aes(step, drivers_p)) +
  geom_line(aes(colour = health_loss)) +
  facet_grid(health_loss ~.) +
  ylim(0,10) +
  labs(title = "Sensitivity Analysis: Assessing Drivers Health at Risk",
       subtitle = "Health Loss Parameters: .03 .05 .01 .15 .2",
       x = "",
       y = "Population at risk (%)",
       caption = "Population at risk = Drivers whose health are below a-third of original status") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  geom_text(data = dat_text, mapping = aes(x = 110000, y = 8, label = label), size = 3.5) +
  theme_bw() +
  theme(legend.position = "none") -> plot_drivers

ggsave("Health_loss_drivers.png", plot_drivers, width = 7, height = 7, dpi = 300, type = "cairo")

###################
##-- Individuals
###################

hl %>% 
  select(step, health_loss, e_health = health_of_one_of_employees, 
         d_health = health_of_one_of_cars_with_not_random_car) %>% 
  reshape2::melt(id = c("step", "health_loss"), variable.name = "Type", value.name = "Health") -> hl_plot


hl_plot %>% 
  filter(Type %in% c("d_health", "e_health")) %>% 
  ggplot(aes(step, Health)) +
  geom_step(aes(colour = Type), alpha = .1) +
  geom_smooth(aes(colour = Type)) +
  ylim(0,300) +
  facet_grid(health_loss ~.) +
  labs(title = "Sensitivity Analysis: Individual Health",
       subtitle = "Monitoring Health Change of a Random Driver and a Random Subway Commuter",
       x = "",
       y = "(Nominal) Health") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "bottom") -> health

ggsave("Individual_health.png", health, width = 7, height = 7, dpi = 300, type = "cairo")


#plot_grid(d_health, e_health, labels = c('A', 'B'), label_size = 12, ncol = 1, align = "v") -> plot_emp
#ggsave("H_D.png", plot_emp, width = 7, height = 8, dpi = 300)#, type = "cairo")
