plot1 <- function(){
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
        
        #make plot1
        par(mfrow = c(1,1), mar = c(4.8, 3.8, 3.8, 1.8))
        with(hpcfinal, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col="red"))
        
        #export as png
        dev.copy(png, file = "plot1.png", width = 480, height = 480)
        dev.off()
}

