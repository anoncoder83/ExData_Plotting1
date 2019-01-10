library(tidyr)
library(dplyr)
library(lubridate)

#load data and convert to decimal
dt <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")
feb1 = as.Date("1-2-2007", format="%d-%m-%Y")
feb2 = as.Date("2-2-2007", format="%d-%m-%Y")
tib <- dt  %>% mutate(date1 = dmy(Date)) %>%  filter(date1 == feb1 | date1 == feb2) %>% 
  mutate(Datetime = as.POSIXct(strptime(paste(Date,Time,sep=" "), "%d/%m/%Y %H:%M:%S"))) 
tib3 <- tib %>% transform(Global_active_power = as.numeric(Global_active_power))  

#plot 4
png(file ="plot4.png" , width=480, height= 480, units = "px")
par(mfrow=c(2,2), mar= c(4,4,2,2), oma=c(0,0,0,0))

plot( tib3$Datetime,tib3$Global_active_power, xlab="",type="l" , ylab = "Global Active Power")
plot( tib3$Datetime,tib3$Voltage, type="l" , ylab = "Voltage", xlab="datetime")

plot(tib3$Datetime, tib3$Sub_metering_1, main=" ",xlab="", ylab="Energy Sub metering", type="l", col="black" ,yaxp=c(0, 40, 4))
lines(tib3$Datetime,tib3$Sub_metering_2, col="red")
lines(tib3$Datetime,tib3$Sub_metering_3, col="blue")
legend("topright", col= c("black","red","blue"), box.lty="blank",inset = .01,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1)
plot( tib3$Datetime,tib3$Global_reactive_power, xlab="datetime",type="l" , ylab = "Global Reactive Power")
dev.off()


