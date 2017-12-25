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
### Functions of the script:
The script reads 'X_test.txt' and 'X_train.txt' and assigns each to a data frame (xtest and xtrain, respectively).

Column names for the test and train data are altered into a more readable format by reading 'features.txt' into a variable called "features," coverting it to a vector, and altering the names to remove punctuation marks, capitalization, an apparent typo ('bodybody'), and potentially confusing abbreviations using 'gsub' and 'tolower.' This name vector replaces the column headings for each set using 'colnames.' (accomplishing #4)

The script creates an activity number column by reading 'y_test.txt' and 'y_train.txt' into activitytest and activitytrain, respectively.
Subject data are added by reading 'subject_test.txt' and 'subject_train.txt' into columns called subjectnumbertest and subjectnumbertrain.

Two data frames (df1 and df2) are created for the test and train data by using 'cbind' to combine the subject number and the activity number to their respective data.The two resulting data frames are combined using 'rbind' into one data set, "df." (accomplishing #1).

The translation from activity number to activity name ('activity_labels.txt') is read into a data frame ("alabels") with column names 'activity' and 'activityname', and the activity (number) column is used to generate a new "activityname" column in df by using "merge" to combine the df and alabels by the activity number column. The resultant data frame, df, now has subject number, activity number, activity name, and the original data sets merged together (accomplishing #3).

The column name vector is paired down to remove anything that is not a "mean," "std," or "meanfreq" measurement (this involves ignoring one measurement which is the angle between a measurement and a mean - which is not a true mean), and to add the subject number and activity name columns only using dplyr pipes with grep expressions. This is stored in the vector "nms."

'select' is used to pair down the data frame df to only those columns defined by the 'nms' column name vector (accomplishing #2).

Finally, dplyr pipes are used with 'group_by'and 'summarise_all' to group the data (df) first by subject number, then by activity, producing a summary frame with means of all of the remaining data columns. The resultant data frame (dfout) now has the averge data for each subject performing each activity (accomplishing #5). 

## Reading tidysummary.txt
You can examine the contents of the output file by reading it into a variable:
```R
dfout<-read.table('tidysummary.txt', header = TRUE)
head(dfout)
```

## Interpreting tidysummary.txt

The file "codebook.txt" contains a detailed explanation of how to read each of the variables in the tidysummary.txt. The column names are designed to be easily readible in plain english.
