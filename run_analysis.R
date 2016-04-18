library(plyr) 


# Step 1 
# Merge the training and test sets to create one data set 
############################################################################### 


Xrain <- read.table("train/X_train.txt") 
Yrain <- read.table("train/y_train.txt") 
Subrain <- read.table("train/subject_train.txt") 


Xtest <- read.table("test/X_test.txt") 
Ytest <- read.table("test/y_test.txt") 
Subtest <- read.table("test/subject_test.txt") 


# create 'x' data set 
Xdata <- rbind(read.table("train/X_train.txt"), x_testread.table("test/X_test.txt")) 


# create 'y' data set 
Ydata <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt")) 


# create 'subject' data set 
Subdata <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt")) 


# Step 2 
# Extract only the measurements on the mean and standard deviation for each measurement 
############################################################################### 

features <- read.table("features.txt") 


# get only columns with mean() or std() in their names 
mean_or_std_in_features <- grep("-(mean|std)\\(\\)", features[, 2]) 


# subset the desired columns 
Xdata <- Xdata[, mean_or_std_in_features] 


# correct the column names 
names(Xdata) <- features[mean_or_std_in_features, 2] 


# Step 3 
# Use descriptive activity names to name the activities in the data set 
############################################################################### 


activities <- read.table("activity_labels.txt") 


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


#write.table(averages_data, "averages_data.txt", row.name=FALSE )
write.csv(averages_data, "averages_data.csv", row.names = FALSE )
