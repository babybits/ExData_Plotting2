
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

## Fine Coal Combustion
coalcom <- SCC[grep("Comb.*Coal", SCC$Short.Name), "SCC"]
coalcombNEI <- NEI[NEI$SCC %in% coalcom, ]

CoalCombTotal <- ddply(coalcombNEI, .(year), 
          summarise, 
          TotalEmissions = sum(Emissions))

## Plot the graph, with title and labels 
ggplot(CoalCombTotal, aes(x=year, y=TotalEmissions)) +
    geom_line(col="Red") + geom_point() +
    xlab("Year") + ylab("Total Emissions") +
    ggtitle("Total Emissions from Coal Combustion Related Sources")

## Print from screen to png file
dev.print(png, file="./plot4.png", width=480, height=480)

dev.off()