library(sf)
library(terra)
library(raster)

#files <- list.files("Spatial Output/")
files <- list.files(path="Spatial Output/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)
s <- rast(files[2:61])

plot(s)
