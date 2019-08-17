library(tidyverse)
library(lubridate)

jan <- readxl::read_xlsx("traffic/traffic.xlsx", sheet = 1) %>% mutate(Date = as_date(as.character(일자)), Day = weekdays(Date))
feb <- readxl::read_xlsx("traffic/traffic.xlsx", sheet = 2) %>% mutate(Date = as_date(as.character(일자)), Day = weekdays(Date))
mar <- readxl::read_xlsx("traffic/traffic.xlsx", sheet = 3) %>% mutate(Date = as_date(as.character(일자)), Day = weekdays(Date))



cbd <- jan %>% filter(지점명 %in% c("율곡로(안국역)", "종로(동묘앞역)", "종로(종로3가역)", "을지로(을지로3가역)"))


cbd %>% 
  select(-c(1:2,4:6,31:32)) %>% 
  group_by(지점명) %>% 
  na.omit() %>% 
  summarise_all(list(mean = mean), na.rm = T) %>% 
  mutate_if(is.numeric, round, 0) -> summary
  


summary %>% 
  reshape2::melt(id = "지점명") %>%
  mutate(variable = gsub("_mean", "", .$variable)) %>% 
  mutate(variable = case_when(variable == "0시" ~ "00시",
            variable == "1시" ~ "01시",
            variable == "2시" ~ "02시",
            variable == "3시" ~ "03시",
            variable == "4시" ~ "04시",
            variable == "5시" ~ "05시",
            variable == "6시" ~ "06시",
            variable == "7시" ~ "07시",
            variable == "8시" ~ "08시",
            variable == "9시" ~ "09시",
            TRUE ~ as.character(variable)
            )) %>% 
  ggplot(aes(variable, value, group = 지점명, colour = 지점명)) +
  geom_line(size = 2)+
  theme_minimal() + 
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size = 13, angle = 30),
        axis.text.y=element_text(size = 13),
        strip.text.x = element_text(size = 13,
                                    margin = margin(.1,0,.1,0, "cm")),
        legend.position = "none",
        legend.title=element_text(size=13), 
        legend.text=element_text(size=13) 
  ) -> traffic_gg

ggsave("result_traffic_trend.png", traffic_gg, width = 10, height = 6, dpi = 600)


