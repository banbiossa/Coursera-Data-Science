# less 1999.txt
# grep ^RC 2012.txt
# setwd("/Users//shota/git/Coursera-Data-Science/Exploratory_Data_Analysis/")
#pm0 <- read.table("./data/1999.txt", comment.char="#",header=FALSE,sep="|",na.strings="")
#print(head(pm0))
cnames <- readLines("./data/1999.txt",1)
#print(cnames)
cnames <- strsplit(cnames,"|",fixed=TRUE)
#print(cnames)
names(pm0) <- make.names(cnames[[1]])
#print(head(pm0))
x0 <- pm0$Sample.Value
#print(class(x0))
#print(str(x0))
#print(summary(x0))
#print(mean(is.na(x0)))
#pm1 <- read.table("./data/2012.txt",comment.char="#",header=FALSE,sep="|",na.strings="")
names(pm1) <- make.names(cnames[[1]])
x1 <- pm1$Sample.Value
#print(class(x1))
#print(summary(x0))
#print(summary(x1))
#print(mean(is.na(x1)))
#boxplot(x0,x1)
#boxplot(log(x0),log(x1))
negative <- x1 < 0
#print(str(negative))
#print(mean(negative,na.rm=TRUE))
dates <- pm1$Date
#print(str(dates))
dates <- as.Date(as.character(dates),"%Y%m%d")
#print(str(dates))
#hist(dates,"month")
#hist(dates[negative],"month")

# check for a single place, NYC
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))

# connetct the columns
site0 <- paste(site0[,1], site0[,2], sep=".")
site1 <- paste(site1[,1], site1[,2], sep=".")

# which exsist in both?
both <- intersect(site0, site1)

# add the code to the original data frame
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep="."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep="."))

# subset where they intersect
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

# count how many
#print(sapply(split(cnt0, cnt0$county.site), nrow))
#print(sapply(split(cnt1, cnt1$county.site), nrow))

# use 63.2008 at is has 122 & 118 observants
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)

# make a time series
dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
#plot(dates1, x1sub)

# dates not in format
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
#plot(dates1, x1sub)

dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
# plot(dates0, x0sub)

# plot both data
par(mfrow=c(1,2))
plot(dates0, x0sub, pch=20)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch=20)
abline(h = median(x1sub, na.rm = T))

#range(x0sub,x1sub,na.rm=T)
rng <- range(x0sub,x1sub,na.rm=T)
plot(dates0, x0sub, pch=20, ylim = rng)
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch=20, ylim = rng)
abline(h = median(x1sub, na.rm = T))

# mean of 1999 and 2012 across several states
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = T))
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = T))
#print(summary(mn0))
#print(summary(mn1))

d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)
mrg <- merge(d0,d1, by="state")
#print(head(mrg))

# plot the data
par(mfrow=c(1,1))
with(mrg, plot(rep(1999,53), mrg[,2], xlim = c(1998,2013)))
with(mrg, points(rep(2012,53), mrg[,3]))
segments(rep(1999,53), mrg[,2], rep(2012,53), mrg[,3])
