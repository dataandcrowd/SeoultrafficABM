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

# Filter Health Loss Parameters
hl %<>% 
  left_join(dt, by = c("step" = "counter")) %>% 
  filter(health_loss >= 0.05 & health_loss < 0.2) %>% 
  mutate(health_loss = as.factor(as.character(health_loss)))

# Select Columns
hl %>% 
  select(step, health_loss, walkers_p, drivers_p) %>%
  rename(Pedestrians = walkers_p,
         `Resident Drivers` = drivers_p) %>% 
  reshape2::melt(.,
                 id = c("step", "health_loss"),
                 variable.name = "Type",
                 value.name = "Value") %>% 
  as_tibble() -> hl_clean


# subway commuters
hl_clean %>% 
  ggplot(aes(step, Value)) +
  geom_line(aes(colour = Type)) +
  facet_grid(health_loss~.) +
  labs(title = "Sensitivity Analysis: Assessing Subway Commuters Health at Risk",
       subtitle = "Health Loss Parameters: .05 .01 .15",
       x = "",
       y = "Population at risk (%)",
       caption = "Population at risk = Subway Commuters whose health is below a-third of original status") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "bottom",
        strip.text = element_text(size = 15),
        axis.text = element_text(size = 13),
        legend.title=element_text(size = 15), 
        legend.text=element_text(size = 12))  -> plot_commuters

ggsave("SSC2021_Health_loss.jpg", plot_commuters, width = 7, height = 5)

