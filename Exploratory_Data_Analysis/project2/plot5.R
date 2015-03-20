# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

library(dplyr)
library(ggplot2)

# filter Baltimore
data <- filter(NEI, fips==24510) 

# filter motor vehicle
motor <- filter(SCC, grepl('Motor',Short.Name))
data$motor <- data$SCC %in% motor$SCC
data <- filter(data, motor==TRUE)

g <- qplot(year,Emissions,data=data,stat="summary",fun.y="sum") + 
        ggtitle("Baltimore motor cycle emissions")

print(g)
dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot5.png")
dev.off()