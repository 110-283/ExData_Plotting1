library(lubridate)

# Read data

Sys.setlocale(locale = "en_US.utf8")

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL, temp)
unzip (temp, exdir = getwd())
unlink(temp)

datafile <- as.character(list.files(getwd(), pattern = "txt"))
rawData <- read.table(datafile, header = TRUE, sep = ";", stringsAsFactors = FALSE)

dates <- as.data.frame(paste(rawData$Date,rawData$Time))
datetime <- strptime(dates[,1],format = "%d/%m/%Y %H:%M:%S", tz = "EST")
filtData <- cbind(datetime,rawData[,-c(1,2)])

finalData <- filtData[year(filtData$datetime) == 2007 & month(filtData$datetime) == 2 & 
                          (day(filtData$datetime) == 1 | day(filtData$datetime) == 2),]

finalData2 <- finalData [complete.cases(finalData),]
finalData[-1] <- sapply(finalData[-1],as.numeric)

# Plot 3

png(filename = "plot3.png", width = 480, height = 480)
with (finalData, plot(datetime, Sub_metering_1, type = "n",xlab = "", 
                      ylab = "Energy sub metering"))
with (finalData, lines(datetime, Sub_metering_1, col = 1))
with (finalData, lines(datetime, Sub_metering_2, col = 2))
with (finalData, lines(datetime, Sub_metering_3, col = 4))
legend("topright", col = c(1,2,4),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1))
dev.off()