power_data <- read.delim("household_power_consumption.txt", header=TRUE,sep=";", dec=".")
power_data$Date <- as.Date(power_data$Date, format = "%e/%m/%Y")
two_day_data <- subset(power_data, Date == "2007-02-01" | Date == "2007-02-02")
two_day_data$Global_active_power <- as.numeric(as.character(two_day_data$Global_active_power))

png("plot1.png",width=480, height=480)
with(two_day_data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()