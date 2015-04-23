Notes: Getting and cleaning data
Sys.setenv(LANG = "en")


download.file(fileURL,destfile = "./data/cameras.csv",method="curl")
## curl is neccessary for https
dataDownloaded <- date()

cameraData <- read.csv(" ##file name")\
quote = "" ### this will mean there are no quotes

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

library(xlsx)
cameraData <- read.xlsx("./data//camera.xlsx",sheetIndex = 1,header = TRUE)

> colIndex <- 2:3
> rowIndex <- 1:4
> cameraDataSubset <- read.xlsx("./data/camera.xlsx",sheetIndex = 1,colIndex = colIndex,rowIndex = rowIndex)

<XML>
        
        <section> </section>
        <line break />
        <step number=3> Something </step>
        
        library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
xmlSApply(rootNode,xmlValue)
/node
//node
node[@attr-name]
node[@attr-name='bob']
xpathSApply(rootNode,"//name",xmlValue)

> fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
> doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
> scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)



<JSON>
        > library(jsonlite)
> jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
> names(jsonData)
names(jsonData$owner)

myJson <- toJSON(iris,pretty=TRUE)
> iris2 <- fromJSON(myJson)
> head(iris2)

<data.table>
        DF=data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DF=data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))

tables()
DT[2,]
DT[DT$y=="a"]
DT[c(2,3)]  ### this will subset in rows

#column subsetting
DT[,list(mean(x),mean(z))]    ##pass a list to do functions?

DT[,w:=z^2]  ##adding rows

DT2 <- DT
DT[,y:=2]  ## this will change DT2 also, because a copy isn't made

DT[,m:={tmp<-x+z;log(tmp+5)}]
DT[,a:=x>0]
DT[,b:=mean(x+w),by=a] ###this will put the means depending on a 

<< The .N operator>
        > set.seed(123)
> DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
> DT[,.N,by=x]
## this will count everything divided by x

<<keys>>
        > DT <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
> setkey(DT,x)
> DT['a']

> DT1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
> DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
setkey(DT1,x);setkey(DT2,x)

big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df,file=file,row.names=FALSE,col.names=TRUE,sep="\t",quote=FALSE)
system.time(fread(file))
system.time(read.table(file,header=TRUE,sep="\t"))

<MySQL>
        ucscDB <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")

result <- dbGetQuery(ucscDb,"show databases");dbDisconnect(ucscDb);
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")

allTables <- dbListTables(hg19)
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19,"affyU133Plus2")

query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misaes between 1 and 3")
affyMis <- fetch(query);quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10);dbClearResult(query);
## clear the query from the server
dim(affyMisSmall)

dbDisconnect(hg19)

<HDF5>
        > library(rhdf5)
> created = h5createFile("example.h5")
> created = h5createGroup("example.h5","foo")
> created = h5createGroup("example.h5","baa")
> created = h5createGroup("example.h5","foo/foobaa")
> h5ls("example.h5")

> A=matrix(1:10,nr=5,nc=2)
> h5write(A,"example.h5","foo/A")
> B=array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
> attr(B,"scale") <- "liter"
> h5write(B,"example.h5","foo/foobaa/B")
> h5ls("example.h5")

> df=data.frame(1L:5L,seq(0,1,length.out=5),c("ab","cde","fghi","a","s"),stringAsFactors=FALSE)
> h5write(df,"example.h5","df")

> readA=h5read("example.h5","foo/A")
> readA

> h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))

<Reading from the Web>
        > con=url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
> htmlCode=readLines(con)
> close(con)
> htmlCode

> library(XML)
> url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
> html <- htmlParse(url,useInternalNodes = T)
> xpathSApply(html,"//title",xmlValue)

> library(httr);html2=GET(url)
> content2=content(html2,as="text")
> parsedHtml=htmlParse(content2,asText=TRUE)
> xpathSApply(parsedHtml,"//title",xmlValue)

> pg1=GET("http://httpbin.org/basic-auth/user/passwd")
> pg1
pg2=GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
names(pg2)

> google=handle("http://google.com")
> pg1=GET(handle=google,path="/")
> pg2=GET(handle=google,path="search")

http://www.r-bloggers.com/?s=web+scraping

<twitter>
        library(jsonlite)
> myapp=oauth_app("twitter",key="aJKkcmtfhWFXRURcVOT15XRvi",secret="9sbFpgPZ84wDq9Gh15brCZN0APD708LqDucOZBAQrv4hFC5DEF")
> sig=sign_oauth1.0(myapp,token="89830482-cMzxyNEkJ0c8sEiidobx2GDc86Fcns26CDzwzNTiY",token_secret="PNggv0YCaqBCSQkV1JCufSx9Bsu8tb32lpOpWY6UwQoML")

homeTL=GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

> json1=content(homeTL)
> json2=jsonlite::fromJSON(toJSON(json1))
> json2[1:14]


<Subsetting>
        X[which(X$var2 > 8),] ##use which to eliminate NA's

sort(x$var, decreasing=TRUE, na.last=TRUE)

X[order(X$var1, X$var3),]

<plyr>
        library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

x$var4 <- rnorm(5)

y<-cbind(X,rnorm(5))
y<-rbind(X,rnorm(5))

<Summarize your data>
        head()
tail()
summary()
quantile()
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))

#make a table
table(restData$zipCode,useNA="ifany")
table(restData$councilDistrict,restData$zipCode)

## checking for NA's
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))

## checking for values
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]

data(UCBAdmissions)
> DF=as.data.frame(UCBAdmissions)
> summary(DF)

xt <- xtabs(Freq ~ Gender + Admit,data=DF)

warpbreaks$replicate <- rep(1:9,len=54)
xt = xtabs(breaks ~.,data=warpbreaks)
ftable(xt)

object.size()
print(object.size(),units="Mb"))

<Creating variables>
        > fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
> download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data//restaurants.csv")

## sequences
s1 <- seq(1,10,by=2);s1
s2 <- seq(1,10,length=3);s2
x <- c(1,3,8,25,100);seq(along=x)

> restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
> table(restData$nearMe)

> restData$zipWrong = ifelse(restData$zipCode < 0,TRUE,FALSE)
> table(restData$zipWrong,restData$zipCode<0)

> restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
> table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)

> library(Hmisc)
> restData$zipGroups = cut2(restData$zipCode,g=4)
> table(restData$zipGroups)

> restData$zcf <- factor(restData$zipCode)
> restData$zcf[1:10]

> yesno <- sample(c("yes","no"),size=10,replace=TRUE)
> yesnofac <- factor(yesno,levels=c("yes","no"))
> relevel(yesnofac,ref="yes")
> as.numeric(yesnofac)

> library(Hmisc);library(plyr)
> restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
> table(restData2$zipGroups)

abs
sqrt
floor
seiling
round(x, digits=n)
signif(x, digits=n) ## relevant numbers
sin, cos, log, exp

<Reshaping Data>
        > library(reshape2)
> head(mtcars)

> mtcars$carname <- rownames(mtcars)
> carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
> head(carMelt,n=3)

cylData <- dcast(carMelt,cyl ~ variable)
cylData<- dcast(carMelt,cyl~variable,mean)

> tapply(InsectSprays$count,InsectSprays$spray,sum)

spIns = split(InsectSprays$count,InsectSprays$spray)
sprCount = lapply(spIns,sum)
unlist(sprCount)

ddply(InsectSprays,.(spray),summarize,sum=sum(count))

spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))

acast
arrange
mutate


<dplyr>
        arrange
select
filter
mutate
rename
summarize

head(select(chicago, city:dpdt))
head(select(chicago, -(city:dpdt)))

chi.f <- filter(chicago, pm25mean > 30)

chicago <- arrange(chigago, date)
chicago <- arrange(chicago, desc(date))

chicago <- rename(chicago, pm25=pm25mean2)

chicago <- mutate(chicago,pm25detrend=pm25 - mean(pm25,na.rm=TRUE))
chicago <- mutate(chicago, tempcat = factor(1*(tmpd>80),labels=c("cold","hot")))
hotcold <- group_by(chicago,tempcat)

summarize(hotcold,pm=mean(pm25),o3 = max(o32mean), no2=meadian(no2tmean2))
chicago <- mutate(chicago, year=as.POSIXlt(data)$year + 1900)
years <- group_by(chicago,year)
summarize(year, pm25=mean(pm25,rm.na=TRUE), o3 =max(o32tmean2), no2=meadian(no2tmean2)))

<Pipeline operations>
        chicago %>% mutate(month=as.POSIXlt(date)$month + 1) %>% group_by(month) %>% summarize(pm25=mean(pm25,na.rm=TRUE),no2=meadian(no2))

<Merging Data>
        > fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
> fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
> download.file(fileUrl1,"./data/reviews.csv","curl")
> download.file(fileUrl2,"./data/solutions.csv","curl")
> reviews=read.csv("./data/reviews.csv")
> solutions=read.csv("./data/solutions.csv")
> head(reviews,2)

mergedData=merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)

intersect(names(solutions),names(reviews))

### Using the plyr package
> df1=data.frame(id=sample(1:10),x=rnorm(10))
> df2=data.frame(id=sample(1:10),y=rnorm(10))
> arrange(join(df1,df2),id)

dflist=list(df1,df2,df3)
join_all(dlist)


<Manuplate Variables>
        cameraData <- read.csv("./data/cameras.csv")
tolower(names(cameraData))

splitNames = strsplit(names(cameraData),"\\.")

mylist <- list(letters=c("a","b","c"),numbers=1:3,matrix(1:25,ncol=5))

> firstElement <- function(x){x[1]}
> sapply(splitNames,firstElement)

> reviews <- read.csv("./data/reviews.csv")
> solutions <- read.csv("./data/solutions.csv")

sub("_","",names(reviews),)
> test <- "this_is_a_test"
> sub("_","",test,)
> gsub("_","",test,)

### Search
grep("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

grep("Alameda",cameraData$intersection,value=TRUE)

> library(stringr)
> nchar("Shota Shimizu")
substr("Shota Shimizu",1,7)
paste("shota","shimizu")
paste0("shota","shimizu")
str_trim("shota       ")

<Regular expressions>
        ^beginning of a line
end of a line$
        [B b] ush 
[0-9][a-zA-Z]
[^?.]$   ##this means ending with not ? or .
        
        .   ### this can be anything
|  ### this means or a|b
        ( )? ## what's before the question mark is optional
\. ### this is a literal dot 
(.*) ### the * is anytimes at all 
[0-9] + ### plus is at least one number
        ( +[^ ]+ +){1,5}  ### space word space up to 5 times

+([a-zA-Z]+) +\1 + ### the exact match of words
        ^s(.*)s    ### this a greedy s~s
^s(.*?)s$ ### this is not greedy
        
        
        <Dates>
        d1 = date()
d2 = Sys.Date()
format(d2,"%a %b %d")
x = c("1jan1960","2jan1960","3jan1960");z=as.Date(x,"%d%b%Y")
z[1] -z[2]

%d day as number
%a abbreviated weekday
%A unabbreviated weekday
%m month
%b abbreviated month
%B unabbreviated month
%y 2 digit year
%Y 4 digit year

library(lubridate)
ymd("20141009")
mdy("09/09/2014")
dmy("02-02-2013")
ymd_hms("2011-02-23 10:12:03")
?Sys.timezone

x = dmy(c("1jan2013","2jan2013","4mar2013"))
wday(x[1])
wday(x[1],label=TRUE)

<Getting data>
        http://data.un.org/
        http://www.data.gov/
        www.data.gov/opendatasites/
        gapminder.org/
        www.asdfree.com/
        infochimps.com/marketplace
http://www.kaggle.com/
        6-lists-created-by-datascientists
UCI machine learning
cmu statlib
gene expression omnibus
arxiv data
amazon

<dplyr>
        select
filter
mutate

cran <- tbl_df(dataset)
by_package <- group_by(cran,package)

<tidyr>
        library(tidyr)
gather(students,sex,count,-grade)

gather(students3, class, grade, class1:class5, na.rm = TRUE)
spread(students3, test,grade)

select(-contains("totall"))
separate(part_sex,c("part","sex"))
mutate(total=sum(count))













