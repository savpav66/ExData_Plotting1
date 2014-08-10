# By Savvas Pavlidis, 2014
# delete variables just in case
rm( dat, dt )
if (file.exists("plot4.png")) {
	file.remove("plot4.png")
}
# First read all data to dataframe, make NA when ? is encountered
dat<-read.table( "household_power_consumption.txt",
				 sep=";",
				 header=TRUE, 
				 colClasses=c( rep("character",2), 
							   rep("numeric",7 )  ),
				 na="?" )
# Subset as soon as possible, to free RAM
dt<-subset(dat,Date=="1/2/2007" | Date=="2/2/2007")
rm(dat)
# Modify columns of Date/Time as specified in exercise
# fisrt we make Time, so as to leave Data unchanged and doit afterwards
dt$Time <- strptime( paste( dt$Date,dt$Time) , format="%d/%m/%Y %H:%M:%S" ) 
dt$Date <- as.Date( dt$Date, format="%d/%m/%Y" )

# Open a png device to put plot there, 480 X 480
png("plot4.png", width=480, height=480)
# Create a matrix of 2 by 2 in image
par( mfrow=c(2,2) )

# Now do all the plottings one by one. the data are already gathered.
# plot 1 , xaxt is used not to display x axis ticks (the were displayed in Greek
# in my system). Thus axis function is used below. This is done in every plot!
plot( dt$Time, 
	  dt$Global_active_power,
	  type="l",
	  xlab="",
	  ylab="Global Active Power",xaxt="n" )
# axis function to display the ticks in English as in exercise.
# this is done in every plot below!
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )	  
# plot 2
plot( dt$Time, 
	  dt$Voltage, 
	  type="l",
	  xlab="datetime", 
	  ylab="Voltage",xaxt="n" )
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )	  	  
# plot 3		
plot( dt$Time, 
	  dt$Sub_metering_1, 
	  type="l", 
	  col="black",
	  xlab="", 
	  ylab="Energy sub metering", xaxt="n" )
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )	  
lines( dt$Time, dt$Sub_metering_2, col="red" )
lines( dt$Time, dt$Sub_metering_3, col="blue" )
legend( "topright",
		col=c("black", "red", "blue"),
		c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
		lty=1,
		box.lwd=0 )
# plot 4
plot( dt$Time, 
	  dt$Global_reactive_power, 
	  type="n",
	  xlab="datetime", 
	  ylab="Global_reactive_power",xaxt="n" )
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )	  
lines( dt$Time, dt$Global_reactive_power )

dev.off()