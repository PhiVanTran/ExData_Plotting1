#Data file must be saved in the working directory

if( !file.exists("household_power_consumption.txt"))
{
        print("Data file household_power_consumption.txt does not exist")
        return
}

#Read data on 2007-02-01 and 2007-02-02 from text file household_power_consumption.txt 
library(data.table)
fileName <- "household_power_consumption.txt"
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread( fileName, skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))
setnames(DT, colnames(fread(fileName, nrows=0)))

png(filename="plot1.png")
hist(DT$Global_active_power,col=2,main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

rm(list=ls())
