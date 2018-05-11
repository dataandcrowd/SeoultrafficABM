setwd("D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")
setwd("~/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")
options(scipen = 10000, width = 10)

library(readr)
jippop <- read_csv("pop_jip_20180504.csv")
colnames(jippop) <- c('date','hour','admincd','blockcd','totalpop',
                      'm0-9','m10-14','m15-19','m20-24','m25-29','m30-34','m35-39',
                      'm40-44','m45-49','m50-54','m55-59','m60-64','m65-69','m70',
                      'f0-9','f10-14','f15-19','f20-24','f25-29','f30-34','f35-39',
                      'f40-44','f45-49','f50-54','f55-59','f60-64','f65-69','f70'
)
for(i in 1:length(jippop)){
  jippop[[i]] <- as.numeric(jippop[[i]])
  
}
jippop <- jippop[order(jippop$hour, jippop$blockcd),]


adminpop <- read_csv("pop_admin_20180504.csv")
colnames(adminpop) <- c('date','hour','admincd','totalpop',
                        'm0-9','m10-14','m15-19','m20-24','m25-29','m30-34','m35-39',
                        'm40-44','m45-49','m50-54','m55-59','m60-64','m65-69','m70',
                        'f0-9','f10-14','f15-19','f20-24','f25-29','f30-34','f35-39',
                        'f40-44','f45-49','f50-54','f55-59','f60-64','f65-69','f70'
)
for(i in 1:length(adminpop)){
  adminpop[[i]] <- as.numeric(adminpop[[i]])
  
}
adminpop <- adminpop[order(adminpop$hour, adminpop$admincd),]





setwd("D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Boundary/Sudo")
library(rgdal)
jip   <- readOGR('Seoul_Jipgegu.shp')
admin <- readOGR('seoul_emd_5181.shp')
admin@data <- admin@data[,c(1,3,5,6)]
admin@data[[1]] <- as.numeric(as.character(admin@data[[1]]))

a <- admin@data
a <- a[order(a$EMD_CD),]


jip@data   <- merge(jip@data, jippop[1:5], by.x = "TOT_OA_CD", by.y = "blockcd")
#admin@data <- merge(admin@data, adminpop[1:4], by.x = "EMD_CD", by.y = 'admincd')




##Leaflet Package 이용해야함
