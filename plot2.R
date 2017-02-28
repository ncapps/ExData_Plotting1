
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

## Plot 2 - Global Active Power
png("plot2.png",width=480,height=480) ## copy plot to PNG File
plot(df$Datetime, df$Global_active_power,
     type = "l",
     xlab = NA,
     ylab = "Global Active Power (kilowatts)",
     bg = "transparent")
dev.off() ## close the png device
