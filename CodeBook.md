## This code book  describes the variables, the data, and any transformations that was performed to clean up the data for this course project. This final file `dataAggregation.txt` contains the average of each variable for each activity and each subject.

###DATA FILES
`X_est.txt`,` y_test.txt`,`subject_test.txt` contains the test files
`X_train.txt`,`y_train.txt`,`subject_train.txt` contains the training files
`features.txt` has the feature names
`activity_labels` has the activity names and ID

###VARIABLES
`dtXTest`,`dtYTest`,`dtSubjectTest` contain the test data and is combined using `cbind` into `dtTestData`
`dtXTrain`,`dtYTrain`,`dtSubjectTrain` contain the training data and is combined using `cbind` into `dtTrainData`
`dtFeatures` contain the features data 
`dtActivityLabels` has the activity labels
`dtFinalData` the final data set
`dtFeaturesMeanStd` contains  only the measurements on the mean and standard deviation for each measurement
`dtFinalActivity` contains descriptive activity names to name the activities in the data set
`dataAggr` contains the aggregate data on activity and subject
`dataAggregation.txt`   independent tidy data set with the average of each variable for each activity and each subject

###TRANSFORMATIONS
`**run_analysis.R**` contains the script for processing the data in the files and do the transformation required in the exercise
1. Merges the training and the test sets to create one data set. using `cbind`,`rbind`,`merge` function
2. Extracts only the measurements on the mean and standard deviation for each measurement. Using `grep` function
3. Uses descriptive activity names to name the activities in the data set. using `merge` function by `activityId` get the *activityName*
4. Appropriately labels the data set with descriptive variable names. Using `gsub` function to appropriately name the variables
5. creates a  tidy data set with the average of each variable for each activity and each subject. Using **ddply** to get the final file
