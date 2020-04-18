## R script for plot2

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


# create plot2 and save it in plot.png
png(file="plot2.png", width = 480, height = 480)
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()