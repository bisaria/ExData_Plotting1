library(sqldf)
f <- file("household_power_consumption.txt")
DF <- sqldf("select * from f where Date == '1/2/2007' or Date == '2/2/2007'", dbname = tempfile(), file.format = list(header = T, row.names = F, sep=";"))
df<-DF[,"Global_active_power"]
png(file="plot1.png",width=480,height=480)
hist(df, main = "Global Active Power", col="red", xlab = "Global Active Power(kilowatts)")
dev.off()