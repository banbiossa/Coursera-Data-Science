#Getting and cleaning data

dateDownloaded <- date()
setwd("/Users/shotashimizu/git/Coursera-Data-Science/Getting_and_cleaning_data/")
```{r quiz1}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "IdahoHousing.csv", method = "curl")


?download.file
data <- read.csv("IdahoHousing.csv")
head(data)
require(dplyr)
data %>%
  filter(!is.na(VAL)) %>%
  filter(VAL == 24) %>%
  nrow()

```

```{r quiz1 q3}
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              destfile = "gas.xlsx", method = "curl")


install.packages("xlsx")
require(xlsx)

?read.xlsx
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
  
  dat
What is the value of:
  
  sum(dat$Zip*dat$Ext,na.rm=T)

dat <- read.xlsx("gas.xlsx", 1, startRow = 18, endRow = 23)
head(dat)
dat <- dat[,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)

# quiz 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              "restaurants.xml",method = "curl")
install.packages("XML")
require(XML)
data <- xmlParse("restaurants.xml")
xml_data <- xmlToList(data)
head(xml_data)
names(xml_data)
xml_data[1]
xml_data[[1]][[1]]

zipcode <- as.list(xml_data[[1]]$zipcode)
xml_data[[1]][[1]]$zipcode

temp <- xml_data[[1]]
head(temp)
temp[[1]]

?unlist
unlist(temp[[1]])
unlist(temp)
temp[["zipcode"]]
dim(temp)
?dim
length(temp)
zipcodes <- ""
for(i in 1:length(temp)){
  zipcodes[i] <- temp[[i]]$zipcode
}
sum(zipcodes == "21231")

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              "idaho.csv",method = "curl")

data <- read.csv("idaho.csv")
head(data)
install.packages("data.table")
require(data.table)
DT <- fread("idaho.csv")
?apply

system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

system.time(DT[,mean(pwgtp15),by=SEX])

system.time(mean(DT[DT$SEX==1,]$pwgtp15),mean(DT[DT$SEX==2,]$pwgtp15))

system.time(rowMeans(DT)[DT$SEX==1],rowMeans(DT)[DT$SEX==2])

system.time(mean(DT$pwgtp15,by=DT$SEX))

