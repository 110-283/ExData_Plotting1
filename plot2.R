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

# Plot 2

png(filename = "plot2.png", width = 480, height = 480)
plot(finalData$datetime, finalData$Global_active_power, type = "l",xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()