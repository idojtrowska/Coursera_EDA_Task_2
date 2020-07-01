library(tidyverse)
library(ggplot2)

getwd()
setwd("C:/Users.....Desktop/exdata_data_NEI_data")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

#Subset NEI data
balt_city_1 <- NEI[NEI$fips=="24510",]

# Aggregate data [Baltimore emissions data by year]
total_balt_1 <- aggregate(Emissions ~ year, balt_city_1, sum)

#Plot 3

png("plot3.png",width=480,height=480)

plot <- ggplot(balt_city_1,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
