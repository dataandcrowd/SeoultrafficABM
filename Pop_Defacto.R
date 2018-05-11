setwd("D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")
setwd("~/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")
options(scipen = 10000, width = 10)

library(readr)
jippop <- read_csv("pop_jip_20180504.csv")
colnames(jippop) <- c('date','hour','admincd','totalpop',
                      'M00','M10','M15','M20','M25','M30','M35',
                      'M40','M45','M50','M55','M60','M65','M70',
                      'F00','F10','F15','F20','F25','F30','F35',
                      'F40','F45','F50','F55','F60','F65','F70')
for(i in 1:length(jippop)){
  jippop[[i]] <- as.numeric(jippop[[i]])
  
}
jippop <- jippop[order(jippop$hour, jippop$blockcd),]


adminpop <- read_csv("pop_admin_20180504.csv")
colnames(adminpop) <- c('date','hour','admincd','totalpop',
                        'M00','M10','M15','M20','M25','M30','M35',
                        'M40','M45','M50','M55','M60','M65','M70',
                        'F00','F10','F15','F20','F25','F30','F35',
                        'F40','F45','F50','F55','F60','F65','F70')
for(i in 1:length(adminpop)){
  adminpop[[i]] <- as.numeric(adminpop[[i]])
  
}
adminpop <- adminpop[order(adminpop$hour, adminpop$admincd),]


###########################
#-- Add code match book --#
###########################
codebook <- read.csv("adm_code_match.csv")
Adminpop <- merge(adminpop, codebook, by.x = "admincd", by.y = "H_DNG_CD")


#########################
#-- Import Shapefiles --#
#########################
library(rgdal)
path <- "D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Boundary/Sudo/"
jip   <- readOGR(paste0(path, 'Seoul_Jipgegu.shp'))
admin <- readOGR(paste0(path,'Seoul_Dong_Admin.shp'))
admin@data <- admin@data[,4:7]
admin@data[[1]] <- as.numeric(as.character(admin@data[[1]]))
admin@data <- admin@data[order(admin@data$DONG_CODE),]


jip@data   <- merge(jip@data, jippop[1:5], by.x = "TOT_OA_CD", by.y = "blockcd")
admin@data <- merge(admin@data, Adminpop, by.x = "DONG_CODE", by.y = 'H_SDNG_CD')

#writeOGR(admin, "admin",driver="ESRI Shapefile")


##Leaflet Package ?´?š©?•´?•¼?•¨
