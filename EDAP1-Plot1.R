##EDA Project1 - Plot 1  due 9/7/14           # Run time is <2 minutes

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
summary(DFS) 

##make plots

with(DFS, hist(Global_active_power, main="Global Active Power", cex.main=0.9,
               mar=c(3,3,1,1), xlab="Global Active Power (kilowatts)", 
               col="red", breaks=10, cex.lab=0.8, xaxt='n',yaxt='n', xpd=TRUE))
axis(2, at=200*0:1200, font=10, cex.axis=0.8)
axis(1, at=2*0:6, font=10, cex.axis=0.8)


##save to png
dev.copy(png, file="plot1.png", width=480, height=480) #copy plot to a PNG file
dev.off()  #close the pdf file device - go to file on computer to view

##END