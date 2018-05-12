setwd("D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto") # Windows
setwd("~/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")  # MacOS
options(scipen = 10000, width = 10)

library(readr)
jippop <- read_csv("pop_jip_20180504.csv")
colnames(jippop) <- c('date','hour','admincd', 'blockcd','totalpop',
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
codebook <- read.csv("adm_code_match.csv") # Windows
codebook <- read.csv("adm_code_match.csv", fileEncoding = "CP949", encoding = "UTF-8") # MacOS
Adminpop <- merge(adminpop, codebook, by.x = "admincd", by.y = "H_DNG_CD")
rm(adminpop)

#########################
#-- Import Shapefiles --#
#########################
library(rgdal)
path <- "D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Boundary/Sudo/"
path <- "~/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Boundary/Sudo/"

jip   <- readOGR(paste0(path, 'Seoul_Jipgegu.shp'))
admin <- readOGR(paste0(path,'Seoul_Dong_Admin.shp'))
admin@data <- admin@data[,4:7]
admin@data[[1]] <- as.numeric(as.character(admin@data[[1]]))
admin@data <- admin@data[order(admin@data$DONG_CODE),]

jip@data   <- merge(jip@data, jippop[1:5], by.x = "TOT_OA_CD", by.y = "blockcd")
admin@data <- merge(admin@data, Adminpop, by.x = "DONG_CODE", by.y = 'H_SDNG_CD')

###############
ad1 <- admin
ad2 <- admin
ad3 <- admin

ad1@data <- ad1@data[ad1@data$hour ==  0 & ad1@data$date == 20180430,] # Sampling hours equvalent to 0
ad2@data <- ad2@data[ad2@data$hour == 16 & ad1@data$date == 20180430,] # Sampling hours equvalent to 16
ad3@data <- ad3@data[ad3@data$hour == 20 & ad1@data$date == 20180430,] # Sampling hours equvalent to 20

#######################
library(RColorBrewer)
brewer.pal.info

cols <- brewer.pal(5, "Blues")
brks1 <- quantile(ad1@data$totalpop, c(.2, .4, .6, .8, .99)) 
brks2 <- quantile(ad2@data$totalpop, c(.2, .4, .6, .8, .99)) 
brks3 <- quantile(ad3@data$totalpop, c(.2, .4, .6, .8, .99)) 


gs1 <- cols[findInterval(ad1@data$totalpop, vec = brks1)]
gs2 <- cols[findInterval(ad2@data$totalpop, vec = brks2)]
gs3 <- cols[findInterval(ad3@data$totalpop, vec = brks3)]

plot(ad1, col = gs1, main = "Population at 00H\n30th April 2018")
plot(ad2, col = gs2, main = "Population at 16H\n30th April 2018")
plot(ad3, col = gs3, main = "Population at 20H\n30th April 2018")

##Leaflet Package 
