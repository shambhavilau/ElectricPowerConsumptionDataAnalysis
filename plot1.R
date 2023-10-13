# read data from txt file
power_data <- read.table("household_power_consumption.txt",skip=1,sep = ";")

# rename columns witht he correct feature names
names(power_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# create subuset of data from date: 1/2/2007 to 2/2/2007
sub_power_data <- subset(power_data,power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")

# check if data has missing values
sapply(sub_power_data, function(x) sum(is.na(x)))

# convert columns to numeric
library(dplyr)
sub_power_data <- sub_power_data %>% mutate_at(c('Global_active_power','Global_reactive_power',
                                                 'Voltage','Global_intensity','Sub_metering_1',
                                                 'Sub_metering_2','Sub_metering_3'), as.numeric)

# create and save histogram for Global_active_power as png of size 480*480
png(file="plot1.png", width=480, height=480)
hist(sub_power_data$Global_active_power, col="red",main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()
