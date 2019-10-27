# Course Project Codebook
## Getting and Cleaning Data

Author: Linh Dang
Date: 27 OCT 2019 

#### 1. About Study Design and Dataset  

Data in this dataset are collected from the study: "Human Activity Recognition Using Smartphones Dataset Version 1.0". More information about its authors and paper references could be found in this [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#).  

##### 1A. The Experiment Description

The experiments have been carried out with a group of **30 volunteers** within an age bracket of **19-48 years**. Each person performed **six activities** (*WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING*) wearing a smartphone (*Samsung Galaxy S II*) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data.

The sensor signals (*accelerometer* and *gyroscope*) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low-frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##### 1B. Feature Attributes
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

##### 1C. Included File Descriptions
The dataset includes the following files:
- 'README.txt'

- 'features_info.txt': Shows information about the variables used in the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X-axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies to the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z-axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

#### 2. Variables 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time-domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also, the magnitude of these three-dimensional signals was calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally, a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. The sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with the largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt' 

#### 3. Tidying Process
The process of tidying this dataset includes these phases with 1 imported library (`dplyr`). 
##### 3A. Import data from data files into dataframes

The original data folder "UCI HAR Dataset" contains many data files, however, in this process, we use only those data files:
* `features.txt` - list of all features measured in the dataset
* `activitiy_labels.txt` - labels for activities of interest in the study
* Training dataset: 
 +`subject_train.txt` - subjects in  training dataset, denoted by numbers
 +`X_train.txt` - recorded measurements
 +`y_train.txt` - labels for recorded measurements 

* Testing dataset:
 +`subject_test` - subjects in testing dataset, denote by numbers
 +`X_test.txt` - recorded measurements 
 +`y_test.txt` - labels for recorded measurements 
 
 
We then load and assign them to variables using `read.table()`

* `features` <- `features.txt`: 561 observations, 2 variables (`num` (`int`) - ordinal number,  `feature` (`chr`)  - names of features)

* `act_labels` <- `activity_labels.txt`: 6 observations, 2 variables (`num` (`int`) - ordinal number, `activity` (`chr`)  - activities names)

* `subject_train` <- `subject_train.txt` : 7352 observations, 1 variable (`subject` (`int`) - subjects denoted by numbers)

* `training_set` <- `X_train.txt`:  7352 obvervations, 561 variables (recorded measurements in each feature, each column name is the name of that feature, all `num`)

* `training_labels` <- `y_train.txt` : 7352 observations, 1 variable (`num` (`int`) - activity recorded, denoted in numbers)

* `subject_test` <- `subject_test.txt` : 2947 obervations, 1 variable (`subject` (`int`) - subject denoted by numbers)

* `test_set` <- `X_test.txt`: 2947 observations, 561 variables (recorded measurements in each feature, each column name is the name of that feature, all `num`)

* `test_labels` <- `y_train.txt`: 2947 observations, 1 variable (`num` (`int`) - activity recorded, denoted by numbers)

##### 3B. Merge training and testing datasets into one complete dataset  

There are two separate datasets : *training* and *testing*. Our goal is to merge them into one dataset, with appropriate shape and column names.  We accomplish it through 4 steps:

* Merge `training_set` and `test_set` to create `data` (10299 observations, 561 variables) using `rbind()` (another alternative is to use `bind_rows()` in `dplyr` package)

* Merge `subject_train` and `subject_test` to create `subject` (10299 observations, 1 variable) using `rbind()`

* Merge `training_labels` and `test_labels` to create `labels` (10299 observations, 1 variable) using `rbind()`

* Merge `subject`, `labels`, and `data` (in that order) to create `merged_dat` (10299 observations, 563 variables) using `cbind()`

##### 3C. Extracts only the measurements on the mean and standard deviation for each measurement  
Before subsequent transformations, we produce a copy of the dataset using `copy()`as it may be useful for possible comparison and reference.
```{r}
o_dat <- copy(merged_dat)
```
Using `select()` in `dplyr` package, we select only the columns with names containing `mean` or `std` and then reassign the data frame produced to `merged_dat`. The resulting dataset has 10299 observations and 88 variables (including `subject`, `num` (activity labels encoded) and variables whose names contain `mean` or `std`)

##### 3D. Use descriptive activity names to name the activities in the data set

We replace the numbers in column `num` of `merged_dat` with activity names in column `activity` of `act_labels`. Since activity names are categorical data, we encoded them as levels of a `factor`.
```{r}
merged_dat$num <- factor(merged_dat$num,levels = act_labels$num, labels = act_labels$activity)
```
##### 3E. Appropriately labels the data set with descriptive variable names 
Using `gsub()` and **regular expressions**, we replace abbreviations with their full forms and remove unnecessary symbols.

##### 3F. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

The last phase is to create a new dataset containing the average of each variable of each subject and each activity. 

We have **88 variables** in `merged_dat`, **30 subject**s, and **6 recorded activities**. The expected dataset will have **88 variables**, with **180 observations** (**180 ordered pairs** from the **Cartesian product** of 30 subjects and 6 activities) 

* Use `group_by()` from the `dplyr` package, we group the data by subject and by activity.
* Use `summarise()` to apply `mean()` to all columns with measurement variables. 
* `arrange()` will arrange the rows by subject and next, by activity.


After those previous phrases, we obtain a tidy dataset `tidy_dat` with **180 observations** and **88 variables**. Export it into text file (`TidyData.txt`) using `write_table(tidy_dat, "./TidyData.txt",row.names = FALSE)`
