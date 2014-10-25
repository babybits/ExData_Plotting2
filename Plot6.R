
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

## Filter NEI by Balimore and Los Angles

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=T)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI_Balt_LA[NEI_Balt_LA$SCC %in% vehiclesSCC,]

NEIBalt <- vehiclesNEI[vehiclesNEI$fips=="24510",]
NEIBalt$city <- "Baltimore City"

NEILA <- vehiclesNEI[vehiclesNEI$fips=="06037",]
NEILA$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
NEIBaltLA <- rbind(NEIBalt,NEILA)

ggp <- ggplot(NEIBaltLA, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity", ) +
    facet_grid(.~city) +
    guides(fill=FALSE) +
    labs(x="year", y=expression("Total Emissions")) + 
    labs(title=expression("Motor Vehicle Source Emissions in Baltimore & LA"))

print(ggp)

## Print from screen to png file
dev.print(png, file="./plot6.png", width=480, height=480)

dev.off()