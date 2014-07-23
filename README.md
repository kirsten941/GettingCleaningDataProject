This project produces a tidy data set with mean values summarized by subject and activity.

The source data for the project was downloaded and unzipped from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The unzipped data is found in the UCI HAR Dataset folder.

The script to run the analysis is 'run_analysis.R'

The output of the analysis is 'data_tidy_output.txt'

Steps in the script:
1. read in data from X_train.txt, X_test.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt
2. combine the data from X_train and X_test
3. add labels to the data from step 2 using the labels in features.txt
4. add activity id for each row in the data
5. add subject id for each row in the data
6. subset the data so that it includes subject id, activity id, and all variables that contain the phrase 'mean()' or 'std()' in the variable label
7. convert activity id to factors with levels: "Walking","Walking_Upstairs","Walking_downstairs","Sitting","Standing","Laying"
8. summarize the data by subject and activity, with the average of each variable for each activity and each subject
9. write out a txt file to data_tidy_output.txt