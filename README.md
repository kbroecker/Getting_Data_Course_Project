# Getting_Data_Course_Project
This repository contains my work for the Coursera Getting and Cleaning Data Course Project.  This includes the run_analysis.R script which opens and transforms the raw data into a tidy dataset.  Also included is a Code Book markdown file to define the variables and all transformations performed by run_analysis.R.
##Script:  run_analysis.R
This script retrieves the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzips the file.  Contained in the files are the testing and training datasets, activity labels, features information and a README.txt file.  Addtional Inertial Signal files were included but not used in this exercise or script.  The script then prepares the features data by subsetting to just the mean and standarad deviation observations.  Next the activity data is identified to each activity_id and activity_name.  Then the main data is read in and the features information applied to it.  Finally, the subjects, activities and main datasets are merged together using cbind.  After both the training and testing datasets have been prepared as described above, they are merged together as one combined dataset.  The combined dataset is "tidied" up by aggregating the data by subject_id and activity_name and the mean calculated.  

The output of the script is written to the file "tidydata.txt".


