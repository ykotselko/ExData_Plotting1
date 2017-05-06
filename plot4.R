library(sqldf)

# check plot4.R exists in the working directory
if (!file.exists("plot4.R")) {
    stop("plot4.R not found.")
}
# check household_power_consumption.txt exists in the working directory
if (!file.exists("household_power_consumption.txt")) {
    stop("household_power_consumption.txt not found.")
}

#read two days from household_power_consumption.txt

consumption <- read.csv.sql("household_power_consumption.txt",header = TRUE,sep = ";", sql="select * from file where Date in ('1/2/2007','2/2/2007')")


#convert Date and Time field into POSIXt format. in this case we create additional field called DateTime
consumption <- transform(consumption, DateTime = strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#create plot4.png (480x480px) in the working directory
png("plot4.png", width = 480, height = 480, units = "px", bg = "transparent", antialias = "cleartype")

#divide screen by 4 parts
par(mfrow=c(2,2))

with(consumption,{
    
    plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power", xlab = " ", main = "" )
    
    plot(DateTime,Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

    plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = " ", main = "" )
    points(DateTime,Sub_metering_2,type = "l", col="red")
    points(DateTime,Sub_metering_3,type = "l", col="blue")
    legend("topright", lwd = 2, col=c("black","red","blue"), bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

    plot(DateTime,Global_reactive_power, type = "l", xlab = "datetime")
})

#switch png device off
dev.off()
closeAllConnections()
