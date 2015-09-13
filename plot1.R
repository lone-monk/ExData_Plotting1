#first open the png file
png("plot1.png", width = 480, height = 480)

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

#plot the graph
hist(desired$Global_active_power, col = "red", xlab = 
       "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()