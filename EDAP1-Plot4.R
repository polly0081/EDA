##EDA Project1 - Plot 4  due 9/7/14           

##load dataset from file saved locally
setwd("H:/Coursera/EDA")  #change the path to match local download location
library(data.table)
library(datasets)

## Read outcome data  #change the path to match local download
DF <- read.table("H:/Coursera/EDA/household_power_consumption.txt", header=TRUE, sep = ";", 
                 nrows=2075259, na.string="?", comment.char="")
#summary(DF)

##changing class of columns to character (helps conversion later)
DFa <- DF 
for(col in c("Global_active_power","Global_reactive_power","Voltage","Global_intensity",
             "Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
{DF[[col]] <- as.character(DF[[col]])}
#summary(DFa)

##changing class of columns to date / time 
DFa$Date <- as.Date(DFa$Date, '%d/%m/%Y')
DFa$Time <- strptime(DFa$Time, "%H:%M:%S")
#summary(DFa)

##create variable of dates to review for subset 
select<- c("2007-02-01","2007-02-02")

##read specific rows from text for plotting
sb <- subset(DFa, DFa$Date == select)
#summary(sb)

##changing class of columns to numeric
DFS <- sb 
for(col in c("Global_active_power","Global_reactive_power","Voltage","Global_intensity",
             "Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
{sb[[col]] <- as.numeric(sb[[col]])}
#summary(DFS) 

##adding column for weekdays to plot X axis
DFS$Days <- weekdays(as.Date(sb$Date, '%d/%m/%Y'))
summary(DFS) 

##create additional variables for plotting
z1 <- tx$Sub_metering_1
z2 <- tx$Sub_metering_2
z3 <- tx$Sub_metering_3

##make plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(1,1,2,1)) #mfrow = 2 rows & 2 columns to display plots
#call plot 4x - once mfrow/mfcol is set above
with(DFS, {
    plot(DFS$Time, DFS$Global_active_power, type="l", 
                xlab="", ylab="Global Active Power (kilowatts)", 
                cex.lab=0.6, cex.axis=0.6, xpd=TRUE )
            
    plot(DFS$Time, DFS$Voltage, type="l", xlab="datetime", ylab="Voltage", cex.lab=0.6, cex.axis=0.6, xpd=TRUE )
    
    plot(DFS$Time, z1, mar=c(5,5,3,3), type="l", xlab="", ylab="Energy sub metering", cex.lab=0.6, cex.axis=0.6)
        lines(DFS$Time,z2,type="l", col="red")
        lines(DFS$Time,z3,type="l", col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
               col=c("black","red","blue"), pch="-", cex=0.75, pt.cex=1.5)  
    
    plot(DFS$Time, DFS$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", 
         cex.lab=0.6, cex.axis=0.6, xpd=TRUE ) 

    #mtext("Quadrant", outer=TRUE) #setting the title in outer margin
})

##save to png
dev.copy(png, file="plot4.png", width=480, height=480) #copy plot to a PNG file
dev.off()  #close the pdf file device - go to file on computer to view

##END

