plot4 <- function(){
        #load the necessary packages
        install.packages(c("plyr", "dplyr"))
        library("plyr"); library("dplyr")
        
        #first check for the UCI HAR directory, if it doesn't exist then download the data
        if(!file.exists("household_power_consumption.txt")){
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "Data.zip")
                unzip("Data.zip")
                file.remove("Data.zip")
        }
        
        #read the data
        read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) -> hpc
        hpcsmall <- hpc %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
        hpcfinal <- hpcsmall %>% mutate(DateTime = as.POSIXct(paste(hpcsmall[,1], hpcsmall[,2]), format = "%d/%m/%Y %H:%M:%S")) %>% select(-Date, -Time) 
        
        #make plot4
        par(mfrow = c(2,2), mar = c(4.8,3.8,3.8,1.8))
        #topleft
        with(hpcfinal, plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
        with(hpcfinal, lines(DateTime, Global_active_power))
        #topright
        with(hpcfinal, plot(DateTime, Voltage, type = "n", xlab = "datetime"))
        with(hpcfinal, lines(DateTime, Voltage))
        #bottomleft
        with(hpcfinal, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
        with(hpcfinal, lines(DateTime, Sub_metering_1, col = "black"))
        with(hpcfinal, lines(DateTime, Sub_metering_2, col = "red"))
        with(hpcfinal, lines(DateTime, Sub_metering_3, col = "blue"))
        legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, y.intersp = 0.9, bty = "n", cex = 0.9)
        #bottomright
        with(hpcfinal, plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime"))
        with(hpcfinal, lines(DateTime, Global_reactive_power))
        
        #export as png
        dev.copy(png, file = "plot4.png", width = 480, height = 480)
        dev.off()
}

