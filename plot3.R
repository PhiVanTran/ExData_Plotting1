

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

png(filename="plot3.png")
plot(dd, DT$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
lines(dd, DT$Sub_metering_2,type="l",col="red")
lines(dd, DT$Sub_metering_3,type="l", col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),  text.col = "black",
       lty=c(1,1,1), text.font=8, cex=0.95,
       text.width = strwidth("Sub_metering_1"))


dev.off()

rm(list=ls())