# Clustering case study
# data from Samsung smarphones

url <- "https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
#load("./data/samsungData.rda")
#print(names(samsungData)[1:12])
#print(table(samsungData$activity))

par(mfrow=c(1,2),mar=c(5,4,2,1))
samsungData <- transform(samsungData, activity=factor(activity))
sub1 <- subset(samsungData, subject==1)
plot(sub1[,1], col=sub1$activity, ylab=names(sub1)[1])
plot(sub1[,2], col=sub1$activity, ylab=names(sub1)[2])
legend("bottomright",legend=unique(sub1$activity),col=unique(sub1$activity),pch=1)

par(mfrow=c(1,1))
source("myplclust.R")
distanceMatrix <- dist(sub1[,1:3])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col=unclass(sub1$activity))
# not much going on

par(mfrow=c(1,2))
plot(sub1[,10], col=sub1$activity, ylab=names(sub1)[10])
plot(sub1[,11], col=sub1$activity, ylab=names(sub1)[11])

par(mfrow=c(1,1))
distanceMatrix <- dist(sub1[,10:12])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col=unclass(sub1$activity))
# clear clusters

svd1 = svd(scale(sub1[, -c(562,563)]))
par(mfrow=c(1,2))
plot(svd1$u[,1], col=sub1$activity, pch=19)
plot(svd1$u[,2], col=sub1$activity, pch=19)

par(mfrow=c(1,1))
plot(svd1$v[,2], pch=19)

maxContrib <- which.max(svd1$v[,2])
distanceMatrix <- dist(sub1[, c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
myplclust(hclustering, lab.col=unclass(sub1$activity))

print(names(samsungData[maxContrib]))

kClust <- kmeans(sub1[, -c(562,563)], centers=6, nstart=1)
print(table(kClust$cluster, sub1$activity))

kClust <- kmeans(sub1[, -c(562,563)], centers=6, nstart=100)
print(table(kClust$cluster, sub1$activity))

plot(kClust$center[1, 1:10], pch=19, ylab="Cluster center", xlab="")
# first three are mean body acclearaion

plot(kClust$center[4, 1:10], pch=19, ylab="Cluster center", xlab="")
# the 4th has different points

