data <- read.csv("C:/Users/HP/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=';', 
                 na.strings="?", nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, 
                 comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

filtered_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rm(data)

filtered_data$Datetime <- as.POSIXct(paste(filtered_data$Date, filtered_data$Time))

hist(filtered_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
mtext("Graph by AD", side=3, line=0.5, cex=0.8)

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()