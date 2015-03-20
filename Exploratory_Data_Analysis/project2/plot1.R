# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.
library(dplyr)
data <- select(NEI,Emissions,year)
by_year <- group_by(data, year)
sum <- summarize(by_year, pm=sum(Emissions))
matrix <- as.matrix(sum)
barplot(sum$pm,names.arg=sum$year,beside=TRUE,xlab="year",ylab="Emission")

dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot1.png")
dev.off()