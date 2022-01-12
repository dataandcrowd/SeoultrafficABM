library(sf)
library(terra)
library(raster)
library(RColorBrewer)

#files <- list.files("Spatial Output/")
files <- list.files(path="Spatial Output/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)
s <- rast(files[2:61])

cuts <- c(20,40,60,80) #set breaks
pal <- colorRampPalette(c("#FFFFB2", "red"))

plot(mean(s[[ 1:12]]), breaks=cuts, col = pal(4))
plot(mean(s[[13:24]]))
plot(mean(s[[25:36]]))
plot(mean(s[[37:48]]))
plot(mean(s[[49:60]]))

