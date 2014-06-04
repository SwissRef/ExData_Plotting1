
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

## Plot 4 and export to png format
png(filename = paste(path,"plot4.png",sep="/"), width = 480, height = 480, units = "px")

  par(mfrow=c(2,2))
  with(data, {
    plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")
    plot(DateTime, Sub_metering_1,type="n", ylab="Energy sub metering", xlab="")
      lines(DateTime, Sub_metering_1,type="l", col ="Black")
      lines(DateTime, Sub_metering_2,type="l", col ="Red")
      lines(DateTime, Sub_metering_3,type="l", col ="Blue")
      legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), 
             col = c("Black", "Red", "Blue"), bty = "n")
    plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
  })

dev.off()
  
  