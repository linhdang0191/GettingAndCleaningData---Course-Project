# GettingAndCleaningData---Course-Project
This is my submission for peer-graded course project in Coursera course Getting and Cleaning Data by JHU. Completed on 27 Oct 2019. 

### In this repository
This repository contains these files:
* The `README.md` that you are reading: Project introduction, source of the dataset and brief summary on how the code in the `run_analysis.R` works. 
* `CodeBook.md`: more detailed information about data collection, variable features, and description about the tidying process
* `Data_Course3.zip`: the data zip file
* `run_analysis.R`: the script 
* `TidyData.txt` : the final data exported

### Dataset
In this course project, we use this dataset
[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) 

**This is version 1.0, with reference is made to these authors:**
*Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws*  

####  What run_analysis.R does
This script file in this repo performs those steps on the dataset (for more details, please go to **section 3** in the `CodeBook.md`) :
* Download, unzip, and import the appropriate data from data files into dataframes
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Authors
* Linh Dang - initial work - [GitHub](https://github.com/linhdang0191)
