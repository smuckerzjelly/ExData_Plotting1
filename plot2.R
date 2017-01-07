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

plot(data$Global_active_power~data$DateTime, type = "l",  
	ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png")
dev.off()