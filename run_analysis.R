# Project: Getting and Cleaning the Data
# Author: Rahul Deo
# Date : 11/11/21
#
# Questions : Directly copied from the assignment sheet
#Merges the training and the test sets to create one data set.

#Extracts only the measurements on the mean and standard deviation for each measurement. 

#Uses descriptive activity names to name the activities in the data set

#Appropriately labels the data set with descriptive variable names. 

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library("data.table", "reshape2")

data_url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Download the file and unzip

download.file(data_url, 'input_data.zip')

dir.create('project')
unzip('input_data.zip', exdir='project')

# 2 Activity and Feature Loading 

activity_label <- fread("project/UCI HAR Dataset/activity_labels.txt"
                        , col.names = c("classLabels", "activityName"))
features <- fread("project/UCI HAR Dataset/features.txt"
                  , col.names = c("index", "featureNames"))
required_feat <- grep("(mean|std)\\(\\)", features[, featureNames]) # use grep to extract the feature names with mean and standard deviation 
measurements <- features[required_feat, featureNames]
measurements <- gsub('[()]', '', measurements)


# Load train datasets
train <- fread("project/UCI HAR Dataset/train/X_train.txt")[, required_feat, with = FALSE]
data.table::setnames(train, colnames(train), measurements)  
train_activities <- fread("project/UCI HAR Dataset/train/y_train.txt"
                         , col.names = c("Activity"))
train_subjects <- fread("project/UCI HAR Dataset/train/subject_train.txt"
                       , col.names = c("subject_number"))
train <- cbind(train_subjects, train_activities, train)

# Load test datasets
test <- fread("project/UCI HAR Dataset/test/X_test.txt")[, required_feat, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
test_activities <- fread("project/UCI HAR Dataset/test/y_test.txt"
                        , col.names = c("Activity"))
test_subjects <- fread("project/UCI HAR Dataset/test/subject_test.txt"
                      , col.names = c("subject_number"))
test <- cbind(test_subjects, test_activities, test)

all_data <- rbind(train, test)

all_data[["Activity"]] <- factor(all_data[, Activity], levels = activity_label[["classLabels"]], labels = activity_label[["activityName"]])




all_data[["subject_number"]] <- factor(all_data[, subject_number])
all_data <- reshape2::melt(data = all_data, id = c("subject_number", "Activity"))
all_data <- reshape2::dcast(data = all_data, subject_number + Activity ~ variable, fun.aggregate = mean)

write.table(x = all_data, file = "tidy.txt", row.names = FALSE)


