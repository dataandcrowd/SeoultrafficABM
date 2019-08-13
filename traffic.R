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
  theme(legend.position = "bottom")



cbd_melt <- cbd %>% reshape2::melt(id = c("Date", "Day", "Name", "Site", "Direction", "Detail"),
                                      variable.name = "Hour", value.name = "Value")

cbd_melt$Time <- paste(cbd_melt$Date, substr(cbd_melt$Hour, 5, 5), sep = "-") %>% 
  as.POSIXct(format = "%Y-%m-%d-%H", tz = "Asia/Seoul")
  
cbd_melt %>% 
  ggplot(aes(Date, Value, group = Name, colour = Name)) +
  geom_line() +
  facet_wrap(~Hour, scale = "free") +
  theme_minimal() +
  theme(legend.position = "bottom")


