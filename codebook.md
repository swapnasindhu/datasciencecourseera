
## Script description

# File run_analysis.R:

This file contains 5 functions:
        
 * download_data(wd, needed_files): This function downloads the data file and decompress it only if necessary to save resources
        Arguments:      wd = working directory
                        needed_files: list with files needed to resolve the assignment. This is used to evaluate if is neccesary to reload data from source or nottem
                        
 * merge_test_train(): This function reads data from files and create a merged dataset with test and train info.

 * extract_mean_and_std_values(data_comp=NULL): This function extracts data from mean and deviation columns of the dataset
        Arguments: data_comp = working dataset, if is not pressent the function reloads data from file.
        
 * set_activity_name(data_comp=NULL): This fuction sets names to activities in dataset
        Arguments: data_comp = working dataset, if is not pressent the function reloads data from file.                                

 * create_tidy_datase(data_comp=NULL): This function creates a new tidy dataset with averages for each variable by subject and activity
        Arguments: data_comp = working dataset, if is not pressent the function reloads data from file.                                
        The argument must be the complete dataset with labels obteined from extract_mean_and_std_value() 
        
 * run_analysis(): MAin function that uses all the above and creates the results datasets
        
        
 ## TEST
 For testing update de work directory value (variable wd in function run_analysis), source the run_analysis.R file and 
        run the function run_analysis().

The script prints some info about the datasets created. Also you can see the main dataset using:
> data <- run_analysis()

or the secondary using:
> setwd("data/UCI HAR Dataset")
> data_tidy <- create_tidy_dataset()


MAIN DATASET COLS:

"subject": id subject using the smartphone in study
"activitylabel": class from activity
"activityname": name of performing activity

MESUREMENTS:

"tBodyAccmeanX"               
"tBodyAccmeanY"                "tBodyAccmeanZ"                "tBodyAccstdX"                
"tBodyAccstdY"                 "tBodyAccstdZ"                 "tGravityAccmeanX"            
"tGravityAccmeanY"             "tGravityAccmeanZ"             "tGravityAccstdX"             
"tGravityAccstdY"              "tGravityAccstdZ"              "tBodyAccJerkmeanX"           
"tBodyAccJerkmeanY"            "tBodyAccJerkmeanZ"            "tBodyAccJerkstdX"            
"tBodyAccJerkstdY"             "tBodyAccJerkstdZ"             "tBodyGyromeanX"              
"tBodyGyromeanY"               "tBodyGyromeanZ"               "tBodyGyrostdX"               
"tBodyGyrostdY"                "tBodyGyrostdZ"                "tBodyGyroJerkmeanX"          
"tBodyGyroJerkmeanY"           "tBodyGyroJerkmeanZ"           "tBodyGyroJerkstdX"           
"tBodyGyroJerkstdY"            "tBodyGyroJerkstdZ"            "tBodyAccMagmean"             
"tBodyAccMagstd"               "tGravityAccMagmean"           "tGravityAccMagstd"           
"tBodyAccJerkMagmean"          "tBodyAccJerkMagstd"           "tBodyGyroMagmean"            
"tBodyGyroMagstd"              "tBodyGyroJerkMagmean"         "tBodyGyroJerkMagstd"         
"fBodyAccmeanX"                "fBodyAccmeanY"                "fBodyAccmeanZ"               
"fBodyAccstdX"                 "fBodyAccstdY"                 "fBodyAccstdZ"                
"fBodyAccmeanFreqX"            "fBodyAccmeanFreqY"            "fBodyAccmeanFreqZ"           
"fBodyAccJerkmeanX"            "fBodyAccJerkmeanY"            "fBodyAccJerkmeanZ"           
"fBodyAccJerkstdX"             "fBodyAccJerkstdY"             "fBodyAccJerkstdZ"            
"fBodyAccJerkmeanFreqX"        "fBodyAccJerkmeanFreqY"        "fBodyAccJerkmeanFreqZ"       
"fBodyGyromeanX"               "fBodyGyromeanY"               "fBodyGyromeanZ"              
"fBodyGyrostdX"                "fBodyGyrostdY"                "fBodyGyrostdZ"               
"fBodyGyromeanFreqX"           "fBodyGyromeanFreqY"           "fBodyGyromeanFreqZ"          
"fBodyAccMagmean"              "fBodyAccMagstd"               "fBodyAccMagmeanFreq"         
"fBodyBodyAccJerkMagmean"      "fBodyBodyAccJerkMagstd"       "fBodyBodyAccJerkMagmeanFreq" 
"fBodyBodyGyroMagmean"         "fBodyBodyGyroMagstd"          "fBodyBodyGyroMagmeanFreq"    
"fBodyBodyGyroJerkMagmean"     "fBodyBodyGyroJerkMagstd"      "fBodyBodyGyroJerkMagmeanFreq"
                 
SECONDARY DATASET:

IDEM main dataset, but with means for each subject-activity combination.