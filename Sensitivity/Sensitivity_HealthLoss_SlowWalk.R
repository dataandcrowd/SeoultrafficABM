library(tidyverse)
library(feather)
library(janitor)
library(reshape2)
library(data.table)
library(cowplot)


#########################
hl <- read_feather("CBD_Slowwalk.feather") 


dt <- fread("../GIS/jongno_pm10.csv") %>% 
  filter(type == "Back") %>% 
  select(1,3:5)


hl %>% 
  left_join(dt, by = c("step" = "counter")) %>% 
  mutate(health_loss = as.factor(as.character(health_loss))) -> hl

# subway commuters
hl %>% 
  filter(Speed != "Original") %>% 
  ggplot(aes(step, walkers_p)) +
  geom_line(aes(colour = Speed), alpha = 1) +
  #facet_grid(Speed ~.) +
  labs(title = "Sensitivity Analysis: Assessing Subway Commuters Health at Risk",
       subtitle = "By Walking Speed",
       x = "",
       y = "Population at risk (%)",
       caption = "Slow = Walk speed 0.4-0.7\nExtremely Slow = Walk speed 0.2-0.4") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "bottom",
        text = element_text(size=13),
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(-10,-10,-10,-10)) -> plot_commuters

ggsave("Health_loss_Slow.png", plot_commuters, width = 8, height = 8, dpi = 300, type = "cairo")
