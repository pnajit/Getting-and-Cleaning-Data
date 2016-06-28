# Getting and Cleaning Data Project
This is the project for the Getting and cleaning Data course. 
The R script 'run_analysis.R' does the following tasks

1. **Reads** the data from the text files  in Train ('y_train.txt','subject_train.txt','X_train.txt')
    and Test ('y_test.txt','subject_test.txt','X_test.txt') folders
2. **Merges** the training and the test sets to create one data set.
3. **Extracts** only the measurements on the mean and standard deviation for each measurement.
4. **Naming:** Uses descriptive activity names to name the activities in the data set
5. **Labeling:** Appropriately labels the data set with descriptive variable names.
6. **Creates** a __tidy data__ set with the average of each variable for each activity and each subject. 
    And stores the file in 'dataAggregation.txt'
