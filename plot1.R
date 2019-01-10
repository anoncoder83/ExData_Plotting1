# Course 4 week1 assignment
#setwd("D:\\Knowledge Repo\\Data Science Hopkins University\\Course 4 Exploratory Data Analysis\\week 1 assignment\\ExData_Plotting1")
library(tidyr)
library(dplyr)
library(lubridate)

#load data and convert to decimal
dt <- read.delim("household_power_consumption.txt" , header = TRUE, sep = ";")
feb1 = as.Date("1-2-2007", format="%d-%m-%Y")
feb2 = as.Date("2-2-2007", format="%d-%m-%Y")
tib <- dt  %>% mutate(date1 = dmy(Date)) %>%  filter(date1 == feb1 | date1 == feb2) %>% 
        mutate(Datetime = as.POSIXct(strptime(paste(Date,Time,sep=" "), "%d/%m/%Y %H:%M:%S"))) 
tib3 <- tib %>% transform(Global_active_power = as.numeric(Global_active_power))  

#plot1

png(file = "plot1.png", width=480, height= 480, units = "px")
hist(tib3$Global_active_power, col="red", 
     xlab = "Global Active Power (kilowatts)", main ="Global Active Power" , breaks = 50)
dev.off()

