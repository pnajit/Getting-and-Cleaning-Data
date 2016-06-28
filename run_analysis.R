rm(list=ls(all=TRUE))
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)
install.packages("plyr")
library(plyr)
# set the working directory
setwd("E:/INSOFE/R/GCD/UCI HAR Dataset")

# Read Test data from the files

dtXTest <- read.table("./test/X_test.txt",header=FALSE)
dtYTest <- read.table("./test/y_test.txt",header=FALSE)
dtSubjectTest <- read.table("./test/subject_test.txt",header=FALSE)
# Read Training data from the files
dtXTrain <- read.table("./train/X_train.txt",header=FALSE)
dtYTrain <- read.table("./train/y_train.txt",header=FALSE)
dtSubjectTrain <- read.table("./train/subject_train.txt",header=FALSE)

# Read features and activity labels data from the files
dtFeatures <- read.table("features.txt",header=FALSE)
  dtActivityLabels <- read.table("activity_labels.txt",header=FALSE)
colnames(dtActivityLabels) = c("activityId","activityName")
# Assign test column header data
colnames(dtXTest) = dtFeatures[,2]
colnames(dtYTest) = 'activityId'
colnames(dtSubjectTest) = 'subjectId'
  
# Assign train column header data
colnames(dtXTrain) = dtFeatures[,2]
colnames(dtYTrain) = 'activityId'
colnames(dtSubjectTrain) = 'subjectId'

#combine Training data set
dtTrainData <- cbind(dtYTrain,dtSubjectTrain,dtXTrain)

#combine test data set
dtTestData <- cbind(dtYTest,dtSubjectTest,dtXTest)

#make the final data set
dtFinalData <- rbind(dtTrainData,dtTestData)

## Extracts only the measurements on the mean and standard deviation for each measurement.
dtFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dtFeatures[, 2],value=TRUE) 
# get only columns with mean() or std() in their names
dtFeaturesMeanStd <- union(c("activityId","subjectId"), dtFeaturesMeanStd)
# Get the desired columns
dtFinalDataMeanStd <- dtFinalData[,dtFeaturesMeanStd]

##Use descriptive activity names to name the activities in the data set

dtFinalActivity <- merge(dtActivityLabels,dtFinalData,by = "activityId",all.x=TRUE)
dtFinalActivity <- dtFinalActivity[,-1]
dtFinalActivity$activityName <- as.character(dtFinalActivity$activityName)

#dataAggr<- aggregate(. ~ subjectId - activityName, data = dtFinalActivity, mean) 
#dataTable<- tbl_df(arrange(dataAggr,subjectId,activityName))

names(dtFinalActivity)<-gsub("std()", "SD", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("mean()", "MEAN", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("^t", "time", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("^f", "frequency", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("Acc", "Accelerometer", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("Gyro", "Gyroscope", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("Mag", "Magnitude", names(dtFinalActivity))
names(dtFinalActivity)<-gsub("BodyBody", "Body", names(dtFinalActivity))
# Names after
head(str(dtFinalActivity),6)

##From the data set in step 4, creates a second, independent tidy data set with the average of
##each variable for each activity and each subject

dataAggr = ddply(dtFinalActivity, c("subjectId","activityName"), numcolwise(mean))
write.table(dataAggr, file = "dataAggregation.txt")
