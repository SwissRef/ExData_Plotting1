

## Get Data
path <- getwd()
file <- "household_power_consumption.txt"
filepath <- paste(path, file, sep="/")

data <- subset(data.table(read.table(filepath,header=TRUE,sep=";",na.strings="?")), 
               xor(Date=="1/2/2007",Date== "2/2/2007"))

## create Date & Time field
DateTime <- paste(data$Date, data$Time, sep=" ")
DateTime <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

data <- as.data.frame(data)
data <- cbind(data, DateTime)
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Plot 1 and export to png format
png(filename = paste(path,"plot1.png",sep="/"), width = 480, height = 480, units = "px")

  par(mfrow=c(1,1))
  hist(data$Global_active_power, col="Red", main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()

