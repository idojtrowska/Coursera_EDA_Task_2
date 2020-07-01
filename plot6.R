library(tidyverse)
library(ggplot2)

getwd()
setwd("C:/Users.....Desktop/exdata_data_NEI_data")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

# Subset of the NEI data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by each city's fip and add city name
vehicles_balt_NEI <- vehicles_NEI[vehicles_NEI$fips=="24510",]
vehicles_balt_NEI$city <- "Baltimore City"

vehicles_LA_NEI <- vehicles_NEI[vehicles_NEI$fips=="06037",]
vehicles_LA_NEI$city <- "Los Angeles County"

# Merge two datasets
full_NEI <- rbind(vehicles_balt_NEI, vehicles_LA_NEI)

#Plot 6
png("plot6.png",width=480,height=480)

plot <- ggplot(full_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
                 geom_bar(aes(fill=year),stat="identity") +
                 facet_grid(scales="free", space="free", .~city) +
                 guides(fill=FALSE) + theme_bw() +
                 labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
                 labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
