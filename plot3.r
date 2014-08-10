# By Savvas Pavlidis, 2014
# delete variables just in case
rm( dat, dt )
if (file.exists("plot3.png")) {
	file.remove("plot3.png")
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
png("plot3.png", width=480, height=480)

# the plot, without x axis ticks - see afterwards why!
plot( dt$Time, 
	  dt$Sub_mete_1, 
	  type="l", 
	  col="black",
	  xlab="", 
	  ylab="Energy sub metering",
	  xaxt="n" )
# Now include the other lines	  
lines(dt$Time, dt$Sub_metering_2, col="red")
lines(dt$Time, dt$Sub_metering_3, col="blue")
# Make the legends
legend( "topright",
		col=c("black", "red", "blue"),
		c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
		lty=1 )
# Custom axis ticks, because it was using names of days in my language (Greek)
# and not in English. So change ticks to look like exercise description exactly!
# Ticks should be at the exact beginning of each day, actual SATURDAY at 00:00:00 is the end of data.
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )
dev.off()