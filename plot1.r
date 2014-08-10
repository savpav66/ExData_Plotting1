# By Savvas Pavlidis, 2014
# delete variables just in case, and file if it exists (to avoid overwrite problems)
rm( dat, dt )
if (file.exists("plot1.png")) {
	file.remove("plot1.png")
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

png("plot1.png", width=480, height=480)
hist(dt$Global_active_power,
	main="Global Active Power",
	xlab="Global Active Power 8(kilowatts)",
	ylab="Frequency",
	col="red")
dev.off()