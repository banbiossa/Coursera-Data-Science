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

## Dimension reduction
set.seed(12345)
par(mar = rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow=40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

set.seed(678910)
for(i in 1:40){
        #flip a coin
        coinFlip <- rbinom(1,size=1,prob=0.5)
        # if coin is heads, add a common pattern to the row
        if(coinFlip){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
        }
}
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

## Singular value decompression
# trying to explain the data with a smaller dataset
# X = U * D * V ... U and V are singular
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,,xlab="Row", ylab = "First left singular vector", pch=19)
plot(svd1$v[,1],xlab="Column", ylab = "First right singular vector", pch=19)
# don't understand what U and V resemble

par(mfrow=c(1,2))
plot(svd1$d, xlab="Column", ylab="Singular Value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab="Column",ylab="Prop. of variance explained",pch=19)
# don't understand why D is variance

# pca and svd are the same thing
par(mar=c(4,2,2,2),mfrow=c(1,1))
pca1 <- prcomp(dataMatrixOrdered, scale=TRUE)
plot(pca1$rotation[,1], svd1$v[,1], pch=19, xlab="Principle Component", ylab="Right Singular Vector 1")
abline(c(0,1))

# in a boring matrix, no variation
constantMatrix <- dataMatrixOrdered * 0
for(i in 1:dim(dataMatrixOrdered)[1]){constantMatrix[i,] <- rep(c(0,1),each=5)}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d, xlab="Column", ylab="Singular Value", pch=19)
plot(svd1$d^2/sum(svd1$d^2), xlab="Column",ylab="Prop. of variance explained",pch=19)

# add another pattern
set.seed(67890)
for(i in 1:40){
        # flip a coin
        coinFlip1 <- rbinom(1, size=1, prob=0.5)
        coinFlip2 <- rbinom(1, size=1, prob=0.5)
        # if coin is heads add a common pattern to that row
        if(coinFlip1){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),each=5)
        }
        if(coinFlip2){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),5)
        }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
# this is the "truth"
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1),each=5), xlab="Column", ylab="Pattern 1")
plot(rep(c(0,1),5), xlab="Column",ylab="Pattern 2")

# can we pick the "truth" up in svd?
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1],pch=19,xlab="Column",ylab="First right singluar vector")
plot(svd2$v[,2],pch=19,xlab="Column",ylab="Second right singular venctor")

# d and variance explained
par(mfrow=c(1,2))
plot(svd2$d, xlab="Column", ylab="Singular Value", pch=19)
plot(svd2$d^2/sum(svd2$d^2), xlab="Column", ylab="Percent of variance explained",pch=19)

# missing values in svd
dataMatrix2 <- dataMatrixOrdered
# insert
dataMatrix2[sample(1:100, size=40, replace=FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) # won't work