# Assignment: Plot 1
# Goal: to examine how household energy usage varies over a 2-day period in February, 2007
library(sqldf)
f <- file("household_power_consumption.txt")
DF <- sqldf("select * from f where Date == '1/2/2007' or Date == '2/2/2007'", # select data only for two day period
            dbname = tempfile(), 
            file.format = list(header = T, row.names = F, sep=";"))
df<-DF[,"Global_active_power"]  # get the relevant column from the data frame
png(file="plot1.png",width=480,height=480, bg = "transparent")
hist(df, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()