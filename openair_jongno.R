library(tidyverse)
library(tidyquant)
library(openair)
library(sf)

# import pollution & weather data
aq <- read.csv("GIS/Pollution_Seoul_2018.txt") %>% 
  rename(City = "지역", Station = "측정소명", ID = "측정소ID", Time = "측정일시", 
         so2 = "SO2.ppm.", co = "CO.ppm.", o3 = "O3.ppm.", no2 = "NO2.ppm.", pm10 = "PM10.....", pm2.5 = "PM2.5.....")
met <- read.csv("GIS/Weather_Seoul_2018.txt", sep = "|") %>% 
       rename(Station = "지점번호", Date = "관측일", 
       TA_24H = "TA_00H", WS_24H = "WS_00H", WD_24H = "WD_00H", RN_24H = "RN_00H")

met$Date <- as.Date(met$Date, format = "%Y-%m-%d",tz = "Asia/Seoul")
