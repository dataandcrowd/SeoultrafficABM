library(sf)
library(terra)
library(raster)

#files <- list.files("Output/")
#files <- list.files(path="Output/", pattern="asc", all.files=FALSE, full.names=TRUE,recursive=TRUE)
#s <- stack(files)
#rast(s[1])
load("terra.RData")

ss <- rast(ascii)
