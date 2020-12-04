library(tidyverse)
library(tidyquant)

#################
#--Data Import--#
#################

back <- read_csv("GIS/jongno_rep.csv") %>% 
  filter(type == "Back") %>% 
  slice(tail(row_number(), 13008)) %>% 
  group_by(date, hour) %>% 
  summarise(no2_mean = mean(no2_mean),
            no2_sd = mean(no2_sd))

road <- read_csv("GIS/jongno_rep.csv") %>% 
  filter(type == "Road") %>% 
  slice(tail(row_number(), 13008)) %>%  
  group_by(date, hour) %>% 
  summarise(no2_mean = mean(no2_mean),
            no2_sd = mean(no2_sd))

datetime <- read_csv("GIS/jongno_rep.csv") %>%
  filter(type == "Back") %>%
  select(date, hour) %>% 
  slice(tail(row_number(), 13008))


###############
#--NO2 level--#
###############

##--Scenario: NO
no_no2_1 <- read_csv("Result/No_no2_1.csv") %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "No")

no_no2_2 <- read_csv("Result/No_no2_2.csv") %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "No")

##--Scenario: YES
yes_no2_1 <- read_csv("Result/Yes_no2_1.csv") %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "Yes")

yes_no2_2 <- read_csv("Result/Yes_no2_2.csv") %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "Yes")


no2 <- bind_rows(yes_no2_1, yes_no2_2, no_no2_1, no_no2_2)


##############
#--Traffic--##
##############

##--Scenario: NO
no_traffic_1 <- read_csv("Result/No_Traffic_1.csv")  %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, sum, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "No")


no_traffic_2 <- read_csv("Result/No_Traffic_1.csv")  %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, sum, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "No")

##--Scenario: YES
yes_traffic_1 <- read_csv("Result/Yes_Traffic_1.csv")  %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, sum, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "Yes")

yes_traffic_2 <- read_csv("Result/Yes_Traffic_1.csv") %>% 
  cbind(datetime) %>% 
  group_by(date, hour) %>% 
  summarise_if(is.numeric, sum, na.rm = TRUE) %>% 
  select(-ticks) %>% 
  mutate(scenario = "Yes")

traffic <- bind_rows(no_traffic_1, no_traffic_2, yes_traffic_1, yes_traffic_2)


##########
#--Plot--#
##########

## NO2

no2_melt <- no2 %>% reshape2::melt(id=c("date", "hour", "scenario"), variable.name = "road", value.name = "no2")
no2.labs <- c("사직로", "율곡로", "종로4가", "퇴계로",  "세종대로", "삼일대로", "도로평균")
names(no2.labs) <- c("sajikro", "yulgokno", "jongno", "twegero", "sejongdaero", "samildaero", "roadmean")

no2_melt %>% 
  mutate(dh = paste(date, hour, sep = " ")) %>% 
  ggplot(aes(dh, no2, group = scenario, colour = scenario)) +
  geom_line() +
  facet_wrap(~ road + scenario, labeller = labeller(road = no2.labs)) +
  theme_tq() +
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_text(size = 13),
        strip.text.x = element_text(size = 13,
                                    margin = margin(.1,0,.1,0, "cm")),
        legend.position = "none",
        legend.title=element_text(size=13), 
        legend.text=element_text(size=13) 
  )-> no2line_gg

ggsave("result_no2_line.png", no2line_gg, width = 10, height = 6, dpi = 300)


no2_melt %>% 
  group_by(date, road, scenario ) %>% 
  summarise(meanno2 = mean(no2)) %>% 
  reshape2::dcast(date + road ~ scenario) %>% 
  mutate(minus = No - Yes) %>% 
  arrange(desc(No), desc(Yes)) %>%
  #filter(date == "2018-03-27") %>% 
  View()


no2_melt %>% 
  ggplot(aes(factor(hour), no2, fill = scenario)) +
  geom_boxplot() +
  ylim(0,160) +
  facet_wrap(~ road, ncol = 2, labeller = labeller(road = no2.labs)) +
  theme_tq() +
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size = 9),
        axis.text.y=element_text(size = 13),
        strip.text.x = element_text(size = 13,
                                    margin = margin(.1,0,.1,0, "cm")),
        legend.position = "bottom",
        legend.title=element_text(size=13), 
        legend.text=element_text(size=13) 
  ) -> no2box_gg

ggsave("result_no2_box.png", no2box_gg, width = 9, height = 9, dpi = 300)


## Traffic
traffic %>% 
  select(-hour) %>% 
  group_by(date, scenario) %>% 
  summarise_if(is.numeric, funs(sum), na.rm=TRUE) %>% 
  reshape2::melt(id=c("date", "scenario"), variable.name = "road", value.name = "count") -> traffic_melt

traff.labs <- c("사직로", "율곡로", "종로4가", "퇴계로", "삼일대로", "세종대로")
names(traff.labs) <- c("cars_sajik", "cars_yulgok", "cars_jongno", "cars_twege", "cars_samil", "cars_sejong")

traffic_melt %>% 
  group_by(date, scenario, road) %>% 
  summarise(nn = sum(count)) %>% 
  ggplot(aes(date, nn, colour = scenario)) +
  geom_line() +
  facet_wrap(~ road, scales = "free", labeller = labeller(road = traff.labs)) +
  theme_tq() +
  theme(axis.title.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_text(size = 13),
        axis.text.y=element_text(size = 13),
        strip.text.x = element_text(size = 13,
                                    margin = margin(.1,0,.1,0, "cm")),
        legend.position = "right",
        legend.title=element_text(size=13), 
        legend.text=element_text(size=13) 
  ) -> traffic_gg

ggsave("result_traffic.png", traffic_gg, width = 12, height = 6, dpi = 600)

