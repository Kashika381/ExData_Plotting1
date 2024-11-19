# Load data from file
data <- read.csv("C:/Users/HP/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", 
                 header=TRUE, sep=';', na.strings="?", nrows=2075259, check.names=FALSE, 
                 stringsAsFactors=FALSE, comment.char="", quote='\"')

# Convert Date column to Date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset data for specified date range
filtered_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(data)

# Create a datetime column
filtered_data$Datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time))

# Set up the 2x2 plotting layout
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Generate plots
with(filtered_data, {
  # Plot 1: Global Active Power vs. Time
  plot(Global_active_power ~ Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  mtext("Graph by AD", side=3, line=0.5, cex=0.8)
  
  # Plot 2: Voltage vs. Time
  plot(Voltage ~ Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  mtext("Graph by AD", side=3, line=0.5, cex=0.8)
  
  # Plot 3: Sub Metering vs. Time
  plot(Sub_metering_1 ~ Datetime, type="l", 
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2 ~ Datetime, col='Red')
  lines(Sub_metering_3 ~ Datetime, col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  mtext("Graph by AD", side=3, line=0.5, cex=0.8)
  
  # Plot 4: Global Reactive Power vs. Time
  plot(Global_reactive_power ~ Datetime, type="l", 
       ylab="Global Reactive Power (kilowatts)", xlab="")
  mtext("Graph by AD", side=3, line=0.5, cex=0.8)
})

# Save the plot to a file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()