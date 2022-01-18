library(tidyverse)
library(terra)
library(raster)
library(cowplot)
library(RColorBrewer)

files <- list.files(path="Spatial_Output/DEC/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)

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
mean_time21 <- mean(time21[[1:60]])


# Change to Data Frame
time08_df <- as.data.frame(mean_time08, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "08:00"))


time13_df <- as.data.frame(mean_time13, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "13:00"))

time18_df <- as.data.frame(mean_time18, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "18:00"))

time21_df <- as.data.frame(mean_time21, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "21:00"))

stack_df <- bind_rows(time08_df, time13_df, time18_df, time21_df)

# Plot
ggplot() + 
  geom_raster(data = stack_df, 
              aes(x = x, y = y, fill = PM10)) +
  facet_wrap(~variable) +
  scale_fill_gradientn(colours = rev(terrain.colors(10))) +
  coord_equal() + 
  labs(x = "Relative Distance (m)", y = "Relative Distance (m)", 
       title = (expression(paste("Hourly Averaged Concentrations of ", PM[10], " in Seoul CBD"))),
       subtitle = "Scenario: Banning 90% of the Inbound Traffic") +
  theme_minimal()  -> p

p

save_plot("Spatial_DEC.pdf", p, base_height = 6, base_width = 6)
