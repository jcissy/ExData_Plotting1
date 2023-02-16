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
png(filename = "plot2.png",
    width = 480,
    height = 480)
plot(data$DateTime, data$Global_active_power, 
     type = "l", 
     lty = 1,
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

dev.off()