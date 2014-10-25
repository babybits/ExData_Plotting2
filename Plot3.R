
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
library(plyr)

## Get Baltimore Data, fips= 24510
NEI_Balt <- ddply(NEI[NEI$fips == "24510", ],
               .(type,year), summarise, 
               TotalEmissions = sum(Emissions))

## Plot the graph, with title and labels 
ggplot(NEI_Balt, aes(x=year, y=TotalEmissions ,color=type)) +
    geom_line() + geom_point() +
    xlab("Year") + ylab("Total Emissions") +
    facet_grid(type~., scales = "free") +
    ggtitle("Emissions by Year and Type (Baltimore)")

## Print from screen to png file
dev.print(png, file="./plot3.png", width=480, height=480)

dev.off()