
library(dplyr)
library(lubridate)
## Download and unzip the dataset:
zipfilename <- "household_power_consumption.zip"
filename <- "household_power_consumption.txt"
if (!file.exists(zipfilename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, zipfilename, mode ="wb")
}  
if (!file.exists(filename)) { 
        unzip(zipfilename) 
}

## Loading the data
df <- read.table(filename, header = TRUE, sep = ";", 
                 quote = "", na.strings = "?")
df[,1] <- as.Date(df[,1], "%d/%m/%Y") ## convert date class
## filter for dates 2007-02-01 and 2017-02-02
df <- df %>% filter(Date %in% ymd(c("2007-02-01", "2007-02-02")))
df$Datetime <- ymd_hms(paste(df$Date, df$Time))

## Making plots
## use the base plotting system to examine how household energy usage varies over
## a 2-day period in February 2007

## Plot 3 - Sub_metering_1, Sub_metering_2, Sub_metering_3
png("plot3.png",width=480,height=480) ## copy plot to PNG File
with(df, {
        ## Energy sub metering / Datetime line plot
        plot(Datetime, Sub_metering_1, type = "l", xlab = NA, 
             ylab = "Energy sub metering", bg = "transparent") # sm1
        lines(Datetime, Sub_metering_2, col = "red") #add line for sm2
        lines(Datetime, Sub_metering_3, col = "blue") #add line for sm3
        })
legend("topright", legend = c(names(df[7:9])),
       lty = c(1,1,1),
       col=c("black","red","blue"))
dev.off() ## close the png device
