#READ AND PARSE DATA TO BE EXPLORED

pwrconsume <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(pwrconsume) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                  "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpwrconsume <- subset(pwrconsume,pwrconsume$Date=="1/2/2007" | pwrconsume$Date =="2/2/2007")

# TRANSFORMING DATE AND TIME VARIABLES INTO DATA TYPES DATE AND TIME
subpwrconsume$Date <- as.Date(subpwrconsume$Date, format="%d/%m/%Y")
subpwrconsume$Time <- strptime(subpwrconsume$Time, format="%H:%M:%S")
subpwrconsume[1:1440,"Time"] <- format(subpwrconsume[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpwrconsume[1441:2880,"Time"] <- format(subpwrconsume[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# PLOT 1

hist(as.numeric(as.character(subpwrconsume$Global_active_power)),col="red",
     main="Global Active Power",xlab="Global Active Power(kilowatts)")

## COPY MY PLOT TO A PNG FILE
dev.copy(png, file = "PLOT1.png")  
 
## TURN OFF THE DEVICE AFTER COPYING PLOT TO PNG FILE
dev.off()  

# PLOT 2

plot(subpwrconsume$Time,as.numeric(as.character(subpwrconsume$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 
title(main="Global Active Power Vs Time")

dev.copy(png, file = "PLOT2.png")  

## TURN OFF THE DEVICE AFTER COPYING PLOT TO PNG FILE
dev.off()  

# PLOT 3

plot(subpwrconsume$Time,subpwrconsume$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")

dev.copy(png, file = "PLOT3.png")  

## TURN OFF THE DEVICE AFTER COPYING PLOT TO PNG FILE
dev.off()  

# PLOT 4

# CREATE 2 X 2 PANEL FOR 4 GRAPHS
par(mfrow=c(2,2))

# CALLING THE BASIC PLOT FUNCTION WHICH CALL SEPERATE PLOT FUNCTIONS TO BUILD THE 4 PLOTS FOR EACH GRAPH
with(subpwrconsume,{
  plot(subpwrconsume$Time,as.numeric(as.character(subpwrconsume$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subpwrconsume$Time,as.numeric(as.character(subpwrconsume$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subpwrconsume$Time,subpwrconsume$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subpwrconsume,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subpwrconsume$Time,as.numeric(as.character(subpwrconsume$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.copy(png, file = "PLOT4.png")  

## TURN OFF THE DEVICE AFTER COPYING PLOT TO PNG FILE
dev.off()  

## RESET SCREEN TO A 1 X 1 GRAPHIC VIEW

par(mfrow=c(1,1))