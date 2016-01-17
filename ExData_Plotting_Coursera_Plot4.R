
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

Plot4D <- read.table("./ExData_Plotting1/household_power_consumption.txt", 
                     sep=";", 
                     header = TRUE,
                     colClasses = rep("character",9))

# Converts all "?" into NA
Plot4D[Plot4D == "?"] <- NA

# Changes date into date class and excludes data outside of specified date range.
Plot4D[[1]] <- as.Date(Plot4D[[1]], format = "%d/%m/%Y")
Plot4D <- Plot4D[Plot4D$Date >= as.Date("2007-02-01") & Plot4D$Date <= as.Date("2007-02-02"),]

# Joins data and time to create a new field.
Plot4D$NewDate <- as.POSIXct(strptime(paste(Plot4D$Date, Plot4D$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))


# Changes Global_active_power to numeric class.
Plot4D$Global_active_power <- as.numeric(Plot4D$Global_active_power)


# Opens png device

png(file = "Plot4.png", width = 480, height = 480, units = "px")

# 4 graph layout
par(mfrow = c(2, 2))

# First graph (GAP)
with(Plot4D,
     plot(NewDate,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))

# Second graph (Voltage)
with(Plot4D,
     plot(NewDate,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

## Third Graph (submeters1-3)
with(Plot4D,
     plot(NewDate,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(Plot4D,
     points(NewDate,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(Plot4D,
     points(NewDate,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

# Forth graph (GRP)
with(Plot4D,
     plot(NewDate,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))

# Closes dev
dev.off() 