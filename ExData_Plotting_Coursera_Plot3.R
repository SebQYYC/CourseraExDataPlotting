
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

Plot3D <- read.table("./ExData_Plotting1/household_power_consumption.txt", 
                     sep=";", 
                     header = TRUE,
                     colClasses = rep("character",9))

# Converts all "?" into NA
Plot3D[Plot3D == "?"] <- NA

# Changes date into date class and excludes data outside of specified date range.
Plot3D[[1]] <- as.Date(Plot3D[[1]], format = "%d/%m/%Y")
Plot3D <- Plot3D[Plot3D$Date >= as.Date("2007-02-01") & Plot3D$Date <= as.Date("2007-02-02"),]

# Joins data and time to create a new field.
Plot3D$NewDate <- as.POSIXct(strptime(paste(Plot3D$Date, Plot3D$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))


# Changes Global_active_power to numeric class.
Plot3D$Global_active_power <- as.numeric(Plot3D$Global_active_power)

# Constructs the png for the graph.

png(file="Plot3.png", width = 480, height = 480, units = "px")

with(Plot3D, {
  plot(NewDate, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
  lines(NewDate, Sub_metering_2, type='l', col='red')
  lines(NewDate, Sub_metering_3, type='l', col='blue')
})

# Shuts the file device.
dev.off()


