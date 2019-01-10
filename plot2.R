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

#plot2
png(file = "plot2.png", width=480, height= 480, units = "px")
plot(tib3$Datetime, tib3$Global_active_power, type ="l", 
     ylab = "Global Active Power (kilowatts)", xlab="")
dev.off()