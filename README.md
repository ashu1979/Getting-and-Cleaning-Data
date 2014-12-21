# Getting and cleaning data

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Files in this repo
* README.md -- Explains about the repository
* CodeBook.md -- codebook describing variables, the data and transformations
* run_analysis.R -- R code to generate desired tidy data set.

## R script Description
You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## run_analysis.R
It follows the goals step by step.

* Step 1:
  * Read all the test and training files: y_*.txt, subject_*.txt and X_*.txt.
  * Change the column names.
  * Combine the files to a data table in the form of subjects, labels, the rest of the data.
  * merge the above data tables to a single data table named "data".

* Step 2:
  * Read the features from features.txt and filter it to only leave features that are either means ("mean()") or standard deviations ("std()").
  * Change the column names.
  * Add a new column "featureCode" for later use to match the measurements from data.

* Step 3:
  * Read the activity labels from activity_labels.txt, change the column names and replace the numbers with the text in data object.

* Step 4:
  * Merge the data and activity objects to assign the name of the activity to the data.
  * Subset the data by specifying required set of column.
  * Melt the data frame to transpose the measurements variables.
  * Merge the data and features to get renamed the variable in descriptive form.
  
* Step 5:
  * Create a new data frame by finding the mean for each combination of subject and activity. This done by `dcast` function from reshape2 library.
  
* Final step:
  * Write the new tidy data set into a text file called tidyData.txt in current working directory.