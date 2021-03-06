#download and deal with the zipped file

zip.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- getwd()
zip.file <- "household_power_consumption.zip"
zip.combine <- as.character(paste(dir, zip.file, sep = "/"))
download.file(zip.url, destfile = zip.combine)
unzipped_file <- unzip(zip.file)

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

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = consumption[, dateTime]
     , y = consumption[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
