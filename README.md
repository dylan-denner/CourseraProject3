==================================================================
# CourseraProject3
Course project for "Getting and Cleaning Data"
==================================================================
Dylan Denner
9/12/2020
==================================================================

run_analysis.R uses data from the Human Activity Recognition Using Smartphones Dataset (version 1.0) to create a tidy dataset that shows the averages for each feature measurement for each volunter in the study. 

For more information about the dataset, please see:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

======================================

It is assumed that the data is already downloaded and stored locally on your machine.

The files are then read into seperate data tables. 

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


The files are then merged into one data frame called "merged_dataset".

The activity labels are renamed; 

  1. Walking
  2. Walking Downstairs
  3. Walking Upstairs
  4. Sitting
  5. Standing
  6. Laying

The mean and standard deveation are then selected from the dataset. 

The final dataset is then produced by grouping the subjects and their activities together, and taking the mean of the means and standard deveations.
