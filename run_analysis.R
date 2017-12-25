library(dplyr)
library(data.table)
# This script produces a summary tidy dataset of average values of measurements from a Samsung phone accelerometer
# for different subjects performing each of a set of movements. This is based upon the following publication:
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#   Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
#   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# get the data tables from the train and test sets
xtest<-read.table('UCI HAR Dataset/test/X_test.txt', stringsAsFactors = FALSE)
xtrain<-read.table('UCI HAR Dataset/train/X_train.txt', stringsAsFactors = FALSE)

# make a table of the data "features," and convert to a lower case vector of names
featurenames<-read.table('UCI HAR Dataset/features.txt', stringsAsFactors = FALSE)
featurenames<-featurenames$V2
featurenames<-gsub('Acc','acceleration',featurenames)
featurenames<-gsub('Mag','magnitude',featurenames)
featurenames<-gsub('std()', 'standarddeviation', featurenames)
featurenames<-tolower(featurenames)
featurenames<-gsub('-x$','xaxis',featurenames)
featurenames<-gsub('-y$','yaxis',featurenames)
featurenames<-gsub('-z$','zaxis',featurenames)
featurenames<-gsub('-','',featurenames)
featurenames<-gsub('[()]','',featurenames)
featurenames<-gsub('^t', 'time', featurenames)
featurenames<-gsub('^f', 'frequency', featurenames)
featurenames<-gsub('bodybody','body', featurenames) # apparent typo in the original data
# set the column names of test and train to the feature names
colnames(xtest)<-colnames(xtrain)<-featurenames
# # 4 satisfied - "Appropriately labels the data set with descriptive variable names."

# get the activity list from each, set the column name to "activity"
activitytest<-read.table('UCI HAR Dataset/test/y_test.txt', stringsAsFactors = FALSE)
colnames(activitytest)<-'activity'
activitytrain<-read.table('UCI HAR Dataset/train/y_train.txt', stringsAsFactors = FALSE)
colnames(activitytrain)<-'activity'

#get the subject numbers from each set, and set the names 
subjectnumbertest<-read.table('UCI HAR Dataset/test/subject_test.txt', stringsAsFactors = FALSE)
colnames(subjectnumbertest)<-'subjectnumber'
subjectnumbertrain<-read.table('UCI HAR Dataset/train/subject_train.txt', stringsAsFactors = FALSE)
colnames(subjectnumbertrain)<-'subjectnumber'

# cbind subject and activity to measurements
df1<-cbind(subjectnumbertrain, activitytrain, xtrain)
df2<-cbind(subjectnumbertest, activitytest, xtest)

# rbind the two data frames together
df<-rbind(df1,df2)
# #1 satisfied - Merges the training and the test sets to create one data set.

# get the labels provided for activities, and set column names appropriately
alabels<-read.table('UCI HAR Dataset/activity_labels.txt', stringsAsFactors = FALSE)
colnames(alabels)<-c('activity','activityname')

# merge with activity frame to put names to activities
df<-merge(alabels, df, by='activity')
# #3 now satisfied - Uses descriptive activity names to name the activities in the data set

# use dplyr to gt all of the "mean","meanfreq", and "std" rownames by removing the "angle" ,
# then grep the remaining list with "mean" or "std" - unlist them into a vector, and store in "nms" 
nms<-featurenames %>% lapply(function(x){x[which(!grepl('^angle',x))]}) %>% lapply(function(x){x[which(grepl('mean',x) | grepl('standarddeviation',x))]}) %>% unlist

# start pairing down to only the means and std data by 
nms<-c('subjectnumber', 'activityname', nms)
df<-select(df,nms)
# #2 now satisfied - Extracts only the measurements on the mean and standard deviation for each measurement.

# group by subject number, then add a grouping by activityname, then summarize the remaining columns with mean
# result is a data table with the average of each measurement for each subject conducting each activity
dfout<-df %>% group_by(subjectnumber) %>% group_by(activityname, add=TRUE) %>% summarise_all(mean) %>% data.table

# write out the table, but don't add the row numbers, as they will end up in the txt file, and are unnecessary
write.table(dfout, file = 'tidysummary.txt', row.names = FALSE)
# #5 now satisfied - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



