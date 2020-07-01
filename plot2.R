library(tidyverse)

getwd()
setwd("C:/Users.....Desktop/exdata_data_NEI_data")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)


#Subset data for Baltimore City, Maryland (fips == "24510")
balt_city <- NEI[NEI$fips=="24510",]

#Aggregate data
total_balt <- aggregate(Emissions ~ year, balt_city, sum)

#Plot 2

png("plot2.png",width=480,height=480)

barplot(total_balt$Emissions,
        names.arg=total_balt$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
        main="Total PM2.5 Emissions From all Baltimore City Sources")

dev.off()
