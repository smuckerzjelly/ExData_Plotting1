data <- read.table("household_power_consumption.txt", skip = 66638, nrows = 2879, 
			sep = ";" , header = TRUE) 

colnames(data) <- c("Date" , "Time" , "Global_active_power" , "Global_reactive_power" ,
			"Voltage" , "Global_intensity" , "Sub_metering_1" , 
			"Sub_metering_2" , "Sub_metering_3")

data$Date <- as.Date(parse_date_time(data$Date,"mdY"))

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
	ylab = "Frequency", main = "Global Active Power", col = "red") 

dev.copy(png, file = "plot1.png")

dev.off()