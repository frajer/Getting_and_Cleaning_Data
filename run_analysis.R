#Step 1: Downloading files
source("DownloadData.R")
DownloadData()

#Step 2: Reading data from files
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE,sep="")
activity_labels_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE,sep=" ")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE,sep=" ")

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE,sep="")
activity_labels_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE,sep=" ")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE,sep=" ")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE,sep=" ")
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE,sep=" ")

#Step 3: Merging the training and the test sets 
#Task 1: Merges the training and the test sets to create one data set
data <- rbind(train_data,test_data)

#Step 4: Assigning descriptive variable names to dataset column names
#First part of Task 4: Appropriately labels the data set with descriptive variable names
colnames(data) <- features[,2]

#Step 5: Changing activities to descriptive activity names
#Task 3: Uses descriptive activity names to name the activities in the data set
activity_labels <- rbind(activity_labels_train,activity_labels_test)
subjects <- rbind(subject_train,subject_test)
data <- cbind(lapply(activity_labels,lab <-function(i){as.character(activities[i,2])}),subjects,data)

#Step 6: Assigning descriptive variable names for the Activity and Subject (first and second) column
#Second part of Task 4: Appropriately labels the data set with descriptive variable names
colnames(data)[1] <- "Activity"
colnames(data)[2] <- "Subject"

#Step 7: Extracting only the measurements on the mean and standard deviation for each measurement
#Task 2: Extracts only the measurements on the mean and standard deviation for each measurement
extracted_measurements <- function(measurement){
    interval <- c(mean(measurement)-sd(measurement),mean(measurement)+sd(measurement))
    is.between <- function(x){
        ans = NA
        if (x >= interval[1] & x <= interval[2]) ans = x
        return(ans)
    }
    measurement <-sapply(measurement,is.between)
    return(measurement) 
}

extract_data <- function(data){
    extracted <- cbind(data[,c(1,2)],data.frame(unlist(apply(data[,c(-1,-2)],2,extracted_measurements))))
    return(extracted)
}

extracted_data <- extract_data(data)

#Split data to groups with same activity and subject
grouped <- split( extracted_data , f = extracted_data[,c(1,2)] )

remove_nas <- function(group){
    group <- as.matrix(apply(group,2,na.omit))
    group <- as.data.frame(sapply(group,function(x){x[1:length(group)]}))
    return(group[complete.cases(group),])
}

#Binding groups without NAs back
extracted <- data.frame()
for(i in 1:length(grouped)){
    extracted <- rbind(extracted,remove_nas(as.data.frame(grouped[i])))
}
colnames(extracted) <- colnames(extracted_data)

#Step 7: Creating independent tidy data set with the average of each variable for each activity and each subject
#Task 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
averages <-aggregate(data, by=list(data$Activity,data$Subject),FUN=mean, na.rm=TRUE)
averages <- averages[,c(-3,-4)]
colnames(averages)[1] <- "Activity"
colnames(averages)[2] <- "Subject"

#Step 8: Write output dataset for upload on the course project page
write.table(averages, "tidy_data_set.txt",sep=" ")