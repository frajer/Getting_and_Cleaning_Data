## Library for downloading and reading the data for the Course Project
## for Getting and Cleaning Data

DownloadData <- function()
{
    ## Download (if necessary) and reading the data for the assignment
    if(!file.exists("./UCI HAR Dataset"))
    {
        print("Data will be downloaded and unziped...")
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, "./Dataset.zip", method = "curl")
        unzip("./Dataset.zip")
    }
    else
    {
        print("Data was already downloaded ...")
    }
    
    return()
}
