# <Reproducible Research>
# Reproducing is between reproducting and nothing
# The author may have problems putting data on the web (no servers)
# Readers may have problems downloading the data, etc.

# <Literate Programming>
#       weaved -> produce human readable documents
#       tangled -> produce machine readable code
# - sweave: limitations
# - knitr: kinda good

# <Golden Rule>
# script everthing

# <Structure of a data analysis>
# - define the question
# - define the ideal data set
# - determine what data is accessible
# - obtain the data
# - clean the data
# - exploratory data analysis
# - statistical modeling
# - interpret results
# - challenge results 
# - write up resutls
# - create reproducible code

# <defining the question>
# you have too much or too little
# goal: descriptive, exploratory, inferential, predictive, casual, mechanistic
# Q. can I recognise spam/ham in my email
# -> access all the mails in the gmail servers?
# -> free data, buy data, generate data
# http://archive.ics.uci.edu/ml/datasets/Spambase
# we will use the "kernlab" package

library(kernlab)
data(spam)
print(str(spam[,1:5]))

# we'll devide this into a test set and data set
# sample in half
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
print(table(trainIndicator))
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# some exploratory data analysis
print(names(trainSpam))
print(head(trainSpam))
# they're frequency of words
print(table(trainSpam$type))

plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve) ~ trainSpam$type)
# can see that spam have more capital letters

plot(log10(trainSpam[,1:4] + 1))
# some corelate, some don't

hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)
# not very helpful

hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:57] + 1))))
plot(hClusterUpdated)
# capitaeAve on it's own, you/will/your make a cluster, etc.
trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x,y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for(i in 1:55){
        lmFormula = reformulate(names(trainSpam)[i], response = "numType")
        glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
        cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

# which predictor has minimum cross validated-error?
print(names(trainSpam)[which.min(cvError)])

# use the best model
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

# get predictions from the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonSpam", dim(testSpam)[1])

# classify as spam if prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"

# classification table
print(table(predictedSpam, testSpam$type))

# Error rate


# challege yourself
# why the data, method, uncertanity, etc.

# write up
# question
# 

