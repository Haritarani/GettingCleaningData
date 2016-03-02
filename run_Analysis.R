# Coursera Getting and cleaning data class
# Filename: run_analysis.R
# Author: Harita Rani
#You should create one R script called run_analysis.R that does the following.
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Merging the training and the test Data Sets

##Check the working directory
getwd()
#### setting the working Directory
setwd("C:/Users/hrani/Desktop/Data Science Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset")

#Read the data from the text files.

## Reading the features and activity files.

features <- read.table("./features.txt",header = FALSE,colClasses = c("character"))
activity_labels <- read.table("./activity_labels.txt",header=FALSE,col.names = c("ActivityId","Activity"))

## Reading Train Data
Subject_Train <- read.table("./train/subject_train.txt",header=FALSE,col.names = c("SubjectID"))
X_Train1<- read.table("./train/X_train.txt",header=FALSE,col.names = features[,2])
y_train <- read.table("./train/y_train.txt",header=FALSE,col.names = c("ActivityId"))

### Combining Training Data
Train_Data = cbind(y_train,Subject_Train,X_Train1)

## Reading Test Data
Subject_Test <- read.table("./test/subject_test.txt",header=FALSE,col.names = c("SubjectID"))
X_Test<- read.table("./test/X_test.txt",header=FALSE,col.names = features[,2])
y_test <- read.table("./test/y_test.txt",header=FALSE,col.names = c("ActivityId"))

### Combing Test Data
Test_Data = cbind(y_test,Subject_Test,X_Test)

#### 1: Merging Train and Test Data
Merged_Data <- rbind(Train_Data,Test_Data)

 ### Writing Tidy Data output to a Csv File
write.csv(Merged_Data,"TidyData.csv",row.names = TRUE)

####2.Extracts only the measurements on the mean and standard deviation for each measurement.
Mean_Std<-  Merged_Data[,grepl("mean|std|SubjectID|ActivityId", names(Merged_Data))]

####3.Uses descriptive activity names to name the activities in the data set
Mean_Std <- merge(Mean_Std,activity_labels,by = 'ActivityId',all.x = TRUE)


##### Writing the Output data to a csv file.####
write.csv(Mean_Std,"Activity.csv",row.names = TRUE)

####4.Appropriately labels the data set with descriptive variable names.
#### The Descriptive variable names are assigned on to the sub data set

names(Mean_Std) <- gsub('\\(|\\)',"",names(Mean_Std), perl = TRUE)
names(Mean_Std) <- make.names(names(Mean_Std))
names(Mean_Std) <- gsub('^t',"Time",names(Mean_Std))
names(Mean_Std) <- gsub('^f',"Frequency",names(Mean_Std))
names(Mean_Std) <- gsub('Acc',"Accelerometer",names(Mean_Std))
names(Mean_Std) <- gsub('GyroJerk',"AngularAcceleration",names(Mean_Std))
names(Mean_Std) <- gsub('Gyro',"AngularSpeed",names(Mean_Std))
names(Mean_Std) <- gsub('Mag',"Magnitude",names(Mean_Std))
names(Mean_Std) <- gsub('\\.mean',".Mean",names(Mean_Std))
names(Mean_Std) <- gsub('\\.std',".StandardDeviation",names(Mean_Std))
names(Mean_Std) <- gsub('Freq\\.',"Frequency.",names(Mean_Std))
names(Mean_Std) <- gsub('Freq$',"Frequency",names(Mean_Std))
names(Mean_Std) <- gsub("BodyBody", "Body", names(Mean_Std))
names(Mean_Std) <- gsub("([Gg]ravity)","Gravity",names(Mean_Std))
names(Mean_Std) <- gsub("AccMag","AccMagnitude",names(Mean_Std))
names(Mean_Std) <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",names(Mean_Std))
names(Mean_Std) <- gsub("JerkMag","JerkMagnitude",names(Mean_Std))
names(Mean_Std) <- gsub("GyroMag","GyroMagnitude",names(Mean_Std))

####5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###loading the library files

library(dplyr)
library(plyr)

## Calculating the mean of each column based on ActivityId and SubjectID
Mean_each_variable <- ddply(Mean_Std,c('ActivityId','SubjectID'),numcolwise(mean))

#Write the output to csv file.
write.csv(Mean_each_variable,file = "Average.csv",row.names = TRUE)
