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

#to create the plot 1

hist(epc$Global_active_power,col="red", main="Global Active Power",
     xlab="Global Active Power (killowatts)")

#to create a png file of plot 1

dev.copy(png, width = 480, height = 480, file="plot1.png")
dev.off()

options(warn=0)


