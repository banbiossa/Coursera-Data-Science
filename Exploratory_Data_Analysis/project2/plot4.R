# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
library(dplyr)
library(ggplot2)

# get the SCC where matches 'Coal'
coal <- filter(SCC, grepl('Coal',Short.Name))
data <- select(NEI,SCC,Emissions,year)

# get data where the SCC matches in data
# x %in% table
data$coal <- data$SCC %in% coal$SCC
data <- filter(data, coal==TRUE)

g <- qplot(year,Emissions,data=data,stat="summary",fun.y="sum") + 
        ggtitle("coal emissions")

print(g)
dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot4.png")
dev.off()