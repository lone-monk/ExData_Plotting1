#first open the png file
png("plot4.png", width = 480, height = 480)

#read the huge file household_power_consumption.txt
bigdata <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE)

#change the Date into desired format - from factor type to character format
bigdata <- transform(bigdata, Date = as.Date(strptime(bigdata$Date, 
                                                      "%d/%m/%Y")))

#get the desired data
desired <- bigdata[(bigdata[,1] == "2007-02-01" | bigdata[,1] == "2007-02-02"),]

#change the columns into numeric form
desired <- transform(desired, Global_active_power = 
                       as.numeric(paste(Global_active_power)))
desired <- transform(desired, Sub_metering_1 = 
                       as.numeric(paste(Sub_metering_1)))
desired <- transform(desired, Sub_metering_2 = 
                       as.numeric(paste(Sub_metering_2)))
desired <- transform(desired, Sub_metering_3 = 
                       as.numeric(paste(Sub_metering_3)))
desired <- transform(desired, Voltage = as.numeric(paste(Voltage)))
desired <- transform(desired, Global_reactive_power = 
                      as.numeric(paste(Global_reactive_power)))

#combine date and time and change into POSIXct form
desired$fulldate <- as.POSIXct(paste(desired$Date, desired$Time))

#plot the graph
#specify that there are four graphs in 2X2 fomat and set the margin
par(mfcol = c(2,2), mar = c(4,4,2,1))

##plot 1
plot(desired$Global_active_power~desired$fulldate, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

##plot 2

with(desired, plot(Sub_metering_1~fulldate, type = "l", xlab = "",
                   ylab = "Energy sub metering", ylim = c(0,40)))
par(new=TRUE)
with(desired, plot(Sub_metering_2~fulldate, type = "l", xlab = "", col = "red" 
                   ,ylab = "Energy sub metering", ylim = c(0,40)))
par(new=TRUE)
with(desired, plot(Sub_metering_3~fulldate, type = "l", xlab = "", col = "blue" 
                   ,ylab = "Energy sub metering", ylim = c(0,40)))

legend("topright", lty = c(1,1), col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.75)    #altering size of the legend 

##plot 3
with(desired, plot(Voltage~fulldate, type = "l", xlab = "datetime",
                   ylab = "Voltage"))

##plot 4
with(desired, plot(Global_reactive_power~fulldate, type = "l", 
                   xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()