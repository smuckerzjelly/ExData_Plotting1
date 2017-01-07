data <- read.table("household_power_consumption.txt", skip = 66638, nrows = 2879, 
			sep = ";" , header = TRUE, stringsAsFactors = FALSE, na.strings = "?",
			colClasses = c('character', 'character', 'numeric', 'numeric' ,
					'numeric', 'numeric', 'numeric', 'numeric', 'numeric')) 

colnames(data) <- c("Date" , "Time" , "Global_active_power" , "Global_reactive_power" ,
			"Voltage" , "Global_intensity" , "Sub_metering_1" , 
			"Sub_metering_2" , "Sub_metering_3")


data <- data[complete.cases(data),]

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

DateTime <- paste(data$Date, data$Time)

DateTime <- setNames(DateTime, "DateTime")

data <- cbind(DateTime, data) 

data$DateTime <- as.POSIXct(DateTime)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(data, {

plot(data$Global_active_power~data$DateTime, type = "l",  
	ylab = "Global Active Power (kilowatts)", xlab = "")

plot(data$Voltage~data$DateTime, type = "l", 
	ylab = "Voltage", xlab = "DateTime")

plot(data$Sub_metering_1~data$DateTime, type = "l", 
		ylab = "Energy sub metering", xlab = "")
	lines(data$Sub_metering_2~data$DateTime, type = "l", col = "red")
	lines(data$Sub_metering_3~data$DateTime, type = "l", col = "blue") 
	legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Global_reactive_power~data$DateTime, type = "l", 
	ylab = "Global_reactive_power", xlab = "DateTime")

}) 

dev.copy(png, file = "plot4.png")
dev.off() 
