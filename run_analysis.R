
library(data.table)
library(reshape2)

## This function downloads the data file and decompress it only if necessary to save resources

download_data <- function(wd="", needed_files) {
        
        
        # Set working directory
        if(wd!="") setwd(wd)
        
        # Create data directory
        if(!dir.exists("data")) dir.create("data")
        
        # download data file if not already downloaded
        zip_file <- "data/data_file.zip"
        if(!file.exists(zip_file)) {
                url_file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
                download.file(url_file, destfile = zip_file)
        }
        
        #unzip the file
        band_exists <- TRUE
        for(i in 1:length(needed_files))  { 
                band_exists <- file.exists(needed_files[i])
                if(band_exists) print(paste(needed_files[i], " - OK")) else { print("UNZIP files"); break}
        }
        if(!band_exists){
                unzip(zip_file, exdir = "data")
        }
        
}

# This function reads data from files and create a merged dataset with test and train info.

merge_test_train <- function() {
        
        #LOAD DATASETS
        
        
        # TEST Data
        
        subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
        setnames(subject_test, "V1", "Subject")
        
        obs_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
        
        label_test <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
        setnames(label_test, "V1", "activitylabel")
        # Merge all data in one dataset for TEST
        data_test <- cbind(subject_test, obs_test, label_test)
        
        # TRAIN Data
        
        subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
        setnames(subject_train, "V1", "Subject")
        
        obs_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
        
        label_train <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
        setnames(label_train, "V1", "activitylabel")
        # Merge all data in one dataset for TRAIN
        data_train <- cbind(subject_train, obs_train, label_train)
        
        # MERGE TEST AND TRAIN DATA
        complete_data <- rbind(data_test, data_train)
        complete_data
}

# This function extracts data from mean and deviation columns of the dataset

extract_mean_and_std_values <- function(data_comp=NULL){
        
        # get the complete dataset if not created
        if(is.null(data_comp)) data_comp <- merge_test_train()
        
        # read features data
        feat <- read.table("data/UCI HAR Dataset/features.txt")
        # Add code column to dataset
        fcode <- paste0("V", feat$V1)
        feat <- cbind(feat, fcode)
        
        # Put detailled names to columns 
        setnames(data_comp, as.character(feat$fcode), make.names(feat$V2))
        
        # subset results to columns with text mean or std 
        cd_mean_std <- data_comp[, grepl("Subject|activitylabel|mean|std", names(data_comp))]
        setnames(cd_mean_std, names(cd_mean_std), gsub("[.]", "", names(cd_mean_std)))
        cd_mean_std
}


# This fuction sets names to activities in dataset

set_activity_names <- function(data_comp=NULL){
        
        # get the complete dataset if not created
        if(is.null(data_comp)) data_comp <- extract_mean_and_std_values()
                        
        # Read activity names from file
        activityNames <- read.table("data/UCI HAR Dataset/activity_labels.txt")
        setnames(activityNames, names(activityNames), c("activitylabel", "activityname"))
        
        # Merge values in complete dataset
        data_comp <- merge(data_comp, activityNames, by = "activitylabel", all.x = F)  
        data_comp
}


# This function creates a new tidy dataset with averages for each variable by subject and activity
# The argument must be the complete dataset with labels obteined from set_variable_names()

create_tidy_dataset <- function(data_comp=NULL){
        
        # get the complete dataset if not created
        if(is.null(data_comp)) data_comp <- extract_mean_and_std_values()
        dc <- data_comp
        aux <- melt(dc, id=c("Subject","activitylabel"))
        tidy <- dcast(aux, Subject+activitylabel ~ variable, mean)
        write.csv(tidy, "tidy.csv", row.names=FALSE)
        write.table(tidy, "tidy.txt", row.names=FALSE)
        tidy
        
}


run_analysis <- function(){
        
        # download data files if necessary
        wd = ""
        
        needed_files = c("data/UCI HAR Dataset/test/subject_test.txt","data/UCI HAR Dataset/train/subject_train.txt",
                         "data/UCI HAR Dataset/test/X_test.txt","data/UCI HAR Dataset/train/X_train.txt",
                         "data/UCI HAR Dataset/test/y_test.txt","data/UCI HAR Dataset/train/y_train.txt",
                         "data/UCI HAR Dataset/activity_labels.txt","data/UCI HAR Dataset/features.txt")
        download_data(wd, needed_files)
        
        
        # Get data merging both dataframes TEST and TRAIN
        complete_data <- merge_test_train();
        
        # Extract mean and deviations values
        complete_data <- extract_mean_and_std_values(complete_data)
        aux_data <- complete_data
        
        # Set activities names
        complete_data <- set_activity_names(complete_data)
        
        # Create a new tidy dataset with averages for each variable by subject and activity 
        tidy_data <- create_tidy_dataset(aux_data)
        
        print(str(complete_data))
        print(head(tidy_data))
        
        complete_data
        
}