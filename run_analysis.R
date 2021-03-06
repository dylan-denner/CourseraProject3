# Dylan Denner
# 9/12/2020
#
# Coursera Data Science
# Getting & Cleaning Data Project
# 
##############################################################
library(dplyr)

##############################################################
#### TEST DATA

test_subject_ID_file_path <- "./UCI_HAR_Dataset/test/subject_test.txt"
test_subject_ID_table <- read.table(test_subject_ID_file_path, header = FALSE, sep = "", dec = ".")

test_labels_file_path <- "./UCI_HAR_Dataset/test/y_test.txt"
test_labels_table <- read.delim(test_labels_file_path, header = FALSE, sep = "", dec = ".")

test_data_file_path <- "./UCI_HAR_Dataset/test/X_test.txt"
test_data_table <- read.delim(test_data_file_path, header = FALSE, sep = "", dec = ".")

##############################################################
### TRAIN DATA

train_subject_ID_file_path <- "./UCI_HAR_Dataset/train/subject_train.txt"
train_subject_ID_table <- read.table(train_subject_ID_file_path, header = FALSE, sep = "", dec = ".")

train_labels_file_path <- "./UCI_HAR_Dataset/train/y_train.txt"
train_labels_table <- read.delim(train_labels_file_path, header = FALSE, sep = "", dec = ".")

train_data_file_path <- "./UCI_HAR_Dataset/train/X_train.txt"
train_data_table <- read.delim(train_data_file_path, header = FALSE, sep = "", dec = ".")

###################################################
### Features File

features_file_path <- "./UCI_HAR_Dataset/features.txt"
features_data_table <- read.table(features_file_path, header = FALSE, col.names = c("#","Functions"))

###################################################
### Merging data into one dataset with tests first then train

merged_subject_ID_table <- rbind(test_subject_ID_table, train_subject_ID_table)
merged_labels_table <- rbind(test_labels_table, train_labels_table)
merged_data_table <- rbind(test_data_table, train_data_table)
merged_dataset <- cbind(merged_subject_ID_table, merged_labels_table, merged_data_table)

##############################################################
### Labeling Data Set

colnames(merged_dataset) <- c("Volunteer #","Activity Name", features_data_table$Functions)

merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 1] <- "Walking"
merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 2] <- "Walking Upstairs"
merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 3] <- "Walking Downstairs"
merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 4] <- "Sitting"
merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 5] <- "Standing"
merged_dataset$`Activity Name`[merged_dataset$`Activity Name` == 6] <- "Laying"

names(merged_dataset) <- gsub("gravity", "Gravity", names(merged_dataset))
names(merged_dataset) <- gsub("Gyro", "Gyroscope", names(merged_dataset))
names(merged_dataset) <- gsub("BodyBody", "Body", names(merged_dataset))
names(merged_dataset) <- gsub("angle", "Angle", names(merged_dataset))
names(merged_dataset) <- gsub("Mag", "Magnitude", names(merged_dataset))
names(merged_dataset) <- gsub("^t", "Time", names(merged_dataset))
names(merged_dataset) <- gsub("-std()", "STD", names(merged_dataset), ignore.case = TRUE)
names(merged_dataset) <- gsub("Acc", "Accelerometer", names(merged_dataset))
names(merged_dataset) <- gsub("tBody", "TimeBody", names(merged_dataset))
names(merged_dataset) <- gsub("-mean()", "Mean", names(merged_dataset), ignore.case = TRUE)
names(merged_dataset) <- gsub("^f", "Frequency", names(merged_dataset))
names(merged_dataset) <- gsub("-freq()", "Frequency", names(merged_dataset), ignore.case = TRUE)


##############################################################
### Extracting the mean and std

mean_std_dataset <- select(merged_dataset, "Volunteer #", "Activity Name", contains("Mean"), contains("STD"))

##############################################################
### Creating second dataset

temp_dataset <- 
  group_by(mean_std_dataset, mean_std_dataset$`Volunteer #`, mean_std_dataset$`Activity Name`) %>%
  summarise_all(funs(mean))

final_dataset <- subset(temp_dataset, select = -c(3,4))
names(final_dataset)[1] <- "Volunteer #"
names(final_dataset)[2] <- "Activity Name"

write.table(final_dataset, file = "final_dataset.txt", row.name=FALSE)