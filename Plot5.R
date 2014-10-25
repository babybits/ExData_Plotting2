
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

## Filter NEI by Baltimore(fips=24510) and type on Road for Motors 
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]
VehiclesNEI_Balt <- vehiclesNEI[vehiclesNEI$fips=="24510",]
VehiclesNEI_Balt_Total <- ddply(VehiclesNEI_Balt, .(year), 
                       summarise, 
                       TotalEmissions = sum(Emissions))

## Plot the graph, with title and labels 
ggplot(VehiclesNEI_Balt_Total, aes(x=year, y=TotalEmissions)) +
    geom_line(col="Red") + geom_point() +
    xlab("Year") + ylab("Total Emissions") +
    ggtitle("Total Emissions from Motor Vehicles for Baltimore")

## Print from screen to png file
dev.print(png, file="./plot5.png", width=480, height=480)

dev.off()