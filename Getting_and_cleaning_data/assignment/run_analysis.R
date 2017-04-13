# test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
names(x_test) <- features$V2

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test) <- "action_code"
test <- cbind(y_test,x_test)

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity) <- c("action_code","action")

tmp <- merge(activity, test, by = "action_code")

library(dplyr)
arrange(tmp, action, action_code)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
test <- cbind(subject_test, tmp)

# train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) <- features$V2
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train) <- "action_code"
train <- cbind(y_train,x_train)
tmp2 <- merge(activity, train, by = "action_code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"
train <- cbind(subject_train, tmp2)

# merege test and train data
df <- rbind(test, train)

# select names with mean() std()
#length(grep("mean|std",names(df)))
df_mean_sd <- select(df, grep("mean|std",names(df)))
df_mean_sd <- cbind(df[1:3],df_mean_sd)
write.csv(df_mean_sd,file="df_mean_sd.csv")

unmelted <- df_mean_sd %>%
  group_by(action_code, subject) %>%
  summarize_each(funs(mean),-action)

library(reshape2)
clean_data <- melt(unmelted, id=c("action_code","subject"))
names(clean_data) <- c("action_code","subject","feature","mean")
head(clean_data)
table(clean_data$subject)
clean_data2 <- merge(activity, clean_data, by = "action_code")
write.csv(clean_data2,file="clean_data.csv")
names(clean_data2)
head(clean_data2)
write.table(clean_data2,file="clean_data.txt",row.names = F)