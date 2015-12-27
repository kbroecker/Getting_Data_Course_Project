# Retrieve raw data and unzip files
if (!file.exists('getdata-projectfiles-UCI HAR Dataset.zip')) {
  download.file(
    'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
    method='curl',
    destfile='getdata-projectfiles-UCI HAR Dataset.zip'
  )
}
if (!file.exists('UCI HAR Dataset')) {
  unzip('getdata-projectfiles-UCI HAR Dataset.zip')
}


# Preparing the data features
features <- read.table('UCI HAR Dataset/features.txt', header=FALSE)
names(features) <- c('feature_id', 'feature_name')
features <- subset(features, grepl('-(mean|std)\\(\\)-(X|Y|Z)', feature_name))
features$feature_name <- gsub('\\(\\)', '', features$feature_name)
features$feature_name <- gsub('-std', '-stdev', features$feature_name)

# Identify the activity types
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
names(activities) <- c('activity_id', 'activity_name')

#Function to import and prepare the datasets with features and activities information, then merge them with the subjects
DataSet <- function (dataSetName) {
  dirPrefix <- paste('UCI HAR Dataset/', dataSetName, sep='')
  
  # Read the main data and apply features
  main <- read.table(paste(dirPrefix, '/X_', dataSetName, '.txt', sep=''), header=FALSE)
  main <- main[, features$feature_id]
  names(main) <- features$feature_name
  
  # Read the subjects 
  subjects <- read.table(paste(dirPrefix, '/subject_', dataSetName, '.txt', sep=''), header=FALSE)
  names(subjects) <- c('subject_id')
  
  # Read the activities
  activities <- read.table(paste(dirPrefix, '/y_', dataSetName, '.txt', sep=''), header=FALSE)
  names(activities) <- c('activity_id')
  
  # Merge subject, activities and main data 
  cbind(subjects, activities, main)
}

trainingData <- DataSet('train')
testData <- DataSet('test')


#Merge Test and Training datasets and combine with activities
combinedData <- rbind(trainingData, testData)
combinedData <- merge(activities, combinedData, by.x=c('activity_id'), by.y=c('activity_id'))


#Create Tidy Dataset grouping by subject and activity then calculating the mean
TidyData <- aggregate(
  combinedData[, 4:ncol(combinedData)],
  by=list(
    subject=combinedData$subject_id,
    activity=combinedData$activity_name
  ),
  mean,
  length.warning=FALSE
)
names(TidyData)[3:ncol(TidyData)] <- paste0(names(TidyData)[3:ncol(TidyData)], '-avg')

# Save TidyData as a txt file
write.table(TidyData, 'tidydata.txt', row.names=FALSE)


