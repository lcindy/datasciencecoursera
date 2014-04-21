##########################################################################
#Getting and Cleaning Data Project
#Github: lcindy
##########################################################################
#Read feature
features<-read.table("./project/UCI HAR Dataset/features.txt")
features<-rbind(data.frame(V1="-1",V2="subject"),data.frame(V1="0",V2="activity"),features)

#Read Activity
activity<-read.table("./project/UCI HAR Dataset/activity_labels.txt")
#Read train set
filepath_X<-"./project/UCI HAR Dataset/train/X_train.txt"
data_X<-read.table(filepath_X)
filepath_subject<-"./project/UCI HAR Dataset/train/subject_train.txt"
data_sub<-read.table(filepath_subject)
filepath_y<-"./project/UCI HAR Dataset/train/y_train.txt"
data_y<-read.table(filepath_y)
data_train<-cbind(data_sub,data_y,data_X)
#Read test set
filepath_X<-"./project/UCI HAR Dataset/test/X_test.txt"
data_X<-read.table(filepath_X)
filepath_subject<-"./project/UCI HAR Dataset/test/subject_test.txt"
data_sub<-read.table(filepath_subject)
filepath_y<-"./project/UCI HAR Dataset/test/y_test.txt"
data_y<-read.table(filepath_y)
data_test<-cbind(data_sub,data_y,data_X)
#1.Merges the training and the test sets to create one data set.
mergeddata<-rbind(data_train,data_test)
#3.Uses descriptive activity names to name the activities in the data set
names(mergeddata)<-features[,"V2"]
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
use_index<-c(1,2,grep(glob2rx("*mean()"), features[,"V2"]),grep(glob2rx("*std()"), features[,"V2"]))
filtereddata<-mergeddata[,use_index]
#4.Appropriately labels the data set with descriptive activity names. 
filtereddata_new<-cbind(filtereddata[,1:2],filtereddata[,1],filtereddata[,3:dim(filtereddata)[2]])
colnames(filtereddata_new)[3]<-"activity_name"
#convert to numeric
filtereddata_new[,2] <- as.numeric(gsub(",", "", as.character(filtereddata_new[,2])))
activity_list<-as.character(activity[,2])
for (i in 1:nrow(filtereddata_new)){
   if (filtereddata_new[i,2] == 1){filtereddata_new[i,3] = activity_list[1]}
   else if (filtereddata_new[i,2] == 2){filtereddata_new[i,3] = activity_list[2]}
   else if (filtereddata_new[i,2] == 3){filtereddata_new[i,3] = activity_list[3]}
   else if (filtereddata_new[i,2] == 4){filtereddata_new[i,3] = activity_list[4]}
   else if (filtereddata_new[i,2] == 5){filtereddata_new[i,3] = activity_list[5]}
   else if (filtereddata_new[i,2] == 6){filtereddata_new[i,3] = activity_list[6]}
}


#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
RunAnalysis<-function(dataset,subject_id){
    results<-vector()
    use_data<-(dataset[dataset[,1]==subject_id,])   
    freq<-length(names(use_data))
    for (i in 4:freq){  
        results<-cbind(results,tapply(use_data[,i],use_data[,3],mean))
    }
    colnames(results)<-names(use_data)[4:freq]
    results<-cbind(rep(subject_id,times=(freq-3)),results)
    colnames(results)[1]<-"Subject_ID"
    results    
}

FinalResults<-RunAnalysis(filtereddata_new,1)
for ( i in 2:30){
  FinalResults<-rbind(FinalResults,RunAnalysis(filtereddata_new,i))
}
FinalResults
write.table(FinalResults, file="./project/UCI HAR Dataset/FinalResults.txt") 
