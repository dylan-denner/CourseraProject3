#
#
#
#
#


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
### Merging data into one dataset with tests first then train

mereged_labels_table <- data.frame(matrix(ncol = 1, nrow = 10299))
mereged_subject_ID_table <- data.frame(matrix(ncol = 1, nrow = 10299))
mereged_data_table <- data.frame(matrix(ncol = 561, nrow = 10299))

for (i in 1:2947){
  mereged_labels_table[i,1] = test_labels_table[i,1]
  mereged_subject_ID_table[i,1] = test_subject_ID_table[i,1]
  for (j in 1:561){
    mereged_data_table[i,j] = test_data_table[i,j]
  }
}

for (i in 2948:10299){
  mereged_labels_table[i,1] = train_labels_table[i-2947,1]
  mereged_subject_ID_table[i,1] = train_subject_ID_table[i-2947,1]
  for (j in 1:561){
    mereged_data_table[i,j] = test_data_table[i-2947,j]
  }
}




