library(tidyverse)

getwd()
setwd("C:/Users.....Desktop/exdata_data_NEI_data")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

#Aggregate data
total <- aggregate(Emissions ~ year,NEI, sum)

#Plot 1

png("plot1.png",width=480,height=480)

barplot(
  (total$Emissions)/10^6,
  names.arg=total$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources")

dev.off()
