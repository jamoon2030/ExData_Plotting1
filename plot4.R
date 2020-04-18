## R script for plot4

# if a target dataset does not exists, read the dataset, extract data from dates 2007-02-01 and 2007-0-02, and convert variables
if (!exists("data")) {
        # read data from working directory
        d <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
        
        # extract data from the dates 2007-02-01 and 2007-0-02 
        data <- d[d$Date=="1/2/2007" | d$Date =="2/2/2007",]
        
        # convert variables into appropriate classes
        data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
        # Convert Sub_metering_1 and Sub_metering_2 to numeric variables
        data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
        data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
        data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
        data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
        data$Voltage <- as.numeric(as.character(data$Voltage))
        data$Global_intensity <- as.numeric(as.character(data$Global_intensity))        
}


# create plot4 and save it in plot.png
png(file="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

# top-left plot
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# bottom-left plot
plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# top-right plot
plot(data$datetime, data$Sub_metering_1, type="l", col="black", lty=1, ylab = "Energy sub metering", xlab = "")
lines(data$datetime, data$Sub_metering_2, type="l", col="red", lty=1)
lines(data$datetime, data$Sub_metering_3, type="l", col="blue", lty=1)
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1))

# bottom-right plot
plot(data$datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()