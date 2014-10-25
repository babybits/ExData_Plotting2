
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

## load ggplot2 library
library(ggplot2)

## Get Baltimore Data, fips= 24510
NEI_fips24510 <- NEI[NEI$fips=="24510",]

## Aggregate Totals for Baltimore 
aggTotals_fips24510 <- aggregate(Emissions ~ year,NEI_fips24510, sum)

plot(aggTotals_fips24510$year,aggTotals_fips24510$Emissions,xlab="Year",ylab="Total Emissions"
     , main="Emissions by Year (Baltimore)")
lines(aggTotals_fips24510$year,aggTotals_fips24510$Emissions,xlab="Year", col="Blue")


## Print from screen to png file
dev.print(png, file="./plot2.png", width=480, height=480)

dev.off()