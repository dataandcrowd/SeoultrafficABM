library(tidyverse)
library(terra)
library(raster)
library(cowplot)
library(RColorBrewer)

#files <- list.files("Spatial Output/")
files <- list.files(path="Spatial Output/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)
am10 <- rast(files[ 2:61])
am11 <- rast(files[62:121])



cuts <- c(20,40,60,80) #set breaks
pal <- colorRampPalette(c("#FFFFB2", "red"))

plot(mean(am10[[ 1:12]]), breaks=cuts, col = pal(4))
plot(mean(am10[[13:24]]))
plot(mean(am10[[25:36]]))
plot(mean(am10[[37:48]]))
plot(mean(am10[[49:60]]))

###############
#--To GGplot--#
###############
mean_am10 <- mean(am10[[1:60]])
mean_am11 <- mean(am11[[1:60]])

# Change to Data Frame
am10_stack_df <- as.data.frame(mean_am10, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "10am"))
  

am11_stack_df <- as.data.frame(mean_am11, xy = TRUE) %>% 
  tidyr::pivot_longer(cols = !c(x, y), 
                      names_to = 'variable', 
                      values_to = 'PM10') %>%
  mutate(x = x - 197000,
         y = y - 450000,
         variable = case_when(variable == "mean" ~ "11am"))


stack_df <- bind_rows(am10_stack_df, am11_stack_df)

# Plot
ggplot() + 
  geom_raster(data = stack_df, 
              aes(x = x, y = y, fill = PM10)) +
  facet_wrap(~variable) +
  scale_fill_gradientn(colours = rev(terrain.colors(10))) +
  coord_equal() + 
  labs(x = "Relative Distance (m)", y = "Relative Distance (m)", 
       title = (expression(paste("Hourly Averaged Concentrations of ", PM[10], " in Seoul CBD")))) +
  theme_minimal()  -> p

p

save_plot("map.pdf", p, base_height = 6.5, base_width = 10)
