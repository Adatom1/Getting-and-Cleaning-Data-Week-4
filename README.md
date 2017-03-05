# Getting-and-Cleaning-Data-Week-4
Repository for Coursera Getting and Cleaning Data Week 4 Project

Getting and Cleaning Data Course Projectless 
  The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
  The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related
  to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script 
  for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed 
  to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
  This repo explains how all of the scripts work and how they are connected.

  One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
  The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
  A full description is available at the site where the data was obtained:
        
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

  Here are the data for the project:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

  You should create one R script called run_analysis.R that does the following.
  1 Merges the training and the test sets to create one data set.
  2 Extracts only the measurements on the mean and standard deviation for each measurement.
  3 Uses descriptive activity names to name the activities in the data set
  4 Appropriately labels the data set with descriptive variable names.
  5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 Check to see if the file exists and if not create it 


 store the location of the zipped data in a variable called URL1


 Download teh file from the URL and place it in the data directory and name the file df.zip


 Unzip the files from df.zip to the same directory the df.zip was stored in.  Overwrite enabled to ensure we always have the most recent
 data files when we run the script


 Based on the readme.txt, instructions and the discussion board for this week's assignment we know we need to use the following files:
      Features
              X_test.txt
              X_train.txt
      Activity
              Y_test.txt
              Y_train.txt
      Subject
              subject_text.txt
              subject_train.txt
      features.txt
      activity_labels.txt

 The files of interest for this project are in the "UCI HAR Dataset" folder that was unzipped above
 Creat a variable called file_path to point to the "UCI HAR Dataset" folder in the week4 directory


 Feature Data Read
 Read data from file X_test.txt and store it into variable dFTst (data Feature Test)
 Read data from file X_train.txt and store it into variable dFTrn (data Feature Train)



 Feature Names Read
 Read data from file features.txt and store it in variable dFName (data Feature Name)



 Activity Data Read
 Read data from file Y_test.txt and store it into variable dATst (data Activity Test)
 Read data from file Y_train.txt and store it into variable dATrn (data Activity Train)



 Activity Labels Read
 Read data from file activity_labels.txt and store it in variable dALable (data Activity Label)


 Subject Data Read
 Read data from file subject_test.txt and store it into variable dSst (data Activity Test)
 Read data from file subject_train.txt and store it into variable dSTrn (data Activity Train)



 Create a single data set from the files read above by binding the rows of the train and test data for each: Feature, Activity, and Subject
 dF will hold Data Feature
 dA will hold Data Activity
 dS will hold Data Subject



 Add names to the single data sets created above


 Combine columns to get one complete data set wtih column names 
 Combine data for Subject and Activity and store in dSA (data Subject Activity)



 Combine data for Features and new table dSA to generate final data set and store it in a variable called data
 This gives us a complete data set to work with.



 We now need to generate a subset "data" where items with mean() and std() are present but not other data.
 First attempt was incorrect because I used grep("mean|std", dFName[,2]) had to include () and learned the importance of escape characters




 Generate a new data set called data1 where we select on items with mean() and std() in the dFName



 Add the activity labels in place of the activity factors to make the data more readable




 Time to add descriptive names to the data1 data set.
 After looking at the data in RStudio we see opportunities to make the following improvements:
 Replace BodyBody and replace with Body
 Replac Acc with Acceleration
 Replace t with time
 replace f with frequency
 replace Mag with Magnitude



  This ends the first portion of the project

 Now satisfy section 5
 Need dplyr so load it to the library



  Prepare the tidy data with mean
  Create variable data1_mean from data1 where we group data1 by subject and activity then summarise by mean


 write the result to a file


 end
