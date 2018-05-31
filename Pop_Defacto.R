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


######################
##--temporal stats--##
######################
#http://strimas.com/r/tidy-sf/



library(reshape2)
library(dplyr)
library(tidyquant)
Adminpop$Date <- as.Date(as.character(Adminpop$date), format = "%Y%m%d",tz = "Asia/Seoul")
popclean <- Adminpop[,-which(names(Adminpop) %in% c("H_SDNG_CD","DO_NM","CT_NM","H_DNG_NM"))]
popclean <- melt(popclean, id = c("admincd", "Date", "date", "hour"), variable.name = "pop_type", value.name = "pop_value")
totalpop <- filter(popclean, pop_type == "totalpop")#, Date == "2018-04-10")#, admincd == 11110515)

#Convert to a tibble
total.tib <- as_tibble(totalpop) %>%
  group_by(hour, pop_type)


total.week <- total.tib %>%
  tq_transmute(
    select     = pop_value,
    mutate_fun = apply.weekly, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "week_mean"
  )

total.week %>%
  ggplot(aes(x = hour, y = week_mean, group = Date)) +
  geom_smooth(method = "loess", aes(color = Date), se = FALSE) 


###################################################

#Convert to a tibble
total.tib1 <- as_tibble(totalpop) %>%
              group_by(hour, admincd)


total.week1 <- total.tib1 %>%
              tq_transmute(
                select     = pop_value,
                mutate_fun = apply.weekly, 
                FUN        = mean,
                na.rm      = TRUE,
                col_rename = "week_mean"
              )

total.week1 %>%
  ggplot(aes(x = hour, y = week_mean,group = admincd)) +
  geom_line(color = "grey", size= .7,alpha = 1/2) +
  facet_grid(~ Date) +
  theme_bw()


###################################################

#Convert to a tibble
total.tib3 <- as_tibble(totalpop) %>%
  group_by(hour, admincd)


total.day <- total.tib3 %>%
  tq_transmute(
    select     = pop_value,
    mutate_fun = apply.daily, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "daily_mean"
  )

total.day %>%
  ggplot(aes(x = hour, y = daily_mean,group = admincd)) +
  geom_line(color = "grey", size= .7,alpha = 1/2) +
  theme_bw()+
  facet_wrap(~ Date)

###################################################
library(plotly)

a <- total.week1 %>%
      ggplot(aes(x = hour, y = week_mean,group = admincd)) +
      geom_line(color = "grey", size= .7,alpha = 1/2) +
      #facet_wrap(~ my_colors, scales = 'free_x')
      facet_grid(~ Date)

a <- ggplotly(a)

#########################
#-- Import Shapefiles --#
#########################
# http://rmaps.github.io/blog/posts/animated-choropleths/





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
ad00 <- admin
ad01 <- admin
ad02 <- admin
ad03 <- admin
ad04 <- admin
ad05 <- admin
ad06 <- admin
ad07 <- admin
ad08 <- admin
ad09 <- admin
ad10 <- admin
ad11 <- admin
ad12 <- admin
ad13 <- admin
ad14 <- admin
ad15 <- admin
ad16 <- admin
ad17 <- admin
ad18 <- admin
ad19 <- admin
ad20 <- admin
ad21 <- admin
ad22 <- admin
ad23 <- admin
ad24 <- admin

ad00@data <- ad00@data[ad00@data$hour ==  0 & ad00@data$date == 20180430,] # Sampling hours equvalent to 0
ad01@data <- ad01@data[ad01@data$hour ==  0 & ad01@data$date == 20180430,] # Sampling hours equvalent to 0
ad02@data <- ad02@data[ad02@data$hour ==  0 & ad02@data$date == 20180430,] # Sampling hours equvalent to 0
ad03@data <- ad03@data[ad03@data$hour ==  0 & ad03@data$date == 20180430,] # Sampling hours equvalent to 0
ad04@data <- ad04@data[ad04@data$hour ==  0 & ad04@data$date == 20180430,] # Sampling hours equvalent to 0
ad05@data <- ad05@data[ad05@data$hour ==  0 & ad05@data$date == 20180430,] # Sampling hours equvalent to 0
ad06@data <- ad06@data[ad06@data$hour ==  0 & ad06@data$date == 20180430,] # Sampling hours equvalent to 0
ad07@data <- ad07@data[ad07@data$hour ==  0 & ad07@data$date == 20180430,] # Sampling hours equvalent to 0
ad08@data <- ad08@data[ad08@data$hour ==  0 & ad08@data$date == 20180430,] # Sampling hours equvalent to 0
ad09@data <- ad09@data[ad09@data$hour ==  0 & ad09@data$date == 20180430,] # Sampling hours equvalent to 0
ad10@data <- ad10@data[ad10@data$hour ==  0 & ad10@data$date == 20180430,] # Sampling hours equvalent to 0
ad11@data <- ad11@data[ad11@data$hour ==  0 & ad11@data$date == 20180430,] # Sampling hours equvalent to 0
ad12@data <- ad12@data[ad12@data$hour ==  0 & ad12@data$date == 20180430,] # Sampling hours equvalent to 0
ad13@data <- ad13@data[ad13@data$hour ==  0 & ad13@data$date == 20180430,] # Sampling hours equvalent to 0
ad14@data <- ad14@data[ad14@data$hour ==  0 & ad14@data$date == 20180430,] # Sampling hours equvalent to 0
ad15@data <- ad15@data[ad15@data$hour ==  0 & ad15@data$date == 20180430,] # Sampling hours equvalent to 0
ad16@data <- ad16@data[ad16@data$hour ==  0 & ad16@data$date == 20180430,] # Sampling hours equvalent to 0




#######################
library(RColorBrewer)
brewer.pal.info

cols <- brewer.pal(5, "Blues")
brks1 <- quantile(ad01@data$totalpop, c(.2, .4, .6, .8, .99)) 
brks2 <- quantile(ad02@data$totalpop, c(.2, .4, .6, .8, .99)) 
brks3 <- quantile(ad03@data$totalpop, c(.2, .4, .6, .8, .99)) 


gs1 <- cols[findInterval(ad01@data$totalpop, vec = brks1)]
gs2 <- cols[findInterval(ad02@data$totalpop, vec = brks2)]
gs3 <- cols[findInterval(ad03@data$totalpop, vec = brks3)]

plot(ad01, col = gs1, main = "Population at 00H\n30th April 2018")
plot(ad02, col = gs2, main = "Population at 16H\n30th April 2018")
plot(ad03, col = gs3, main = "Population at 20H\n30th April 2018")

##Leaflet Package 
