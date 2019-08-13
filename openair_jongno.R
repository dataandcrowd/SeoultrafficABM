library(tidyverse)
library(tidyquant)
library(openair)
library(imputeTS)
library(sf)

####################
# Import Pollution #
####################
aq <- read.csv("GIS/Pollution_Seoul_2018.txt",
               fileEncoding = 'euc-kr', # Unix based
               encoding = 'utf-8' # Unix based
               ) %>% 
  rename(City = "지역", Station = "측정소명", ID = "측정소ID", datetime = "측정일시", 
         so2 = "SO2.ppm.", co = "CO.ppm.", o3 = "O3.ppm.", no2 = "NO2.ppm.", pm10 = "PM10.....", pm2.5 = "PM2.5.....")



####################
# Choose jung-gu and jongno-gu 
# and covert no2 values from ppm to ppb
####################
jongno.aq <- aq %>% 
  filter(ID %in% c(111121, 111123, 111124, 111125)) %>% select(1:4,no2) %>% 
  mutate(no2 = ifelse(no2 > 0 , no2 * 1000, no2))
jongno.aq$datetime <- lubridate::parse_date_time(jongno.aq$datetime, "%y%m%d%H", tz = "Asia/Seoul")
jongno.aq$no2[jongno.aq$no2 == -999] <- NA

# imputation: bring last observation
na_locf(jongno.aq$no2, option = "locf", na_remaining = "rev", maxgap = Inf) -> jongno.aq$no2

# Filter Jan-March 2018
jongno.aq.fin    <- jongno.aq %>%    filter(datetime < "2018-04-01 01:00:00") %>% mutate(hour = hour(datetime))


#############
#-- Plot --##
#############

jongno.plot <- jongno.aq.fin %>% 
  mutate(Station = factor(Station, levels = c('종로구', '중구', '종로', '청계천로')))

jongno.plot %>%
  ggplot(aes(x = factor(hour), y = no2)) +
  geom_boxplot(aes(fill = Station)) +
  labs(x = "", y = "NO2 (ppb)") +
  theme_tq() +
  theme(legend.position="bottom",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        strip.text = element_text(size= 15)) -> no2_box_back

ggsave("no2_box_back.png", no2_box_back, width = 10, height = 5, dpi = 600)


##############
#-- Output --#
##############

jongno.aq.fin %>% 
  mutate(date = date(datetime), label = T, 
         type = ifelse(ID == 111121 | ID == 111123, "Back", "Road")) %>% 
  group_by(type, date, hour) %>% 
  summarise(no2_mean = mean(no2),
            no2_sd = sd(no2)) -> jongno_stats


jongno_stats %>% 
  slice(rep(1:n(), each = 10)) -> jongno_stats_rep

write.csv(jongno_stats, "jongno.csv", row.names = F)
write.csv(jongno_stats_rep, "jongno_rep.csv", row.names = F)
