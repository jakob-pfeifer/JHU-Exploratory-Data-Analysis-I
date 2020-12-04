library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

#Reads in data from file then subsets data for specified dates
consumption <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
consumption[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
consumption <- consumption[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(consumption[, dateTime], consumption[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(consumption[, dateTime], consumption[, Sub_metering_2],col="red")
lines(consumption[, dateTime], consumption[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
