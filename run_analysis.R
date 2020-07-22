#downloading and unzipping
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", './UCI HAR Dataset.zip', mode = 'wb')
unzip("UCI HAR Dataset.zip", exdir = getwd())

#assigning data frames
features <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
#test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
#train data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")

#Merging training and test sets
X <- rbind(XTrain, XTest)
y <- rbind(yTrain, yTest)
subject <- rbind(subjectTrain, subjectTest)

#Extract only mean and SD
allData_mean_std <- allData[, grep("-(mean|std)\\(\\)", features[, 2])]
names(allData_mean_std) <- features[grep("-(mean|std)\\(\\)", features[, 2]), 2] 

#Use descriptive activity names to name activities and labeling data set with descriptive variables
y[,1] <- activity[y[,1],2] 
names(y) <- "Activity"
names(subject) <- "Subject"

cleanData <- cbind(subject, y, allData_mean_std)

#create tiny data set with avg. of each variable for each activity and subject
TinyData <- aggregate(. ~Subject + Activity, cleanData, mean)
TinyData <- TinyData[order(TinyData$Subject, TinyData$Activity), ]