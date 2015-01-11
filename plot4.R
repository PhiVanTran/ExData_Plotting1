#Data file must be saved in the working directory
if( !file.exists("household_power_consumption.txt"))
{
        print("File household_power_consumption.txt does not exist")
        return
}

#Read data on 2007-02-01 and 2007-02-02 from text file household_power_consumption.txt 
library(data.table)
fileName <- "household_power_consumption.txt"
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread( fileName, skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(DT, colnames(fread(fileName, nrows=0)))
dd <- strptime(paste(DT$Date,DT$Time), "%d/%m/%Y %H:%M:%S")

#Create plots
png(filename="plot4.png")

par(mfrow = c(2,2), mar = c(4, 4, 4, 2), oma = c(1, 1, 1, 1))

plot(dd, DT$Global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(dd, DT$Voltage,type="l",ylab="Voltage",xlab="datetime")

plot(dd, DT$Sub_metering_1,type="l", ylab="Energy sub metering",xlab="")
lines(dd, DT$Sub_metering_2,type="l",col="red")
lines(dd, DT$Sub_metering_3,type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), text.col = "black",lty=c(1,1,1), bty="n")

plot(dd, DT$Global_reactive_power,type="l", xlab="datetime", ylab="Global_rective_power")

dev.off()

rm(list=ls())