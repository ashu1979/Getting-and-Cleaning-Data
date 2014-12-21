## Load required library
require("data.table")
require("reshape2")

## Download file from the source and named it data.zip. Unzip it later to it's default directory "UCI HAR Dataset" in current working directory.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip")
unzip("data.zip", list = TRUE)

## Read Subject data from train and test files respectively. Change the name of the column from default.
subjects <- rbind(fread("UCI HAR Dataset/train/subject_train.txt"), fread("UCI HAR Dataset/test/subject_test.txt"))
setnames(subjects, "V1", "subject")

## Read Labels data from train and test files respectively. Change the name of the column from default.
labels <- rbind(fread("UCI HAR Dataset/train/y_train.txt"), fread("UCI HAR Dataset/test/y_test.txt"))
setnames(labels, "V1", "activityID")

## fread was generating error so used read.table to read data into R object. 
## Read measurement data from train and test files respectively. Change the name of the column from default.
x <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))

## Merge the data sets prepared above.
data <- cbind(subjects, labels, x)

## Read features data from features.txt file and filter the features mean() and std().
## New column is added corresponding to featureCode defined in measurement data to merge later on.
features <- fread("UCI HAR Dataset/features.txt")
setnames(features, names(features), c("featureID", "featureName"))
features <- features[grepl("mean\\(|std\\(", featureName)]
features$featureCode <- features[, paste0("V", featureID)]

## Read activity data from activity_labels.txt file and change the column name.
activity <- fread("UCI HAR Dataset/activity_labels.txt")
setnames(activity, names(activity), c("activityID", "activityName"))

## Merge activity to original data and subset it to only required set of measures.
data <- merge(data, activity, by = "activityID", all.X = TRUE)
labelSet <- c("activityID", "subject", "activityName")
data <- data[, c(labelSet, features$featureCode), with=FALSE]

## Reshape the data by transposing the measurement variables. Further merge it with feature names.
data <- melt(data, labelSet, variable.name = "featureCode", value.name = "featureValue")
data <- merge(data, features, by = "featureCode", all.x = TRUE)

## Generate tidy dataset with the average of each variable for each activity and each subject.
tidyData <- dcast(data, subject+activityID ~ featureName, mean, value.var = "featureValue")

## Write data to tidyData.txt file.
write.table(tidyData, file = "tidyData.txt", row.name = FALSE)