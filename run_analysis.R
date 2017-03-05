##  Getting and Cleaning Data Course Projectless 
##  The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
##  The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related
##  to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script 
##  for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed 
##  to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
##  This repo explains how all of the scripts work and how they are connected.

##  One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
##  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
##  The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
##  A full description is available at the site where the data was obtained:
        
##  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##  Here are the data for the project:

##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##  You should create one R script called run_analysis.R that does the following.
##  1 Merges the training and the test sets to create one data set.
##  2 Extracts only the measurements on the mean and standard deviation for each measurement.
##  3 Uses descriptive activity names to name the activities in the data set
##  4 Appropriately labels the data set with descriptive variable names.
##  5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Check to see if the file exists and if not create it 
if(!file.exists("./week4")){dir.create("./week4")}

## store the location of the zipped data in a variable called URL1
URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download teh file from the URL and place it in the data directory and name the file df.zip
download.file(URL1,destfile="./week4/df.zip")

## Unzip the files from df.zip to the same directory the df.zip was stored in.  Overwrite enabled to ensure we always have the most recent
## data files when we run the script
unzip(zipfile="./week4/df.zip",exdir="./week4", overwrite = TRUE)

## Based on the readme.txt, instructions and the discussion board for this week's assignment we know we need to use the following files:
##      Features
##              X_test.txt
##              X_train.txt
##      Activity
##              Y_test.txt
##              Y_train.txt
##      Subject
##              subject_text.txt
##              subject_train.txt
##      features.txt
##      activity_labels.txt

## The files of interest for this project are in the "UCI HAR Dataset" folder that was unzipped above
## Creat a variable called file_path to point to the "UCI HAR Dataset" folder in the week4 directory

path <- file.path("./week4", "UCI HAR Dataset")

## Feature Data Read
## Read data from file X_test.txt and store it into variable dFTst (data Feature Test)
## Read data from file X_train.txt and store it into variable dFTrn (data Feature Train)

dFTst  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
dFTrn  <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

## Feature Names Read
## Read data from file features.txt and store it in variable dFName (data Feature Name)

dFName <- read.table(file.path(path, "features.txt"),head=FALSE)

## Activity Data Read
## Read data from file Y_test.txt and store it into variable dATst (data Activity Test)
## Read data from file Y_train.txt and store it into variable dATrn (data Activity Train)

dATst  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
dATrn  <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

## Activity Labels Read
## Read data from file activity_labels.txt and store it in variable dALable (data Activity Label)
dALabel <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
colnames(dALabel) <- c('activityId','activityType')

## Subject Data Read
## Read data from file subject_test.txt and store it into variable dSst (data Activity Test)
## Read data from file subject_train.txt and store it into variable dSTrn (data Activity Train)

dSTst  <- read.table(file.path(path, "test" , "subject_test.txt" ),header = FALSE)
dSTrn  <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)

## Create a single data set from the files read above by binding the rows of the train and test data for each: Feature, Activity, and Subject
## dF will hold Data Feature
## dA will hold Data Activity
## dS will hold Data Subject

dF <- rbind(dFTrn, dFTst)
dA <- rbind(dATrn, dATst)
dS <- rbind(dSTrn, dSTst)

## Add names to the single data sets created above
names(dF)<- dFName[,2]
names(dA) <- c("activity")
names(dS) <- c("subject")

## Combine columns to get one complete data set wtih column names 
## Combine data for Subject and Activity and store in dSA (data Subject Activity)

dSA <- cbind(dS, dA)

## Combine data for Features and new table dSA to generate final data set and store it in a variable called data
## This gives us a complete data set to work with.

data <- cbind(dF, dSA)

## We now need to generate a subset "data" where items with mean() and std() are present but not other data.
## First attempt was incorrect because I used grep("mean|std", dFName[,2]) had to include () and learned the importance of escape characters


subdFName <- dFName[,2][grep("mean\\(\\)|std\\(\\)", dFName[,2])]

## Generate a new data set called data1 where we select on items with mean() and std() in the dFName

namesOfInterest <-c(as.character(subdFName), "subject", "activity" )
data1<-subset(data, select=namesOfInterest)

## Add the activity labels in place of the activity factors to make the data more readable

data1$activity <- factor(data$activity, labels = dALabel[,2])


## Time to add descriptive names to the data1 data set.
## After looking at the data in RStudio we see opportunities to make the following improvements:
## Replace BodyBody and replace with Body
## Replac Acc with Acceleration
## Replace t with time
## replace f with frequency
## replace Mag with Magnitude

names(data1) <- gsub("BodyBody", "Body", names(data1)) 
names(data1) <- gsub("Acc", "Accelerometer", names(data1))
names(data1) <- gsub("^t", "time", names(data1))
names(data1) <- gsub("^f", "frequency", names(data1))
names(data1) <- gsub("Mag", "Magnitude", names(data1))

##  This ends the first portion of the project

## Now satisfy section 5
## Need dplyr

library(dplyr)

##  Prepare the tidy data with mean
##  Create variable data1_mean from data1 where we group data1 by subject and activity then summarise by mean

data1_mean <- data1 %>% group_by(subject, activity) %>% summarise_each(funs(mean))


# write the result to a file
write.table(data1_mean, file="tidy_data.txt", append = FALSE, eol ="\n",  sep = " ", row.names = FALSE, qmethod = "double")

#end

