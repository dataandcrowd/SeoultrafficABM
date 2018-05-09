setwd("D:/Dropbox (Cambridge University)/2018_Cambridge/[Database]/Population/DeFacto")
options(scipen = 10000, width = 10)
library(readr)
people <- read_csv("LOCAL_PEOPLE_20180504.csv")
colnames(people) <- c('date','hour','admincd','blockcd','totalpop',
                      'm0-9','m10-14','m15-19','m20-24','m25-29','m30-34','m35-39',
                      'm40-44','m45-49','m50-54','m55-59','m60-64','m65-69','m70',
                      'w0-9','w10-14','w15-19','w20-24','w25-29','w30-34','w35-39',
                      'w40-44','w45-49','w50-54','w55-59','w60-64','w65-69','w70'
                      )

for(i in 1:length(people)){
  people[[i]] <- as.numeric(people[[i]])
  
}

people <- people[order(people$hour, people$blockcd),]

