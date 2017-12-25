# getting-cleaning-data
Coursera/JHU "Getting and Cleaning Data" final project by James E. Harris, Jr.

This repository contains the final project from the JHU "Getting and Cleaning Data" course. The data contained within is based upon the "Human Activity Recognition Using Smartphones Dataset Version 1.0" from Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

From the readme file included with this data:
```
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. "
```

For a full explanation of the original data, see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This repository provides an R script (run_analysis.R) for averaging the original mean and standard deviation data by subject and activity.

The output of the script is also provided (tidysummary.txt), as well as a code book (codebook.txt) for understanding the table in tidysummary.txt.

The original data have been processed according to the following instructions:
```
"You should create one R script called run_analysis.R that does the following.

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
```
# Getting started 
## Running the script for yourself
The script expects the original dataset to be available in the working directory as a subdirectory named "UCI HAR Dataset." 

Download the dataset here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip it, being careful to preserve the original path information. When unzip is complete, in your working directory, you should have a directory named "UCI HAR Dataset" containing the subdirectories "test" and "train," along with the original data files in txt format.

Run the processing script `source('run_analysis.R', echo=TRUE)`, which will place the processed data in a data table (dfout), and written to a file (tidysummary.txt).

### Comments
Within the code of run_analysis.R, there are comment lines (preceeded by "#") which explain how each activity above was performed. For example:
```R
# start pairing down to only the means and std data by 
nms<-c('subjectnumber', 'activityname', nms)
df<-select(df,nms)
# #2 now satisfied - Extracts only the measurements on the mean and standard deviation for each measurement.

```

## Reading tidysummary.txt
You can examine the contents of the output file by reading it into a variable:
```R
dfout<-read.table('tidysummary.txt', header = TRUE)
head(dfout)
```

## Interpreting tidysummary.txt

The file "codebook.txt" contains a detailed explanation of how to read each of the variables in the tidysummary.txt. The column names are designed to be easily readible in plain english.
