#Code Book for Course Project:  Tidy Dataset#
##Raw Data files used as input##
* features.txt
* activity_labels.txt
* train
  * X_train.txt
  * y_train.txt
  * subject_train.txt
* test
  * X_test.txt
  * y_test.txt
  * subject_test.txt
  
##Datasets created using script run_analysis.R##
* features (48 obs of 2 variables)
* activities (6 obs of 2 variables)
* combinedData (10299 obs of 51 variables)
* testData (2947 obs of 50 variables)
* trainingData (7352 obs of 50 variables)
* TidyData (180 obs of 50 variables)

##Variable and data transformations performed using script run_analysis.R##
* Features dataset variable names were created as feature_id and feature_name
* Features dataset was subset to include only mean and standard deviation data
* Activities dataset variable names were created as activity_id and activity_name
* The Dataset function reads in a dataset (in this case the Test and Training data) and applies variables names for feature, activity and subject_id, then merges the information together using cbind
* TrainingData and TestData are merged using rbind into a combinedData set
* CombinedData is then aggregated at the subject_id and activity_name and the mean is calculated for variable.  This dataset is now called TidyData
* TidyData is written to a file called 'tidydata.txt'
