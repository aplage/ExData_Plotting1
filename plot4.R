# To import and subset data for graphic cosntruction
library(data.table)

options(warn=-1)

fread( "household_power_consumption.txt",
       na.strings=c("NA","N/A","","?","\\?"),
       #colClasses(c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")),
       stringsAsFactors=FALSE) ->temp

subset(temp,c(Date=="1/2/2007" | Date=="2/2/2007"))->epc

library(lubridate)

epc[, DateTime:=paste(Date,Time)]
epc[, DateTime:=dmy_hms(DateTime)]

epc[,Voltage:=as.numeric(Voltage)]
epc[,Global_active_power:= as.numeric(Global_active_power)]
epc[,Global_reactive_power:= as.numeric(Global_reactive_power)]
epc[,Global_intensity:= as.numeric(Global_intensity)]
epc[,Sub_metering_1:= as.numeric(Sub_metering_1)]
epc[,Sub_metering_2:= as.numeric(Sub_metering_2)]


#to create plot 4

#to print weekdays in English on non-English locale
Sys.setlocale("LC_TIME", "English")

par(mfrow=c(2,2))

# plot 4 A

plot(epc$DateTime,epc$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

#plot4 B

plot(epc$DateTime,epc$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

#plot 4 C

plot(epc$DateTime,epc$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(epc$DateTime,epc$Sub_metering_2, col="red")
lines(epc$DateTime,epc$Sub_metering_3, col="blue")
legend("topright",col=c("black", "red", "blue"),
       lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=1.0, bty="n")

#plot 4 D

plot(epc$DateTime,epc$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

par(mfrow=c(1,1))



#to create a png file of plot 4

#to print weekdays in English on non-English locale
Sys.setlocale("LC_TIME", "English")

png(width = 480, height = 480, file="plot4.png")

par(mfrow=c(2,2))

# plot 4 A

plot(epc$DateTime,epc$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

#plot4 B

plot(epc$DateTime,epc$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

#plot 4 C

plot(epc$DateTime,epc$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(epc$DateTime,epc$Sub_metering_2, col="red")
lines(epc$DateTime,epc$Sub_metering_3, col="blue")
legend("topright",col=c("black", "red", "blue"),
       lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=1.0, bty="n")

#plot 4 D

plot(epc$DateTime,epc$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

#to create a png file of plot 2

dev.off()

par(mfrow=c(1,1))

options(warn=0)

