#first open the png file
png("plot3.png", width = 480, height = 480)

#read the huge file household_power_consumption.txt
bigdata <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE)

#change the Date into desired format - from factor type to character format
bigdata <- transform(bigdata, Date = as.Date(strptime(bigdata$Date, 
                                                      "%d/%m/%Y")))
#get the desired data
desired <- bigdata[(bigdata[,1] == "2007-02-01" | bigdata[,1] == 
                      "2007-02-02"),]

#change the column into numeric form
desired <- transform(desired, Global_active_power = 
                       as.numeric(paste(Global_active_power)))
desired<-transform(desired, Sub_metering_1 = as.numeric(paste(Sub_metering_1)))
desired<-transform(desired, Sub_metering_2 = as.numeric(paste(Sub_metering_2)))
desired<-transform(desired, Sub_metering_3 = as.numeric(paste(Sub_metering_3)))

#combine date and time and change into POSIXct form
desired$fulldate <- as.POSIXct(paste(desired$Date, desired$Time))

#plot the graph
with(desired, plot(Sub_metering_1~fulldate, type = "l", xlab = "",
                   ylab = "Energy sub metering", ylim = c(0,40)))

par(new=TRUE)    #a new graph in the existing plot
with(desired, plot(Sub_metering_2~fulldate, type = "l", xlab = "", col = "red" 
                   ,ylab = "Energy sub metering", ylim = c(0,40)))

par(new=TRUE)    #a new graph in the existing plot
with(desired, plot(Sub_metering_3~fulldate, type = "l", xlab = "", col = "blue" 
                   ,ylab = "Energy sub metering", ylim = c(0,40)))
#add legend
legend("topright", lty = c(1,1), col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()