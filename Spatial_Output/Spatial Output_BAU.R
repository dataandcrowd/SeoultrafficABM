library(tidyverse)
library(terra)
library(raster)
library(cowplot)
library(RColorBrewer)

files <- list.files(path="BAU/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)

time10 <- rast(files[  2: 61])
time11 <- rast(files[ 62:121])
time12 <- rast(files[122:181])
time13 <- rast(files[182:241])
time14 <- rast(files[242:301])
time15 <- rast(files[302:361])
time16 <- rast(files[362:421])
time17 <- rast(files[422:481])
time18 <- rast(files[482:541])
time19 <- rast(files[542:601])
time20 <- rast(files[602:661])
time21 <- rast(files[662:721])
time22 <- rast(files[722:781])
time23 <- rast(files[782:841])
time24 <- rast(files[842:901])
time01 <- rast(files[902:961])
time02 <- rast(files[962:1021])
time03 <- rast(files[1022:1081])
time04 <- rast(files[1082:1141])
time05 <- rast(files[1142:1201])
time06 <- rast(files[1202:1261])
time07 <- rast(files[1262:1321])
time08 <- rast(files[1322:1381])
time09 <- rast(files[1382:1441])


###############
#--To GGplot--#
###############
mean_time08 <- mean(time08[[1:60]])
mean_time13 <- mean(time13[[1:60]])
mean_time18 <- mean(time18[[1:60]])
mean_time02 <- mean(time02[[1:60]])

max_time08 <- max(time08[[1:60]])
max_time13 <- max(time13[[1:60]])
max_time18 <- max(time18[[1:60]])
max_time02 <- max(time02[[1:60]])

# Change to Data Frame
# mean



#eval(parse(text=paste0("as.data.frame(mean_time", 13, ", xy = TRUE)")))


time08_df <- as.data.frame(mean_time08, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "mean" ~ "08:00"))


time13_df <- as.data.frame(mean_time13, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "mean" ~ "13:00"))

time18_df <- as.data.frame(mean_time18, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "mean" ~ "18:00"))

time02_df <- as.data.frame(mean_time02, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "mean" ~ "02:00"))

# max
time08_df_max <- as.data.frame(max_time08, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "max" ~ "08:00"))


time13_df_max <- as.data.frame(max_time13, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "max" ~ "13:00"))

time18_df_max <- as.data.frame(max_time18, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "max" ~ "18:00"))

time02_df_max <- as.data.frame(max_time02, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(variable = case_when(variable == "max" ~ "02:00"))


# Stack
stack_df <- bind_rows(time08_df, time13_df, time18_df)
stack_df_max <- bind_rows(time08_df_max, time13_df_max, time18_df_max)


# Add categorical value for plotting
stack_df %>% 
  mutate(PM10_cat = case_when(
    PM10 == 0 ~ "NA", 
    PM10 > 0 & PM10 < 20 ~ "< 20",
    PM10 >= 20 & PM10 < 40 ~ "20-40",
    PM10 >= 40 & PM10 < 60 ~ "40-60",
    PM10 >= 60 & PM10 < 80 ~ "60-80",
    PM10 >= 80 & PM10 < 100 ~ "80-100",
    PM10 >= 100 & PM10 < 120 ~ "100-120",
    TRUE ~ "> 120")) -> stack_df


stack_df_max %>% 
  mutate(PM10_cat = case_when(
    PM10 == 0 ~ "NA", 
    PM10 > 0 & PM10 < 20 ~ "< 20",
    PM10 >= 20 & PM10 < 40 ~ "20-40",
    PM10 >= 40 & PM10 < 60 ~ "40-60",
    PM10 >= 60 & PM10 < 80 ~ "60-80",
    PM10 >= 80 & PM10 < 100 ~ "80-100",
    PM10 >= 100 & PM10 < 120 ~ "100-120",
    TRUE ~ "> 120")) -> stack_df_max


cols <- c("NA" = "#fcfcfc",
          "< 20" = "#FAF6A4", 
          "20-40" = "#FECC5C",
          "40-60" = "#FD8D3C",
          "60-80" = "#F03B20",
          "80-100" = "#BD0026",
          "100-120" = "#252525",
          "> 120" = "#525252")



stack_df %>% 
  mutate(PM10_cat = factor(PM10_cat, 
                           levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "> 120", "NA"))) %>% 
  ggplot(aes(x,y)) +
  geom_raster(aes(fill = PM10_cat, group = PM10_cat)) +
  labs(title = (expression(paste("      Hourly Averaged Concentrations of ", PM[10], " in Seoul CBD"))),
       subtitle = "       Scenario: Business-as-Usual") +
  facet_wrap(~variable, ncol = 3) + 
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_void() + 
  theme(legend.position = "none") -> p


# Plot

stack_df_max %>% 
  mutate(PM10_cat = factor(PM10_cat, 
                           levels = c("< 20", "20-40", "40-60", "60-80", "80-100", "100-120", "> 120", "NA"))) %>% 
  ggplot(aes(x,y)) +
  geom_raster(aes(fill = PM10_cat, group = PM10_cat)) +
  labs(#x = "Relative Distance (m)", y = "Relative Distance (m)", 
    title = (expression(paste("      Hourly Maximum Concentrations of ", PM[10], " in Seoul CBD"))),
    subtitle = "       Scenario: Business-as-Usual",
    fill= (expression(PM[10]))) +
  facet_wrap(~variable, ncol = 3) + 
  scale_fill_manual(values = cols, aesthetics = c("colour", "fill")) +
  theme_void() + 
  theme(legend.position = "bottom") -> p1

#p1

final <- plot_grid(p, p1, labels = c('A', 'B'), ncol = 1, align = "v", rel_heights = c(.85, 1), label_size = 12)
save_plot("Spatial_BAU.pdf", final, base_height = 7, base_width = 7)
#save_plot("Spatial_BAU.jpg", final, base_height = 7, base_width = 7)


################################
#--Find the nearest location--##
################################

# Samil
time08_df %>% 
  filter(x >= 198980 & x <= 199080 & y >= 451250 & y <= 451350) %>% 
  pull(PM10) %>% mean
# Samil near
time08_df %>% 
  filter(x >= 198940 & x <= 199050 & y >= 451050 & y <= 451080) %>% 
  pull(PM10) %>% mean


# Jongno
time08_df %>% 
  filter(x >= 199758 & x <= 199858 & y >= 452301 & y <= 452401) %>% 
  pull(PM10) %>% mean

# Jongno near
time08_df %>% 
  filter(x >= 199572 & x <= 199672 & y >= 452379 & y <= 452479) %>% 
  pull(PM10) %>% mean


# Sejong
time08_df %>% 
  filter(x >= 197884 & x <= 197984 & y >= 452752 & y <= 452852) %>% 
  pull(PM10) %>% mean

time08_df %>% 
  filter(x >= 197734 & x <= 197834 & y >= 452605 & y <= 452705) %>% 
  pull(PM10) %>% mean

