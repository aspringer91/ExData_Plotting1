#load data located in working directory
power_data <- read.delim("household_power_consumption.txt", header=TRUE,sep=";", dec=".")
#change the Date column to a Date class object
power_data$Date <- as.Date(power_data$Date, format = "%e/%m/%Y")
#Subset the data for only the two days we are interested in
two_day_data <- subset(power_data, Date == "2007-02-01" | Date == "2007-02-02")
#change the Global ACtive Power column from a factor to numeric
two_day_data$Global_active_power <- as.numeric(as.character(two_day_data$Global_active_power))

#create a new PNG graphics device
png("plot1.png",width=480, height=480)
#create the plot
with(two_day_data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
#Close the graphics device connection
dev.off()