##Markdown file - Getting and Cleaning Data Project

###Read files 
*1. read and format features from "features.txt" 

*2. read and format activity from "activity_labels.txt" 

*3. read and format train data from "X_train.txt","subject_train.txt" and "y_train.txt"

*4. read and format train data from "X_test.txt","subject_test.txt" and "y_test.txt"
###Merge train and test data, complete part 1) of project
*1.Merges the training and the test sets to create one data set.
###Rename Variables, complete part 3) 
*#3.Uses descriptive activity names to name the activities in the data set
###Extract mean() and std() from dataset, complete part 2)
*2.Extracts only the measurements on the mean and standard deviation for each measurement. 
###Add a column with detailed activity labels, complete part 4)
*4.Appropriately labels the data set with descriptive activity names. 
###create function RunAnalysis and store results in FinalResults matrix, write out FinalResult.txt
###complete part 5)
*5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###List of Variables
*features: store features from features.txt

*activity: store features from "activity_labels.txt" 

*filepath_X,filepath_subject,filepath_y: file paths

*data_X,data_sub,data_y: intermediate variables to store data from txt files

*data_train,data_test: dataset after combining data_X,data_sub and data_y

*mergeddata: merged train data and test data

*use_index: index for mean(),std() 

*filtereddata: cleaned data, include columns with mean() and std() only

*filtereddata_new: adding activity labels

*activity_list:activity lables in list format

*RunAnalysis function: calculated mean of each variable for each activity and each subject. Results store the result, freq stores the total # of cols

*FinalResults: final answer to the project