The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone 
(Samsung Galaxy S II) on the waist. 


Attribute Information

For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.

Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located in and assign column names

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

Section 2. Extract only the measurements on the mean and standard deviation for each measurement.

Create a Mean_std Data set which will be the subset of the values, that contains the column names, mean and std

Section 3. Use descriptive activity names to name the activities in the data set

Merge data subset with the activity table to inlude the activity names

Section 4. Appropriately label the data set with descriptive activity names.

Use gsub function for pattern replacement to clean up the data labels.

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
create a data set with the average of each variable by Subject ID and Activity ID.
 
