library(feather)
library(tidyverse)
library(data.table)
library(viridis)
library(cowplot)
library(janitor)

#p <- read_feather("d:/다운로드/CBD_raster_6456.feather")
p <- read_feather("CBD_raster_6456.feather")

p %>% 
  mutate(hour = case_when(layer >=  1 & layer <= 60  ~ "07",
                          layer >=  61 & layer <= 120  ~ "08",
                          layer >=  121 & layer <= 180  ~ "09",
                          layer >=  181 & layer <= 240  ~ "10",
                          layer >=  241 & layer <= 300  ~ "11",
                          layer >=  301 & layer <= 360  ~ "12",
                          layer >=  361 & layer <= 420  ~ "13",
                          layer >=  421 & layer <= 480  ~ "14",
                          layer >=  481 & layer <= 540  ~ "15",
                          layer >=  541 & layer <= 600  ~ "16",
                          layer >=  601 & layer <= 660  ~ "17",
                          layer >=  661 & layer <= 720  ~ "18",
                          layer >=  721 & layer <= 780  ~ "19",
                          layer >=  781 & layer <= 840  ~ "20",
                          layer >=  841 & layer <= 900  ~ "21",
                          layer >=  901 & layer <= 960  ~ "22",
                          layer >=  961 & layer <= 1020  ~ "23",
                          layer >=  1021 & layer <= 1080  ~ "00",
                          layer >=  1081 & layer <= 1140  ~ "01",
                          layer >=  1141 & layer <= 1200  ~ "02",
                          layer >=  1201 & layer <= 1260  ~ "03",
                          layer >=  1261 & layer <= 1320  ~ "04",
                          layer >=  1321 & layer <= 1380  ~ "05",
                          layer >=  1381 & layer <= 1440  ~ "06")
  ) -> p


p %>% 
  group_by(hour, x, y) %>% 
  summarise(z = max(z)) -> p1


p1 %>% 
  mutate(PM10 = case_when(z < 20 ~ "< 20",
                          z >= 20 & z < 40 ~ "20-40",
                          z >= 40 & z < 60 ~ "40-60",
                          z >= 60 & z < 80 ~ "60-80",
                          z >= 80 & z < 100 ~ "80-100",
                          z >= 100 & z < 120 ~ "100-120",
                          z >= 120 & z < 140 ~ "120-140",
                          TRUE ~ "> 140")) -> p1


cols <- c("< 20" = "#FFFFB2", 
          "20-40" = "#FECC5C",
          "40-60" = "#FD8D3C",
          "60-80" = "#F03B20",
          "80-100" = "#BD0026",
          "100-120" = "#252525",
          "120-140" = "#525252",
          "> 140" = "#252525")


p1 %>% 
  mutate(PM10 = factor(PM10, levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "120-140", "> 140"))) %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  labs(title = expression(paste("Max ", PM[10]," Concentration by Hours",sep="")),#"Mean PM10 Concentration by Hours",
       subtitle = "January 2nd, 2018") +
  facet_wrap(~hour, ncol = 6) + 
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_void() + 
  theme(legend.position = "bottom") -> plot_road_max


#ggsave("Map_Max.png", plot_road, dpi = 500, width = 8, height = 8)



p1 %>% 
  mutate(PM10 = factor(PM10, levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "120-140", "> 140"))) %>% 
  filter(hour == 10) -> max_10am

max_10am %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  labs(title = expression(paste("Max ", PM[10]," Concentration by Hours",sep="")),
       subtitle = "January 2nd 10:00, 2018",
       caption = "1 Pixel ≈ 30m\n Projection: Korean Central Belt (EPSG:5181)") +
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_minimal() +
  theme(legend.position = "bottom") -> plot_10am

#ggsave("Map_Max10am.png", plot_10am, dpi = 500, width = 6, height = 8)



max_10am %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  geom_point(aes(x=78, y=78), shape = 23, fill = "darkred") +
  geom_point(aes(x=105, y=95), shape = 23, fill = "darkblue") +
  labs(title = expression(paste("Max ", PM[10]," Concentration by Hours",sep="")),
       subtitle = "January 2nd 10:00, 2018",
       caption = "1 Pixel ≈ 30m\n Projection: Korean Central Belt (EPSG:5181)") +
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_minimal() +
  theme(legend.position = "bottom") -> plot_10am


#time-series plot
source('Sensitivity_map_max.R')


# Connect
arrowA <- data.frame(x1 = 9.7, x2 = 18, y1 = 9.8, y2 = 7.5)
arrowB <- data.frame(x1 = 12, x2 = 18, y1 = 11, y2 = 15)

ggdraw(xlim = c(0, 30), ylim = c(0, 20)) +
  draw_plot(plot_10am, x = 0, y = 0, width = 17, height = 20) +
  draw_plot(plot_emission_samil, x = 18, y = 4, width = 10, height = 5) +
  draw_plot(plot_emission_jongno, x = 18, y = 12, width = 10, height = 5) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrowA, 
               arrow = arrow(), lineend = "round")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrowB, 
               arrow = arrow(), lineend = "round")+
  theme_void() -> plot_max_graph


#ggsave("Map_MaxGraph.png", plot_max_graph, width = 8.5, height = 7, dpi = 500)

#################################################

p %>% 
  group_by(hour, x, y) %>% 
  summarise(z = mean(z)) -> p2


p2 %>% 
  mutate(PM10 = case_when(z < 20 ~ "< 20",
                          z >= 20 & z < 40 ~ "20-40",
                          z >= 40 & z < 60 ~ "40-60",
                          z >= 60 & z < 80 ~ "60-80",
                          z >= 80 & z < 100 ~ "80-100",
                          z >= 100 & z < 120 ~ "100-120",
                          z >= 120 & z < 140 ~ "120-140",
                          TRUE ~ "> 140")) -> p2


cols <- c("< 20" = "#FFFFB2", 
          "20-40" = "#FECC5C",
          "40-60" = "#FD8D3C",
          "60-80" = "#F03B20",
          "80-100" = "#BD0026",
          "100-120" = "#252525",
          "120-140" = "#525252",
          "> 140" = "#252525")


p2 %>% 
  mutate(PM10 = factor(PM10, levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "120-140", "> 140"))) %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  labs(title = expression(paste("Mean ", PM[10]," Concentration by Hours",sep="")),
       subtitle = "January 2nd, 2018") +
  facet_wrap(~hour, ncol = 6) + 
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_void() + 
  theme(legend.position = "bottom") -> plot_road_mean

#ggsave("Map_Mean.png", plot_road_mean, dpi = 500, width = 8, height = 8)



p2 %>% 
  mutate(PM10 = factor(PM10, levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "120-140", "> 140"))) %>% 
  filter(hour == 10) -> mean_10am

mean_10am %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  labs(title = expression(paste("Mean ", PM[10]," Concentration by Hours",sep="")),
       subtitle = "January 2nd 10:00, 2018",
       caption = "1 Pixel ≈ 30m\n Projection: Korean Central Belt (EPSG:5181)") +
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_minimal() +
  theme(legend.position = "bottom") -> plot_10am_mean

#ggsave("Map_Mean10am.png", plot_10am_mean, dpi = 500, width = 6, height = 8)


mean_10am %>% 
  ggplot(aes(x,y)) +
  geom_tile(aes(fill = PM10, group = PM10)) +
  geom_point(aes(x=78, y=78), shape = 23, fill = "darkred") +
  geom_point(aes(x=105, y=95), shape = 23, fill = "darkblue") +
  labs(title = expression(paste("Mean ", PM[10]," Concentration by Hours",sep="")),
       subtitle = "January 2nd 10:00, 2018",
       caption = "1 Pixel ≈ 30m\n Projection: Korean Central Belt (EPSG:5181)") +
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_minimal() +
  theme(legend.position = "bottom") -> plot_10am_mean


#time-series plot
source('Sensitivity_map_mean.R')



# Connect
arrowA <- data.frame(x1 = 9.7, x2 = 18, y1 = 9.8, y2 = 7.5)
arrowB <- data.frame(x1 = 12, x2 = 18, y1 = 11, y2 = 15)

ggdraw(xlim = c(0, 30), ylim = c(0, 20)) +
  draw_plot(plot_10am_mean, x = 0, y = 0, width = 17, height = 20) +
  draw_plot(plot_emission_samil_mean, x = 18, y = 4, width = 10, height = 5) +
  draw_plot(plot_emission_jongno_mean, x = 18, y = 12, width = 10, height = 5) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrowA, 
               arrow = arrow(), lineend = "round")+
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), data = arrowB, 
               arrow = arrow(), lineend = "round")+
  theme_void() -> plot_mean_graph


#ggsave("Map_MeanGraph.png", plot_mean_graph, width = 8.5, height = 7, dpi = 500)


###########
cowplot::plot_grid(plot_10am, plot_10am_mean, labels = c('A', 'B')) -> plot_10am_merge
ggsave("Map_10am_Merge.png", plot_10am_merge, width = 8, height = 6, dpi = 500, type = "cairo")


plot_grid(plot_road_mean, plot_road_max, labels = c('A', 'B'), hjust = -48, ncol = 1, align = "v") -> plot_emp
ggsave("Map_TS.png", plot_emp, width = 7, height = 14, dpi = 500, type = "cairo")


