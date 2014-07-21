README
======

This file has two parts. First one describes how the "run_analysis.R" script works. And the second part is the "Code book" describing variables from the same script.

Script description
------------------

Script "run_analysis.R" is composed of steps. The begining of each step is marked as comment in source code of script. So the steps in this documents refers to the same steps in script code.

* **Step 1: Downloading files:** In first step the function DownloadData() from DownloadData.R file downloads the projects data.
* **Step 2: Reading data from files:** In this step we load the data from files to variables. For the meaning of the specific variable refer to the Code Book.
* **Step 3: Merging the training and the test sets** to create one data set as required for the first task.
* **Step 4: Assigning descriptive variable names** to dataset column names as required in fourth task.
* **Step 5: Changing activities to descriptive activity names** (Task 3)
* **Step 6: Assigning descriptive variable names for the Activity and Subject (first and second) column** (Task 4)
* **Step 7: Extracting only the measurements on the mean and standard deviation for each measurement** (as required in second task)
    * Function *extracted measurements* takes for argument a column in dataset with measurements, and return the same column with measurements on the mean and standard deviation and NAs instead other values
    * Function *extract data* apply previous function to entire data set
    * Then we split data to groups with same activity and subject, and within this groups we remove NAs with function *remove_nas*
    * Finally (for the second task) we bind groups without NAs back together
* **Step 7: Creating independent tidy data set with the average of each variable for each activity and each subject** as is required for the last task
* **Step 8:** And for the end **writing output dataset** for upload on the course project pag

Code book
---------

* **train_data** - data loaded from the file with training data; data frame, 7352 observations, 561 variables
* **test_data** - data loaded from the file with test data; data frame, 2947 observations, 561 variables
* **activity_labels_train** - data loaded from the file with activity labels for training data; data frame, 7352 observations, 1 variable (int - activity label index)
* **activity_labels_test** - data loaded from the file with activity labels for test data; data frame, 2947 observations, 1 variable (int - activities index)
* **subject_train** - data loaded from the file with subjects for training data; data frame, 7352 observations, 1 variable (int - subject index)
* **subject_test** - data loaded from the file with subjects for test data; data frame, 2947 observations, 1 variable (int - subject index)
* **activities** - index of activities loaded from the file with activity labels; data frame, 6 observations, 2 variables (int -  activities index, Factor with 6 levels: LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS" - activity label)
* **features** - index of features loaded from the file with features names; data frame, 561 observations, 2 variables (int -  features index, Factor with 477 levels - measurement description)

* **data** - merged train_data and test_data; data frame, 10299 observations, 563 variables
* **activity_labels** - merged activity_labels_train and activity_labels_test; data frame, 10299 observations, 1 variable (int - activity label index)
* **subjects** - merged subject_train and subject_test; data frame, 10299 observations, 1 variable (int - subject index)

* **extracted_data** - data with only the measurements on the mean and standard deviation for each measurement and NAs instead other values; data frame, 10299 observations, 563 variables
* **grouped** - list of  data frames with same activity and subject, list with 180 elements, each element is data frame with 563 variables
* **extracted** - extracted data with only the measurements on the mean and standard deviation for each measurement; data frame, 749 observations, 563 variables

* **averages** - tidy data set with the average of each variable for each activity and each subject; data frame, 180 observations, 563 variables

For detailed description of variables(features) and activity labels consult original documentation on this link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones





