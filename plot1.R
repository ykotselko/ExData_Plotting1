library(sqldf)

# check plot1.R exists in the working directory
if (!file.exists("plot1.R")) {
    stop("plot1.R not found.")
}
# check household_power_consumption.txt exists in the working directory
if (!file.exists("household_power_consumption.txt")) {
    stop("household_power_consumption.txt not found.")
}

#read two days from household_power_consumption.txt

consumption <- read.csv.sql("household_power_consumption.txt",header = TRUE,sep = ";", sql="select * from file where Date in ('1/2/2007','2/2/2007')")

#convert Date and Time field into POSIXt format. in this case we create additional field called DateTime
consumption <- transform(consumption, DateTime = strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))

#create plot1.png (480x480px) in the working directory
png("plot1.png", width = 480, height = 480, units = "px", bg = "transparent", antialias = "cleartype")

#plot chart
hist(consumption$Global_active_power, main="Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

#switch png device off
dev.off()
closeAllConnections()
