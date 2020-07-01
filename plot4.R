library(tidyverse)
library(ggplot2)

getwd()
setwd("C:/Users.....Desktop/exdata_data_NEI_data")

#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

# Subset coal combustion 
comb_rel <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_rel <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coal_com <- (comb_rel & coal_rel)
comb_SCC <- SCC[coal_com,]$SCC
comb_NEI <- NEI[NEI$SCC %in% comb_SCC,]

#Plot 4
png("plot4.png",width=480,height=480)

plot <- ggplot(comb_NEI,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()
