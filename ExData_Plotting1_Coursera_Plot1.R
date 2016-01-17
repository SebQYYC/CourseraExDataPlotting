
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

Plot1D <- read.table("./ExData_Plotting1/household_power_consumption.txt", 
                     sep=";", 
                     header = TRUE,
                     colClasses = rep("character",9))

# Converts all "?" into NA
Plot1D[Plot1D == "?"] <- NA

# Changes date into date class and excludes data outside of specified date range.
Plot1D[[1]] <- as.Date(Plot1D[[1]], format = "%d/%m/%Y")
Plot1D <- Plot1D[Plot1D$Date >= as.Date("2007-02-01") & Plot1D$Date <= as.Date("2007-02-02"),]


# Changes Global_active_power to numeric class.
Plot1D$Global_active_power <- as.numeric(Plot1D$Global_active_power)

# Constructs the png for the graph.

png(file="Plot1D.png", width = 480, height = 480, units = "px")
hist(Plot1D$Global_active_power, 
     main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col="red")

# Shuts the file device.
dev.off()


