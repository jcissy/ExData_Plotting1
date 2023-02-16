library(lubridate)
library(dplyr)

## GET THE DATASET FROM THE .TXT FILE
data <- read.csv("household_power_consumption.txt", sep=";")

## CONVERT THE DATA TYPES
data$Date <- dmy(data$Date)
data$DateTime <- as.POSIXct(paste(dmy(data$Date), data$Time), 
                            format = "%Y-%m-%d %H:%M:%S")
data[,3:8] <- mutate_all(data[,3:8], as.numeric)

head(data)
summary(data)
names(data)

## SELECT ONLY THE DATES REQUIRED FOR PLOT
## FEB 1 AND 2 OF 2007
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
table(data$Date)

## CREATE THE CHART AND THE PNG FILE
png(filename = "plot4.png",
    width = 480,
    height = 480)

par(mfrow = c(2,2))
plot(data$DateTime, data$Global_active_power, 
     type = "l", 
     lty = 1,
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
plot(data$DateTime, data$Voltage,
     type = "l",
     lty = 1,
     ylab = "Voltage",
     xlab = "datetime")
plot(data$DateTime, data$Sub_metering_1,
     type = "l",
     lty = 1,
     ylab = "Energy sub metering",
     xlab = "")
points(data$DateTime, data$Sub_metering_2,
       type = "l",
       lty = 1,
       col = "red")
points(data$DateTime, data$Sub_metering_3,
       type = "l",
       lty = 1,
       col = "blue")
legend("topright", lty = 1, col=c("blue","red"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(data$DateTime, data$Global_reactive_power,
     type = "l",
     lty = 1,
     ylab = "Global_reactive_power",
     xlab = "datetime")

dev.off()