library(tidyverse)
library(sf)
library(dodgr)

setwd("d:/Dropbox (Cambridge University)/2018_Cambridge/[Database]")
od <- read.table("Transport/AG_TRCH_20151021.txt", header = T, sep = ";")#,fileEncoding="CP949", encoding="UTF-8") # MacOSX
names(od) <- gsub(" ","",names(od))
#od$orgin <- as.numeric(as.character(od$orgin))
#od$des <- as.numeric(as.character(od$des))

#setwd("D:/github/seoulbigdata/GIS")
#sdm <- st_read("Seoul_4daemoonArea.shp")
#sdm1 <- sdm %>% select(base_year, DONG_CODE, adm_dr_nm_) %>% as.data.frame()
#plot(sdm[,7], axes = T)

od_sajik <- od %>% 
            filter( origin == "1101053")
