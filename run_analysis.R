
# read data from file
trainData <- read.table("train//X_train.txt")
testData <- read.table("test//X_test.txt")
data <- rbind(testData, trainData)

# remove unused data to save memory
rm(testData)
rm(trainData)

meanData <- rowMeans(data)
sdData <- apply(data, 1, sd)

# column bind to get new data of mean ad sd of every row,
newData <- cbind(meanData, sdData)

# get activity name-code
activity_names <- read.table("activity_labels.txt")
names(activity_names) <- c("code", "name")

# read activity label of the test and train data
trainLabel <- read.table("train//y_train.txt")
names(trainLabel) <- c("code")

testLabel <- read.table("test//y_test.txt")
names(testLabel) <- c("code")
labels <- rbind(testLabel, trainLabel)

# column bind the mean/sd data with its label data
newData <- cbind(newData, labels)

# merge with label activity names
newData <- merge(newData, activity_names, by = "code", sort = FALSE)

# get subjects info
test_subjects <- read.table("test//subject_test.txt")
train_subjects <- read.table("train//subject_train.txt")
subjects <- rbind(test_subjects, train_subjects)
names(subjects) <- c("subject")

# column bine subjects with his/her data
newData <- cbind(newData, subjects)

# using dplyr lib
library(dplyr)


#group data by subject and activity name
grp_data <- group_by(newData, subject, code)

avg_all <- summarise(grp_data, mean = mean(meanData), SD = mean(sdData))

# save into file
write.table(avg_all, row.name = FALSE, file="avg_sum_data.txt")


