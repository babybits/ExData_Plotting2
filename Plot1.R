
setwd("C:/Naavi/Coursera/R Working Directory")


## Set the file Url to download the file.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
tempZip <- "./data/exdata_data_NEI_data.zip"

## Download file
download.file(fileUrl,destfile=tempZip)

## Set working directory to data and unzip file
rdsfile1 <- "./data/summarySCC_PM25.rds"
rdsfile2 <- "./data/Source_Classification_Code.rds"
rdsfilename1 <- "summarySCC_PM25.rds"
rdsfilename2 <- "Source_Classification_Code.rds"
unzip(tempZip,rdsfilename1)
unzip(tempZip,rdsfilename2)

## Read the files 
NEI <- readRDS(rdsfile1)
SCC <- readRDS(rdsfile2)


## Aggregate Totals
aggTotals <- aggregate(Emissions ~ year,NEI, sum)

## Plot the graph, with title and labels 
plot(aggTotals$year,aggTotals$Emissions/10^6,xlab="Year",ylab="Total Emissions (10^6)"
     , main="Emissions by Year for all sources")
lines(aggTotals$year,aggTotals$Emissions/10^6,xlab="Year",col="Red")

## Print from screen to png file
dev.print(png, file="./plot1.png", width=480, height=480)

dev.off()

