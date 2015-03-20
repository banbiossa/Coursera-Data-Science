# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
# make a plot answering this question.
library(dplyr)
data <- select(NEI,fips,Emissions,year)
data2 <- filter(data,fips==24510)
by_year <- group_by(data2,year)
sum <- summarize(by_year,pm=sum(Emissions))
matrix <- as.matrix(sum)
barplot(sum$pm,names.arg=sum$year,beside=TRUE,xlab="year",ylab="Emission")
title("Emissions in Baltimore")
dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot2.png")
dev.off()