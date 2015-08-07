#Load libraries
library(sqldf)
library(dplyr)

#Pull in data needed
chicago <- readRDS("chicago.rds")

#Select specific columns
chicago_subset <- select(chicago,city:dptp)

#omit specific columns
chicago_omit <- select(chicago, -(city:dptp))

#select columns eneding with 2
chicago_ends_with_2<- select(chicago, ends_with("2"))

#select columns starting with d
chicago_starts_with_d <- select(chicago,starts_with("d"))

#Filter/Subset dataset for rows
chic.f <- filter(chicago,pm25tmean2> 30)
chic.f.temp <- filter(chicago,pm25tmean2> 30 & tmpd > 80)

#Order rows by variable
order_chic <- arrange(chicago,desc(date))

#rename variables similar to doing 
reaname_varss <- rename(chicago,dewpoint = dptp,pm25 = pm25tmean2)


#Using group_by and summarize 
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)

years <- group_by(chicago,year)

summarize(years,tmpd = mean(tmpd,na.rm = TRUE))

#use mutate to create new variables using existing variables
chicago_new_Var <- mutate(reaname_varss,pm25detrend = pm25 - mean(pm25, na.rm = TRUE))

#transmute keeps only the transformed variable

chicago_new_Var <- transmute(reaname_varss,pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
