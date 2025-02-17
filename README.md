data cleansing assignment
Assignment: Getting and Cleaning Data Course Project

Explains the analysis files is clear and understandable.

This read me document explains how all of the scripts work and how they are connected.

Script download_data performs below 2 steps:

Step 1: 

download all the data files in teh working directory and save in the working directory
Merge the training and test sets to create one data set 

Step 2: 

read all the test data tables in the R variables
read all the train data tables in the R variables
create 'x' data set by using rbind 

Xdata <- rbind(read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt")) 

S# create 'y' data set by using rbind
Ydata <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt")) 


# create 'subject' data set by using rbind
Subdata <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt")) 


# Step 2 
# Extract only the measurements on the mean and standard deviation for each measurement 
############################################################################### 

features <- read.table("UCI HAR Dataset/features.txt") 


# get only columns with mean() or std() in their names 
mean_or_std_in_features <- grep("-(mean|std)\\(\\)", features[, 2]) 


# subset the desired columns 
Xdata <- Xdata[, mean_or_std_in_features] 


# correct the column names 
names(Xdata) <- features[mean_or_std_in_features, 2] 


# Step 3 
# Use descriptive activity names to name the activities in the data set 
############################################################################### 


activities <- read.table("UCI HAR Dataset/activity_labels.txt") 


# update values with correct activity names 
Ydata[, 1] <- activities[Ydata[, 1], 2] 


# correct column name 
names(Ydata) <- "activity" 


# Step 4 
# Appropriately label the data set with descriptive variable names 
############################################################################### 


# correct column name 
names(Subdata) <- "subject" 


# bind all the data in a single data set 
all_data <- cbind(Xdata, Ydata, Subdata) 


# Step 5 
# Create a second, independent tidy data set with the average of each variable 
# for each activity and each subject 
############################################################################### 


# 66 <- 68 columns but last two (activity & subject) 
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66])) 



write.csv(averages_data, "averages_data.csv", row.names = FALSE )
