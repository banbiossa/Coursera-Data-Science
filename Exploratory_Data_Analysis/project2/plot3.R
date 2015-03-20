# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions
# from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

data <- select(NEI,fips,Emissions,type,year)
data <- filter(data, fips==24510)
data <- select(data, Emissions, type, year)
data$type <- as.factor(data$type)
g <- qplot(year,Emissions,data=data,facets=.~type,
           stat="summary",fun.y="sum")
g + scale_x_discrete(breaks=c(1999, 2002, 2005, 2008))

print(g)
dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot3.png")
dev.off()