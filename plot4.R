#load data located in working directory
power_data <- read.delim("household_power_consumption.txt", header=TRUE,sep=";", dec=".")
#change the Date column to a Date class object
power_data$Date <- as.Date(power_data$Date, format = "%e/%m/%Y")
#Subset the data for only the two days we are interested in
two_day_data <- subset(power_data, Date == "2007-02-01" | Date == "2007-02-02")
#Change all power readings from factor columns to numeric
two_day_data <- c(two_day_data[,1:2],lapply(two_day_data[ ,3:9], function(x) as.numeric(as.character(x))))
#create a DateTime column be combining the date and time columns
two_day_data$DateTime <- as.POSIXct(paste(two_day_data$Date, two_day_data$Time), format="%Y-%m-%d %H:%M:%S")

#create a new PNG graphics device
png("plot4.png",width=480, height=480)
#set the graphics device to display four plots in a 2x2 layout
par(mfrow = c(2,2))
#create plot in upper left corner
plot(two_day_data$DateTime, two_day_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#create plot in upper right corner
plot(two_day_data$DateTime, two_day_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#create plot in lower left corner by adding the three sub meters individually
with(two_day_data, plot(DateTime, Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering"))
with(two_day_data, lines(DateTime, Sub_metering_2, type = "l", xlab="", col="red"))
with(two_day_data, lines(DateTime, Sub_metering_3, type = "l", xlab="", col="blue"))
#create the plot legend
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty = 1, bty = "n")
#create the plot in lower right corner
plot(two_day_data$DateTime, two_day_data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type="l")
#Close the graphics device connection
dev.off()
