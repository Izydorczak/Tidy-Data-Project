# Tidy-Data-Project
 Tidy Data processing script and codebook created as a course project

##Step 1: Read the data and combine into one dataset.

read.table is a function that is used to read the seven tables that were downloaded into my home directory.

xtrain is a data frame of the measures, or features, on each subject from the training group. 
xtest is the same for subjects from the testing group.

ytrain is a column of activities that subjects were measured while performing. It aligns with the measures in xtrain.
ytest is the same for the testing group.

subjecttrain is a column of subjects who performed the activities and were measured on the features. It aligns with the activities in ytrain and the measures in xtrain.
subjecttest is the same for the testing group.

features is a table with the names of all the variables that were measured. This will become the column headings.
						

All six tables are then combined into one table called all_data by using the cbind and rbind functions. Each row is a vector of variables, or features, taken for one subject performing one activity. 
Each subject has multiple measures, and therefore rows, on each activity. 
Columns are the features, followed by a column of subjects, followed by a column of activities.


##Step 2: Extract data that are means and standard deviations. 

A vector called mean_sd_columns is created. This is a vector of positions of items in the feature file that have names ending in "mean" or "standard deviation" along with the positions of the subject and activity columns.
A data frame called new_data is created using the all_data data frame and subsetting only the mean_sd_columns along with the subject and activity columns.

Step 3: Use names in place of numbers for the activities.


The plyer library was used for its "revalue" function.
At this point, the name of the activities column is V1.2 and it's values are numbers that correspond to the six activities.
The revalue function changes the values in the V1.2 column, replacing numbers with names, like WALKING.
														

##Step 4: Give columns meaningful names, taken from the features.txt file.
												
The means_sd_cols vector, used in Step 2, which indicates the positions of the features of interest, is modified to exclude the last 2 columns of subject and activities.
Then it is used to subset the features table. It extracts the column names of those features of interest from the features table. Those names are put in a vector called col_names.
The col_names vector is then used with the names function to replace the original column names (V1,V2,...) in the data frame with meaningful names of the features.
The names function was also used individually to rename the "subject" and "activity" columns.												

##Step 5: Create new table of means of the feature variables for each subject doing each activity.

A new data frame, called table_of_means is created using the ddply function. 
The function takes the most recent version of new_data and computes columnwise means for all features for each subject on each activity.
For example, there are multiple measures of each feature variable for subject 1 doing the activity walking. 
The table_of_means has condensed those measures into 1 row for subject 1 walking. It contains the means of each measure.

I also renamed the columns in this data frame, now that each piece of data is a newly created mean. I used gsub to remove the () in the column names. I used the paste function to append each column name with sub-act-mean.

Finally, I put the resulting data frame, called table_of_means, into a text file of the same name, by using the write.table function.

References:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
