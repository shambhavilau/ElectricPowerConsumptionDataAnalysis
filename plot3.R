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

# Transform date and time variables in Date and Time objects
sub_power_data$Date <- as.Date(sub_power_data$Date, format="%d/%m/%Y")
sub_power_data$Time <- strptime(sub_power_data$Time, format="%H:%M:%S")

# Update date in the Time columns with correct values
sub_power_data[1:1440,"Time"] <- format(sub_power_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub_power_data[1441:2880,"Time"] <- format(sub_power_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# create and save line graph for Global_active_power and date as png of size 480*480
png(file="plot3.png", width=480, height=480)
plot(sub_power_data$Time,sub_power_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering",main="Energy sub-metering")
with(sub_power_data,lines(Time,Sub_metering_1))
with(sub_power_data,lines(Time,Sub_metering_2,col="red"))
with(sub_power_data,lines(Time,Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
