library(sqldf)

# check plot2.R exists in the working directory
if (!file.exists("plot2.R")) {
    stop("plot2.R not found.")
}
# check household_power_consumption.txt exists in the working directory
if (!file.exists("household_power_consumption.txt")) {
    stop("household_power_consumption.txt not found.")
}

#read two days from household_power_consumption.txt
consumption <- read.csv.sql("household_power_consumption.txt",header = TRUE,sep = ";", sql="select * from file where Date in ('1/2/2007','2/2/2007')")


#convert Date and Time field into POSIXt format. in this case we create additional field called DateTime
consumption <- transform(consumption, DateTime = strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#create plot2.png (480x480px) in the working directory
png("plot2.png", width = 480, height = 480, units = "px", bg = "transparent", antialias = "cleartype")

#plot chart
with(consumption,plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = " ", main = "" ))

#switch png device off
dev.off()
closeAllConnections()
