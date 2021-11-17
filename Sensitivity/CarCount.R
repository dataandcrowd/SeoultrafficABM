library(tidyverse)
library(feather)
library(janitor)
library(data.table)
library(cowplot)

unzip(zipfile = "CBD_CarCount.zip")

cc <- read_feather("CBD_CarCount.feather") %>% clean_names() %>% select(step, count_cars = count_cars_with_random_car_true)
dt <- fread("../GIS/jongno_pm10.csv") %>% 
  filter(type == "Back") %>% 
  select(1,3:5)


cc %>% 
  left_join(dt, by = c("step" = "counter")) -> cc


cc %>% 
  ggplot(aes(step, count_cars)) +
  geom_line()+
  labs(title = "Sensitivity Analysis: Number of Cars",
       subtitle = "Jan.2nd - Mar.31st, 2018",
       x = "",
       y = "Count",
       caption = "") +
  scale_x_continuous(breaks = c(0, 30000, 60000, 90000, 120000), 
                     labels = c("Jan 2nd", "Jan 23rd", "Feb 12th", "Mar 5th", "Mar 26th")) +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(size=13)) -> plot_carcount

cc %>% 
  filter(step >= 8400 & step < 18600) %>%
  ggplot(aes(step, count_cars)) +
  geom_line()+
  labs(title = "Sensitivity Analysis: Number of Cars in a Week",
       subtitle = "Jan 8th-15th, 2018: Mon-Sun",
       x = "",
       y = "Count",
       caption = "") +
  scale_x_continuous(breaks = c(8221, 9661, 11101, 12541, 13981, 15421, 16861, 18301), 
                     labels = c("Jan  8th", "Jan 9th","Jan 10th","Jan 11th",
                                "Jan 12th","Jan 13th","Jan 14th", "Jan 15th")) +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(size=13)) -> plot_carcount_week



plot_grid(plot_carcount, plot_carcount_week, labels = c('A', 'B'), label_size = 12, ncol = 1, align = "v") -> plot_finale


ggsave("Car_count.png", plot_finale, width = 7, height = 5, dpi = 300)
