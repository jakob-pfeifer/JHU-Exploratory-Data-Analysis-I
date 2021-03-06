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

# Prevents histogram from printing in scientific notation
consumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
consumption <- consumption[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1 - a histogram
hist(consumption[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## after viewing the plot, don't forget to dev.off
dev.off()
