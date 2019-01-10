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


#plot3
png(file = "plot3.png" , width=480, height= 480, units = "px")
plot(tib3$Datetime, tib3$Sub_metering_1, main=" ",xlab="", ylab="Energy Sub metering", type="l", col="black" ,yaxp=c(0, 40, 4))
lines(tib3$Datetime,tib3$Sub_metering_2, col="red")
lines(tib3$Datetime,tib3$Sub_metering_3, col="blue")
legend("topright", pch="-", col= c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()


