Exploatory Data Analysis

pollution <- read.csv("./data//avgpm25.csv",colClasses=c("numeric","character","factor","numeric","numeric"))
summary(pollution$pm25)
boxplot(pollution$pm25,col="blue")
hist(pollution$pm25,col="green")
rug(pollution$pm25)
hist(pollution$pm25,col="green",breaks=100)

boxplot(pollution$pm25,col="blue")
abline(h=12)

hist(pollution$pm25,col="green")
abline(v=12,lwd=2)
abline(v=median(pollution$pm25),col="magenta",lwd=4)

barplot(table(pollution$region),col="wheat",main="Number of countries in each region")

<2D and more>
        boxplot(pm25 ~ region, data=pollution,col="red")

> par(mfrow=c(2,1),mar=c(4,4,2,1))
> hist(subset(pollution,region="east")$pm25,col="green")
> hist(subset(pollution,region="west")$pm25,col="green")

with(pollution, plot(latitude,pm25))
with(pollution, plot(latitude,pm25,col=region))

> par(mfrow=c(1,2),mar=c(5,4,2,1)) with(subset(pollution,region=="west"),plot(latitude,pm25,main="west"))
with(subset(pollution,region=="east"),plot(latitude,pm25,main="east"))

<Plotting Systems>
        ### The base plot
        
        > library(datasets)
> data(cars)
> with(cars,plot(speed,dist))

### The Lattice System
xyplot, bwplot
# specify a lot of info in the funciton call
> library(lattice)
> state <- data.frame(state.x77, region=state.region)
> xyplot(Life.Exp ~ Income | region, data=state,layout=c(4,1))

### ggplot2 system
> library(ggplot2)
> data(mpg)
> qplot(displ,hwy,data=mpg)

<The base plot system>
        ?plot
?par
> library(datasets)
#histagram
> hist(airquality$Ozone)

#scatterplot
with(airquality,plot(Wind,Ozone))

#boxplot
> airquality <- transform(airquality,Month=factor(Month))
> boxplot(Ozone ~ Month, airquality, xlab="Month",ylab="Ozone(ppb)")

<parameters>
        pch  #plotting character
lty         #line type
lwd	#LINE width
col	#color
xlab
ylab

par()  # the par function
las 	#lable axis
bg	#background color
mar	#margin size
oma 	#outer margin size
mfrow	#number of plots per row, column
mfcol	#number of plots per row, column

par("lty") 	#check the default values

### Functions
plot
lines
points
text
title
mtext
axis

<Plotting in color>
        > library(datasets)
> with(airquality,plot(Wind,Ozone))
> title(main="Wind and Ozone in New York City")
with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))

> with(airquality,plot(Wind,Ozone,main="Ozone and WInd in NYC",type="n"))
> with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))
> with(subset(airquality,Month!=5),points(Wind,Ozone,col="red"))

<Regression lines>
        > with(airquality,plot(Wind,Ozone,main="Ozone and WInd in NYC",pch=20))
> model <- lm(Ozone~Wind,airquality)
> abline(model,lwd=2)

<Plotting multiple graphs>
        par(mfrow=c(1,2))
with(airquality,{plot(Wind,Ozone,main="Ozone and Wind");plot(Solar.R,Ozone,main="Ozone and Solar Radiation")})

> par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,0))
> with(airquality,{plot(Wind,Ozone,main="Ozone and Wind");plot(Solar.R,Ozone,main="Ozone and Solar Radiation");plot(Temp,Ozone,main="temperature and ozone");mtext("Ozone and Weather in NYC",outer=TRUE)})


<Plotting>
        > x <- rnorm(100)
> hist(x)

> plot(x,y,pch=2)
> plot(x,y,pch=3)
plot(x,y,pch=19)
example(points)

> title("scatterplot")
> text(-2,-2,"label")
> legend("topleft",legend="data",pch=20)

> fit <- lm(y~x)
> abline(fit)
> abline(fit,lwd=3)

> z <- rpois(100,2)
> par(mfrow=c(2,1))
> plot(x,y,pch=2)
> plot(x,z,pch=19)
> par("mar")

> x <- rnorm(100)
> y <- x + rnorm(100)
> g <- gl(2,50)
> g <- gl(2,50,labels=c("male","female"))
plot(x,y)

plot(x,y,type="n")
points(x[g=="male"],y[g=="male"],col="green")
points(x[g=="female"],y[g=="female"],col="blue")
points(x[g=="female"],y[g=="female"],col="blue",pch=19)

<Graphic Devices>
        quartz()
?Devices

### on the screen
library(datasets)
with(faithful,plot(eruptions,waiting))

### to a pdf
> pdf(file="myplot.pdf")
> with(faithful,plot(eruptions,waiting))
> title(main="Old Faithful Gyser data")


<Graphic Formats>
        ###vector
        pdf
svg
postscript

###bitmap
png
jpeg
tiff

##active graphic device
dev.cur()
dev.set(##integer)
        dev.copy()
        dev.copy2pdf()
        
        > library(datasets)
        > with(faithful,plot(eruptions,waiting))
        > title(main="Old Faithful")
        > dev.copy(png,file="geyserplot.png")
        > dev.off()
        
        
        <Lattice System>
                ## lattice builds up on grid
                ## return a trellis
                xyplot 
        bwplot
        histogram
        stripplot
        dotplot
        splom
        levelplot, contourplot
        
        xyplot(y ~ x | f*g, data)
        library(lattice)
        library(datasets)
        xyplot(Ozone ~ Wind, data=airquality)
        
        airquality <- transform(airquality,Month=factor(Month))
        
        > p <- xyplot(Ozone ~ Wind, data=airquality)
        > print(p)
        
        > set.seed(10)
        > x<-rnorm(10)
        > x<-rnorm(100)
        > f <- rep(0:1,each=50)
        > y<-x+f-x*f+rnorm(100,sd=0.5)
        > f <- factor(f,labels=c("group1","group2"))
        > xyplot(y~x|f,layout=c(2,1))
        
        xyplot(y~x|f,panel=function(x,y,...){
                panel.xyplot(x,y,...)
                panel.abline(h=median(y), lty=2)
        })
        
        xyplot(y~x|f,panel=function(x,y,...){
                panel.xyplot(x,y,...)
                panel.lmline(x,y,col=2)
        })
        
        <ggplot2>
                the grammar of graphics
        mapping to aesthetics(color, shape, size), geometrics (points, lines,bars) /may contain statistical transformation
        
        <qplot()>
                factors indicate subsets, so label factors
        
        library(ggplot2)
        str(mpg)
        qplot(displ,hwy,data=mpg)
        qplot(displ,hwy,data=mpg,color=drv)
        qplot(displ,hwy,data=mpg,geom=c("point","smooth"))
        #point for the plots, smooth for the smoothed line
        qplot(hwy,data=mpg,fill=drv) #one will make a histogram
        
        ### facets
        qplot(displ,hwy,data=mpg,facets=.~drv)
        qplot(hwy,data=mpg,facets=drv~.,binwidth=2)
        facets = #rows ~ #columns
                
                load("./data/maacs.Rda")
        qplot(log(eno),data=maacs)
        qplot(log(eno),data=maacs,fill=mopos)
        
        qplot(log(eno),data=maacs,geom="density")
        qplot(log(eno),data=maacs,geom="density",color=mopos)
        
        qplot(log(pm25),log(eno),data=maacs)
        qplot(log(pm25),log(eno),data=maacs,shape=mopos)
        qplot(log(pm25),log(eno),data=maacs,color=mopos)
        
        qplot(log(pm25),log(eno),data=maacs,color=mopos,geom=c("point","smooth"),method="lm")
        qplot(log(pm25),log(eno),data=maacs,geom=c("point","smooth"),method="lm",facets=.~mopos)
        
        
        geom=c("point","smooth"), method="lm"
        
        <ggplot>
                g <- ggplot(maacs,aes(eno,pm25))
        summary(g)
        p <- g + geom_point()
        g + geom_point() + geom_smooth()
        g + geom_point() + geom_smooth(method="lm")
        g + geom_point() + geom_smooth(method="lm") + facet_grid(.~mopos)
        
        xlab(),ylab()
        theme()
        theme_gray()
        
        g + geom_point(color="steelblue",size=4,alpha=1/2)
        g + geom_point(aes(color=mopos),size=4,alpha=1/2)
        # wrap in aes for variables
        
        g + geom_point(aes(color=mopos)) + labs(title="MAACS") + labs(x="log eno",y=expression("log"* pm[2.5]))
        
        g + geom_point(aes(color=mopos),size=4,alpha=1/2) + geom_smooth(size=4,linetype=3,method="lm",se=FALSE)
        
        g + geom_point(aes(color=mopos)) + theme_bw(base_family="Times")
        # change theme to blackwhite, font to Times
        
        
        > testdat <- data.frame(x=1:100,y=rnorm(100))
        > testdat[50,2] <- 100
        > plot(testdat$x,testdat$y,type="l",ylim=c(-3,3))
        > g <- ggplot(testdat,aes(x=x,y=y))
        > g+geom_line()
        
        g+geom_line() + ylim(-3,3) ## subsettted
        g+geom_line() + coord_cartesian(ylim=c(-3,3))
        
        ### cut in quantiles
        > cutpoints <- quantile(maacs$duBedMusM,seq(0,1,length=4),na.rm=TRUE)
        > maacs$du2dec <- cut(maacs$duBedMusM,cutpoints)
        > levels(maacs$du2)
        
        g + geom_point(alpha=1/3)+facet_wrap(mopos ~ du2dec, nrow=2,ncol=4)+geom_smooth(method="lm",se=FALSE,col="steelblue")+theme_bw(base_family="Avenir",base_size=10)+labs(x="eno")+labs(y=expression("log "*PM[2.5]))+labs(title="MAACS")
        
        
        
        
        
        66638
        69517
        header=t
        skip66636
        n2880
        
        
        
        
        <Hierarchical clustering>
                agglomertive
        
        ##distance
        Euclidian	route sum(z1-z2)^2
        Manhattan sum |z1 - z2|
                
                set.seed(1234)
        par(mar=c(0,0,3,0))
        x <- rnorm(12,mean=rep(1:3,each=4),sd=0.4)
        y <- rnorm(12,mean=rep(c(1,2,1),each=4),sd=0.4)
        plot(x,y,col="blue",pch=19,cex=2)
        text(x+0.05,y+0.05,labels=as.character(1:12))
        dataFrame <- data.frame(x=x,y=y)
        dist(dataFrame)
        
        distxy <- dist(dataFrame)
        hClustering <- hclust(distxy)
        plot(hClustering)
        
        # Prettier dendrograms
        myplclust <- function(hclust, lab = hclust$labels, lab.col = rep(1, length(hclust$labels)), 
                              hang = 0.1, ...) {
                y <- rep(hclust$height, 2)
                x <- as.numeric(hclust$merge)
                y <- y[which(x < 0)]
                x <- x[which(x < 0)]
                x <- abs(x)
                y <- y[order(x)]
                x <- x[order(x)]
                plot(hclust, labels = F, hang = hang, ...)
                text(x = x, y = y[hclust$order] - (max(hclust$height)*hang), labels = lab[hclust$order], 
                     col = lab.col[hclust$order], srt = 90, adj = c(1, 0.5), xpd = NA, ...)
        }
        
        ## average linkage
        ## complete linkage
        
        # <Heatmap> clusters in a image
        set.seed(143)
        dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
        heatmap(dataMatrix)
        
        # <Kmeans Clustering>
        # define: close, group, interpretation
        set.seed(1234)
        par(mar=c(2,0,1,0))
        x <- rnorm(12,mean=rep(1:3,each=4),sd=0.4)
        y <- rnorm(12,mean=rep(c(1,2,1),each=4),sd=0.4)
        plot(x,y,col="blue",pch=19,cex=2)
        text(x+0.05,y+0.05,labels=as.character(1:12))
        
        # start with k centroids
        # assign groups to the centroids
        # move centroid to center of cluster
        # iterate
        dataFrame <- data.frame(x=x,y=y)
        kmeansObj <- kmeans(dataFrame,center=3)
        names(kmeansObj)
        kmeansObj$cluster
        
        par(mar=rep(0.2,4))
        plot(x,y,col=kmeansObj$cluster,pch=19,cex=2)
        points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)
        
        # using a heatmap
        dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
        kmeansObj2 <- kmeans(dataMatrix, centers=3)
        par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
        image(t(dataMatrix)[,nrow(dataMatrix):1], yaxt="n")
        image(t(dataMatrix)[,order(kmeansObj2$cluster)], yaxt = "n")
        
        setwd("/Users//shota/git//Coursera-Data-Science/Exploratory_Data_Analysis/")
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        d