# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
library(ggplot2)

dataB <- filter(NEI, fips==24510) #Baltimore
dataL <- filter(NEI, fips=="06037") #Los

# filter motor vehicle
motor <- filter(SCC, grepl('Motor',Short.Name))
dataB$motor <- dataB$SCC %in% motor$SCC
dataL$motor <- dataL$SCC %in% motor$SCC
dataB <- filter(dataB, motor==TRUE)
dataL <- filter(dataL, motor==TRUE)

dataB <- select(dataB, Emissions, year)
dataL <- select(dataL, Emissions, year)
aggB <- aggregate(dataB,list(year=dataB$year),sum)
aggL <- aggregate(dataL, by=list(year=dataL$year),sum)
aggB$city <- "Baltimore"
aggL$city <- "Los Angeles"
agg <- rbind(aggL,aggB)

g <- ggplot() + 
        geom_line(aes(x=year,y=Emissions,colour=city),data=agg) +
        ylab("Motorcycle Emissions") + 
        xlab("Year") + 
        scale_x_continuous(breaks=c(1999,2002,2005,2008),
                           label=c(1999,2002,2005,2008))

print(g)
dev.copy(png,file="/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/project2/plot6.png")
dev.off()