# Assignment: Plot 4
# Goal: to examine how household energy usage varies over a 2-day period in February, 2007
library(sqldf)
f <- file("household_power_consumption.txt")
DF <- sqldf("select * from f where Date == '1/2/2007' or Date == '2/2/2007'", # select data only for two day period
            dbname = tempfile(), 
            file.format = list(header = T, row.names = F, sep=";"))
df<-DF[,c("Date","Time","Global_active_power",                  ## for Plot 1
          "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", ## for Plot 2
          "Global_reactive_power",                              ## for Plot 3
          "Voltage")]                                           ## for plot 4
df$DateTime<-strptime(paste(df$Date, df$Time),format="%d/%m/%Y %H:%M:%S")
## plot first plot
png(file="plot4.png",width=480,height=480, bg = "transparent")
par(mfcol = c(2,2))
plot(df$DateTime, as.numeric( as.character(df$Global_active_power )), 
     ylab = "Global Active Power",
     xlab = "", 
     type = "l")
## plot second plot
plot(df$DateTime, as.numeric( as.character(df$Sub_metering_2 )), ## specify x and y , y can be any of the three values
     ylim=c(min(as.numeric( as.character(df$Sub_metering_1 )),   ## specify ylim
                as.numeric( as.character(df$Sub_metering_2 )),
                as.numeric( as.character(df$Sub_metering_3 ))),
            max(as.numeric( as.character(df$Sub_metering_1 )), 
                as.numeric( as.character(df$Sub_metering_2 )),
                as.numeric( as.character(df$Sub_metering_3 )))),
     ylab = "Energy sub metering",
     xlab = "", 
     type = "n")

lines(df$DateTime, as.numeric( as.character(df$Sub_metering_1 )), col = "black")
lines(df$DateTime, as.numeric( as.character(df$Sub_metering_2 )), col = "red")
lines(df$DateTime, as.numeric( as.character(df$Sub_metering_3 )), col = "blue")
legend(x = "topright",                                         ## Place legend at top right corner
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), ## put the text in the legend      
       lty=c(1,1,1),                                           ## give the legend appropriate symbols (lines)       
       lwd=c(1,1,1),                                           ## gives the legend lines the correct width
       col=c("black","red", "blue"),                           ## gives the legend lines the correct color
       bty="n")                                                ## remove the legend box line
plot(df$DateTime, as.numeric( as.character(df$Voltage )), ylab = "Voltage",
     xlab = "datetime", type = "l")
plot(df$DateTime, as.numeric( as.character(df$Global_reactive_power )),
     ylab = "Global_reactive_power", 
     xlab = "datetime", 
     type = "l")
dev.off()                                                      ## close the graphic device