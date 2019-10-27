
zipname = "Data_Course3.zip"

# First, we check if the file has been downloaded yet. If not, then download it. 
if (!file.exists(zipname)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                zipname, method = "curl")
}

# Second, check if the file has been unzipped yet. If not, then unzip it. 
if (!file.exists("UCI HAR Dataset")) {
  unzip("Data_Course3.zip")
}


# Import dplyr for more convenient data manipulation  

library(dplyr)

#------------------------------------------------------------------------------

# Read the data 

# Read the features (measurement names) and activity labels 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("num", "feature"))
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("num", "activity"))


# Training dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject") 
training_set <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
training_labels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "num")  

# Test dataset 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "num")

# ------------------------------------------------------------------------------
# The next step will be merging datasets into a complete dataset
# The result will have the shape like this example
# ------------------------------------------
# | subject | num | var 1 | var 2 | var ...| 
# ------------------------------------------
# |   1     |   2 | 0.123 |0.2589 | 0.752  |

# Merge the training and test set
data <- rbind(training_set,test_set)

# Merge the subject data 

subject <- rbind(subject_train,subject_test)

# Merge the labels 
labels <- rbind(training_labels, test_labels)

# Merge those 3 datasets to produce the complete data 
merged_dat <- cbind(subject,labels,data)

# It is optional, but before further transformation, make a copy of the dataset

o_dat <- copy(merged_dat)

# -------------------------------------------------------------------------------

# Extract only columns with mean or std, then reassign it to merged_dat
# select function in dplyr makes it more simple 
merged_dat <- merged_dat %>% select(subject,num,contains("mean"), contains("std"))

# --------------------------------------------------------------------------------
# Use descriptive names to names activities
# Modify number in num to activity names according to num - name pairs in act_labels
# Since activity names are categorical data, encode them as levels of a factor

merged_dat$num <- factor(merged_dat$num,levels = act_labels$num, labels = act_labels$activity)


# Change column name to "activity" 
names(merged_dat)[2] <- "activity"

# ---------------------------------------------------------------------------------
# Change the names of columns to be more descriptive (sorry for this messy code :<)

names(merged_dat) <- gsub("^t", "Time", names(merged_dat))
names(merged_dat) <- gsub("^f", "Frequency", names(merged_dat))

# Remove "-" and "()" 
names(merged_dat) <- gsub("\\()", "", names(merged_dat))
names(merged_dat) <- gsub("-", "", names(merged_dat))

# Deal with abbreviation dramas 
names(merged_dat) <- gsub("Acc", "Accelerometer", names(merged_dat))
names(merged_dat) <- gsub("Gyro", "Gyroscope", names(merged_dat))
names(merged_dat) <- gsub("Mag", "Magnitude", names(merged_dat))
names(merged_dat) <- gsub("angle", "Angle", names(merged_dat))
names(merged_dat) <- gsub("gravity", "Gravity", names(merged_dat))
names(merged_dat) <- gsub("mean", ".Mean", names(merged_dat))
names(merged_dat) <- gsub("std", ".StDev", names(merged_dat))


# ------------------------------------------------------------------------------
# Create the second independent dataset

# Group the dataset by subject and activity
# Find the means using summarise_all(means) -> apply mean() to all measurement columns
# Arrange by subject ( 1 -> 30) then by activity (ordering follows factor levels)

tidy_dat <- merged_dat %>% group_by(subject, activity) %>%
            summarise_all(mean) %>% 
            arrange(subject,activity)

# -------------------------------------------------------------------------------
# Export the required file
write.table(tidy_dat,"./TidyData.txt", row.names = FALSE)

