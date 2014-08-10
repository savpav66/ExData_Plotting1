# By Savvas Pavlidis, 2014
# delete variables just in case
rm( dat, dt )
if (file.exists("plot2.png")) {
	file.remove("plot2.png")
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

# Open a png device to put plot there, 400 X 400
png("plot2.png", width=400, height=400)

plot( dt$Time, 
	  dt$Global_active_power,
	  type="l",
	  xlab="",
	  ylab="Global Active Power (kilowatts)"
	  ,xaxt="n"
	  )
# Custom axis ticks, because it was using names of days in my language (Greek)
# and not in English. So change ticks to look like exercise description exactly!
# Ticks should be at the exact beginning of each day, actual SATURDAY at 00:00:00 is the end of data.
axis(1, at=c( as.double( strptime("01/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("02/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ),
			  as.double( strptime("03/02/2007 00:00:00","%d/%m/%Y %H:%M:%S") ) ),
		labels=c("Thu","Fri","Sat") )
dev.off()