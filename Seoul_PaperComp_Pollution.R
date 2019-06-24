#-- Overview
## 1. Load packages
## 2. Analyse pollution data
## 3. Combine and analyse meteorological data with "openair" package
## 4. National Limit
## 5. Background vs Roadside

#--1. Load packages
library(tidyverse)
library(tidyquant)
library(openair)
library(imputeTS)
library(xts)
library(forecast)

#--2. Analyse pollution data
setwd("d:/Dropbox (Cambridge University)/2018_Cambridge/[Programming]/R/1.Dissertation_Descriptive statistics/data")
files  <- list.files(pattern= "seoul_|gg_.*.csv")
tables <- lapply(files, read.csv, header = TRUE)#, fileEncoding="CP949", encoding="UTF-8") # MacOSX
aq <- do.call(rbind, tables)
aq[aq == -999] <- NA

setwd("d:/Dropbox (Cambridge University)/2018_Cambridge/[Programming]/R/1.Dissertation_Descriptive statistics")

######################################
for(i in c(3,5:10)){
  aq[,i] <- as.numeric(aq[,i])
}

######################################
aq <- aq %>% arrange(Station.ID, Date)

# We now have to add time to analyse pollution temporally
aq$time1<- lubridate::parse_date_time(as.character(aq$Date), "ymdH", tz = "Asia/Seoul")
aq$DATE <- lubridate::as_date(as.character(aq$Date), format = "%Y%m%d",tz = "Asia/Seoul")
aq$hour <- lubridate::hour(aq$time)
########################################
aq.new  <- aq %>%
  filter(Station.ID %in% 111121)

aqclean <- aq.new %>% select(o3,no2,pm10)

o3.ts   <- aqclean[[1]]
no2.ts  <- aqclean[[2]]
pm10.ts <- aqclean[[3]]

time_index <- seq(from = as.POSIXct("2010-01-01 01:00"), 
                  to = as.POSIXct("2018-01-01 00:00"), by = "hour", tz = "Asia/Seoul")

df_o3  <- msts(o3.ts, seasonal.periods = c(24*7))
df_no2 <- msts(no2.ts, seasonal.periods = c(24*7))
df_pm10<- msts(pm10.ts, seasonal.periods = c(24*7))

plotNA.distribution(df_o3)
plotNA.distribution(df_no2)
plotNA.distribution(df_pm10)

o3  <- na.locf(df_o3, option = "locf")
no2 <- na.locf(df_no2, option = "locf")
pm10<- na.locf(df_pm10, option = "locf")

imp <- cbind(o3, no2, pm10) %>% as.data.frame()

aqclean1 <- aq.new %>% select(DATE, hour) %>% cbind(imp)

aqclean1 <- aqclean1 %>% 
  reshape2::melt(id = c("DATE","hour"),
                 variable.name = "Type",value.name = "Value")

write.csv(aqclean1, "poll-stats.csv")

###########################################
#Convert to a tibble
aq.tib <- as_tibble(aqclean) %>%
  group_by(hour,Type,place)

aq.week <- aq.tib %>%
  tq_transmute(
    select     = Value,
    mutate_fun = apply.weekly, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "mean_value"
  )

aq.week %>%
  ggplot(aes(x = DATE, y = mean_value, group = place, color = Type)) +
  geom_point() +
  geom_smooth(method = "loess", aes(color = place, fill = place)) + 
  labs(x = "", y = "Concentration") +
  #facet_grid(rows = vars(Type), scale = "free_y") +
  facet_wrap(~ Type, scale = "free_y") +
  expand_limits(y = 0) + 
  scale_color_tq() +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 


#-- Month --#

aq.month <- aq.tib %>%
  tq_transmute(
    select     = Value,
    mutate_fun = apply.monthly, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "mean_value"
  )

aq.month %>%
  ggplot(aes(x = DATE, y = mean_value, color = Type)) +
  geom_point() +
  geom_smooth(method = "loess", aes(color = place, fill = place)) + 
  labs(#title = "6 Main Pollutants: Average daily Concentration by Month",
    x = "", y = "Concentration") +
  facet_wrap(~ Type, scale = "free_y") +
  expand_limits(y = 0) + 
  scale_color_tq() +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 



#!! Hourly Data: Boxplot

aq.month %>%
  ggplot(aes(x = hour, y = mean_value, group = hour, fill = Type)) +
  geom_boxplot() +
  #geom_smooth(method = "loess", aes(color = Province, fill = Province)) + 
  labs(#title = "6 Main Pollutants: Average Monthly Concentration by Hours",
    x = "", y = "Concentration") +
  scale_x_continuous(breaks =  seq(0, 23, by = 1)) +
  facet_wrap(~ Type, scale = "free_y") +
  expand_limits(y = 0) + 
  scale_color_tq() +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 


#--3. Combine and analyse meteorological data with "openair" package

setwd("d:/Dropbox (Cambridge University)/2018_Cambridge/[Programming]/R/1.Dissertation_Descriptive statistics/met")
files  <- list.files(pattern= "*.txt")
tables <- lapply(files, read.table, header = TRUE,sep = "|")#, fileEncoding="CP949", encoding="UTF-8")
w <- do.call(rbind, tables)
weather <- w %>% 
          rename(stn_id = "지점번호", Date = "관측일")

w_reform0 <- weather %>% 
            reshape2::melt(id = c("stn_id","Date"), variable.name = "Type", value.name = "Value") %>% 
            mutate(Type1 = substr(Type,1,2), hour = substr(Type, 4,5))

w_reform1 <- w_reform0 %>%
            select(-Type) %>% 
            reshape2::dcast(stn_id + Date + hour  ~  Type1, value.var = "Value") %>% 
            rename(temp = 'TA', pre = 'RN', wd = 'WD', ws = 'WS')

w_reform1$Time  <- gsub("-","", as.character(w_reform1$Date))%>% 
                  paste0(as.character(w_reform1$Time), w_reform1$hour) %>%
                  as.POSIXct(w_reform1$Time, format = "%Y%m%d%H",tz = "Asia/Seoul")

w_jongno <- w_reform1[w_reform1$stn_id == 508,] # Station no.508: Jong-no AWS
w_sseoulstn  <- w_reform1[w_reform1$stn_id == 419,] # Station no.419: Jung-gu AWS


{
  poll_jongno0 <- aq[aq$Station.ID == 111121,] # Station 111121: Junggu background monitoring station
  poll_jongno0 <- poll_jongno0 %>% 
                select(time1, so2, co, o3, no2, pm10, pm2.5)
  poll_jongno1 <- poll_jongno0 %>% 
                reshape2::melt(id = "time1",variable.name = "Type",value.name = "Value")
  poll_jongno2 <- poll_jongno1 %>% 
                reshape2::dcast(formula = time1  ~ Type, value.var = "Value", fun.aggregate = sum, na.rm = F)
  poll_jongno <- merge(w_jongno, poll_jongno2, by.x = "Time", by.y = "time1")
  rm(poll_jongno0);rm(poll_jongno1);rm(poll_jongno2)
} 

{
  poll_syeok0 <- aq[aq$Station.ID == 111122,] # Station 111122: Hangangdaero(Seoul Station) kerbside station
  poll_syeok0 <- poll_syeok0 %>% 
                  select(time1, so2, co, o3, no2, pm10, pm2.5)
  poll_syeok1 <- poll_syeok0 %>% 
                  reshape2::melt(id = "time1",variable.name = "Type",value.name = "Value")
  poll_syeok2 <- poll_syeok1 %>% 
                  reshape2::dcast(formula = time1  ~ Type, value.var = "Value", fun.aggregate = sum, na.rm = F)
  poll_syeok <- merge(w_sseoulstn, poll_syeok2, by.x = "Time", by.y = "time1")
  rm(poll_syeok0);rm(poll_syeok1);rm(poll_syeok2)
} 

#####################
#--Openair Package--#
#####################
air_jongno  <- rename(poll_jongno[,-2], date = Time, ws = ws, wd = wd)
air_syeok <- rename(poll_syeok[,-2], date = Time, ws = ws, wd = wd)
air_jongno$district <- "Jongno"
air_syeok$district <- "Seoul.Stn"

air <- rbind(air_jongno, air_syeok)

#Summary Plot
summaryPlot(air_jongno, percentile = 0.95) # exclude highest 5 % of data etc.
summaryPlot(air_jongno, col.data = "green") # show data in green
summaryPlot(air_jongno, col.mis = "yellow") # show missing data in yellow
summaryPlot(air_jongno, col.dens = "black", fontsize = 20) # show density plot line in black
summaryPlot(air_jongno[, c(1, 2, 5:7)]) # Just in case there are too much info in one plot

#Calendar Plot
calendarPlot(air_jongno, pollutant = "pm10", year = 2016, w.shift = 2)

#Wind Rose
windRose(air_jongno)
windRose(air_jongno, type = "pm10", layout = c(4, 1))

#Pollution Rose
pollutionRose(air_jongno, pollutant = "pm10")
pollutionRose(air_jongno, pollutant = "no2",breaks = c(0,0.025,0.05,0.075))#, layout = c(4,1))

# Jongno: 37.57	126.97
# Seoul Stn: 37.5535	126.9864

#Percentile Rose
percentileRose(air_jongno, pollutant = "pm10",
               type = c("season","daylight"),
               percentile = c(25, 50, 75, 90, 95, 99, 99.9),
               #col = "brewer1",
               key.position = "bottom",
               fontsize = 20,
               longitude = 126.97, # Jongno Longitude
               latitude = 37.57, # Jongno Latitude
               col = "Set3",
               mean.col = "black",
               smooth = T)

percentileRose(air_jongno, pollutant = "no2",
               type = c("season","daylight"),
               percentile = c(25, 50, 75, 90, 95, 99, 99.9),
               key.position = "bottom",
               fontsize = 20,
               longitude = 126.97, # Jongno Longitude
               latitude = 37.57, # Jongno Latitude
               col = "brewer1",
               mean.col = "black",
               smooth = T)

percentileRose(air_jongno, pollutant = "o3",
               type = c("season","daylight"),
               percentile = c(25, 50, 75, 90, 95, 99, 99.9),
               key.position = "bottom",
               fontsize = 20,
               col = "heat",
               longitude = 126.85, # Seoul Longitude
               latitude = 37.56, # Seoul Latitude
               mean.col = "black",
               smooth = T)

percentileRose(air_jongno, poll=c("o3","no2"),
               percentile = 95,
               method = "cpf", #CPF method!!
               col = "forestgreen",
               layout = c(2,1),
               fontsize = 20,
               smooth = TRUE)

#Polar Cluster
polarCluster(air_jongno, pollutant="no2")#, n.clusters=2:10, cols= "Set2")

#Polar Frequency
polarFreq(air_jongno, pollutant="pm10", statistic = "weighted.mean", type="year", fontsize = 20)
polarFreq(air_jongno, pollutant="pm10", statistic = "weighted.mean", type= c("year","daylight"), longitude = 126.85,
          latitude = 37.56, fontsize = 20)
polarFreq(air_jongno, pollutant="pm10", statistic = "weighted.mean", type="monthyear", n.levels = 10, fontsize = 20)


#Smooth Function: Deseasonal Trend
smoothTrend(air_jongno, pollutant = "o3", ylab = "Concentration (ppm)", main = "Monthly mean o3", fontsize = 20)
smoothTrend(air_jongno, pollutant = "o3", deseason = TRUE, ylab = "Concentration (ppm)", main = "Monthly mean deseasonalised o3", fontsize = 20)
smoothTrend(air_jongno, pollutant = "no2", simulate = TRUE, ylab = "Concentration (ug/m3)", fontsize = 20, main = "Monthly mean no2 \n(bootstrap uncertainties)")
smoothTrend(air_jongno, pollutant = "no2", deseason = TRUE, simulate =TRUE,
            ylab = "Concentration (ug/m3)", fontsize = 20,
            main = "Monthly mean deseasonalised no2 \n(bootstrap uncertainties)")

smoothTrend(air_jongno, pollutant = "o3", deseason = TRUE, type = "wd")
smoothTrend(air_jongno, pollutant = c("no2", "o3"), type = c("wd", "season"), date.breaks = 3, lty = 0)

#Time Variation
timeVariation(subset(air_jongno, ws > 3 & wd > 100 & wd < 270),
              pollutant = "pm10", fontsize = 20,
              ylab = "pm10 (ug/m3)")

timeVariation(air_jongno,
              pollutant = c("pm10", "no2", "o3"), fontsize = 20,
              normalise = TRUE)

air_jongno1 <- splitByDate(air_jongno, dates= "2013-01-01 01:00:00",
                         labels = c("before Jan. 2013", "After Jan. 2013"))

timeVariation(air_jongno1, pollutant = "pm10", group = "split.by", fontsize = 20, difference = TRUE)
timeVariation(air_jongno1, pollutant = "no2", group = "split.by", fontsize = 20, difference = TRUE)
timeVariation(air_jongno1, pollutant = "o3", group = "split.by", fontsize = 20, difference = TRUE)

timeVariation(air_jongno, pollutant = "no2", statistic = "median", fontsize = 20, col = "jet")
timeVariation(air_jongno, pollutant = "o3", statistic = "median", fontsize = 20, col = "darkorange")
timeVariation(air_jongno, pollutant = "pm10", statistic = "median", fontsize = 20, col = "firebrick")


#Scatterplot
air_jongno2015 <- selectByDate(air_jongno, year = 2015)
scatterPlot(air_jongno2013, x = "o3", y = "no2")
scatterPlot(air_jongno2015, x = "o3", y = "no2", method = "hexbin", col= "jet",border = "grey", xbin = 15)
scatterPlot(selectByDate(air_jongno, year = 2010), x = "o3", y = "no2", method = "density", col = "jet")
scatterPlot(air_jongno2013, x = "o3", y = "no2", type = "pm10", smooth = FALSE, linear = TRUE, layout = c(2, 2))
scatterPlot(air_jongno2013, x = "o3", y = "no2", z = "pm10", type = c("season", "weekend"), limits = c(0, 150))

#CorPlot
corPlot(air_jongno, fontsize = 15, type = "season")
#corPlot(air_jongno, fontsize = 15, type = "year")
corPlot(air_jongno, fontsize = 15, dendrogram = TRUE)



###########################
#--Openair: Application--##
###########################

# Smoothtrend
smoothTrend(juair, pollutant = "o3", deseason = TRUE, ylab = "concentration (ppm)", fontsize = 20,
            main = "Monthly mean deseasonalised o3")
smoothTrend(juair, pollutant = "no2", deseason = TRUE, ylab = "concentration (ppm)", cols = "blue",fontsize = 20,
            main = "Monthly mean deseasonalised no2")
smoothTrend(gnair, pollutant = "o3", deseason = TRUE, ylab = "concentration (ppm)", fontsize = 20,
            main = "Monthly mean deseasonalised o3")
smoothTrend(gnair, pollutant = "no2", deseason = TRUE, ylab = "concentration (ppm)", cols = "blue",fontsize = 20,
            main = "Monthly mean deseasonalised no2")
smoothTrend(gwair, pollutant = "o3", deseason = TRUE, ylab = "concentration (ppm)", fontsize = 20,
            main = "Monthly mean deseasonalised o3")
smoothTrend(gwair, pollutant = "no2", deseason = TRUE, ylab = "concentration (ppm)", cols = "blue",fontsize = 20,
            main = "Monthly mean deseasonalised no2")

# Time Variation
timeVariation(air, pollutant = "no2", group = "district", ylab = "no2 (ppm)", fontsize = 20)
timeVariation(air, pollutant = "pm10", group = "district", ylab = "pm10 (ug/m3)", col = "Spectral", fontsize = 20)
timeVariation(air, pollutant = "o3", group = "district", ylab = "o3 (ppm)", col = "Spectral", fontsize = 20)
timeVariation(air_jongno, pollutant = "pm10", statistic = "median", col = "firebrick", fontsize = 20)


#--4. National Limit
mean_wt <- data.frame(Type = c("no2", "pm10", "pm2.5", "o3"), wt.year = c(0.03, 50, 15, NA),
                      wt.day = c(0.06, 100, 35, 0.06), wt.hour = c(0.10, NA, NA, 0.1)
                      )

aq.week %>%
  ggplot(aes(x = DATE, y = mean_value, group = place, color = Type)) +
  geom_point() +
  geom_smooth(method = "loess", aes(color = place, fill = place)) + 
  labs(x = "", y = "Concentration") +
  geom_hline(aes(yintercept = wt.year), mean_wt, colour="black",linetype="dashed", size = 1) +
  geom_hline(aes(yintercept = wt.day ), mean_wt, colour="black",linetype="dashed", size = 1) +
  geom_hline(aes(yintercept = wt.hour), mean_wt, colour="black",linetype="dashed", size = 1) +
  facet_grid(rows = vars(Type), scale = "free_y") +
  #facet_wrap(~ Type, scale = "free_y") +
  expand_limits(y = 0) + 
  scale_color_tq() +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 


aq.tib %>%
  ggplot(aes(x = DATE, y = Value, group = place, color = Type)) +
  geom_point() +
  geom_smooth(method = "loess", aes(color = place, fill = place)) + 
  labs(x = "", y = "Concentration") +
  geom_hline(aes(yintercept = wt.year), mean_wt, colour="black",linetype="dashed", size = 1) +
  geom_hline(aes(yintercept = wt.day ), mean_wt, colour="black",linetype="dashed", size = 1) +
  geom_hline(aes(yintercept = wt.hour), mean_wt, colour="black",linetype="dashed", size = 1) +
  facet_grid(rows = vars(Type), scale = "free_y") +
  #facet_wrap(~ Type, scale = "free_y") +
  expand_limits(y = 0) + 
  scale_color_tq() +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 




#--5. Background vs Roadside
#1. Visulisation: Boxplot
air$year <- lubridate::year(air$date)
case <- air %>% 
  mutate(pm10= replace(pm10, pm10 >= 150, NA))%>% 
  select(-c(Date,pre, hour, temp, ws, wd, co, so2, pm2.5)) %>% 
  reshape2::melt(id = c("date","district","year"),variable.name = "Type",value.name = "Value")

case$distype <- interaction(case$district, case$Type)

case %>% 
  filter(year != 2018) %>% 
  ggplot(aes(x = year, y=Value, group = year, fill = distype)) +
  geom_boxplot() +
  #facet_grid(rows = vars(Type), scales="free_y") +
  facet_wrap(. ~ distype, scale = "free", ncol=2) +
  theme_tq() +
  theme(legend.position="none",
    axis.text.x = element_text(size = 13),
    axis.text.y = element_text(size = 20),
    axis.title.y = element_text(size = 20),
    strip.text = element_text(size=20))





