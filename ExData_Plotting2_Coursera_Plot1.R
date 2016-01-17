
# This code reads the household_power_consumption.txt data into R

filen <- "./household_power_consumption.txt"
filel <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filez <- 'exdata-data-household_power_consumption.zip'

# Verifies if data is already downloaded

if (!file.exists(filen)) {
  download.file(filel, destfile = filez)
  unzip(filez)
  file.remove(filez)
}

Plot2D <- read.table("./ExData_Plotting1/household_power_consumption.txt", 
                     sep=";", 
                     header = TRUE,
                     colClasses = rep("character",9))

# Converts all "?" into NA
Plot2D[Plot2D == "?"] <- NA

# Changes date into date class and excludes data outside of specified date range.
Plot2D[[1]] <- as.Date(Plot2D[[1]], format = "%d/%m/%Y")
Plot2D <- Plot2D[Plot2D$Date >= as.Date("2007-02-01") & Plot2D$Date <= as.Date("2007-02-02"),]

# Joins data and time to create a new field.
Plot2D$NewDate <- as.POSIXct(strptime(paste(Plot2D$Date, Plot2D$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))


# Changes Global_active_power to numeric class.
Plot2D$Global_active_power <- as.numeric(Plot1D$Global_active_power,)

# Constructs the png for the graph.

png(file="Plot2D.png", width = 480, height = 480, units = "px")
with(Plot2D, {
  plot(NewDate, Global_active_power, type='l', xlab='', ylab="Global Active Power (kilowatts)")
  })
# Shuts the file device.
dev.off()


