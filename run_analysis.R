	# Step 1: Read the data and combine into one dataset


xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt") 						#measures, or features, from training
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")				#subjects that correspond to those measures
ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")							#activities that subjects are measured doing


xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")								#measures, or features, from testing
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")				#subjects that correspond to those measures
ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")								#activities that subjects are measured doing

features <- read.table("./UCI HAR Dataset/features.txt")								#names of features, which will become colum headings

traindata <- cbind(xtrain, subjecttrain, ytrain)									#binding steps combine the data into table called all_data
testdata <- cbind(xtest, subjecttest, ytest)
all_data <- rbind(traindata,testdata)


	#Step 2: Extract data that are means and standard deviations 


mean_sd_columns <- 																	c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543,562,563)
																					#this is a vector of positions of the columns to keep
new_data <- all_data[,mean_sd_columns]
												#new_data contains just features that are means and stand. devs.

	# Step 3: Use names in place of numbers for the activities


library(plyr)																		#Need plyer for the revalue function

new_data$V1.2 <- revalue(as.character(new_data$V1.2), c("1" = "WALKING","2" = "WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","5" ="STANDING","6" ="LAYING"))															#This replaces the numbers 1-6 in the activity column with names

	#Step 4: Give columns meaningful names, taken from the features.txt file
												

mean_sd_cols <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
col_names <- features[[2]][mean_sd_cols]												
names(new_data) <- col_names														#replaces col names with features	
names(new_data)[67] <- paste("subject")												#last 2 columns are not features. This names them.
names(new_data)[68] <- paste("activity")

	#Step 5: Create new table of means of the feature variables for each subject doing each activity

table_of_means <- ddply(new_data, c("activity", "subject"), numcolwise(mean))		#creates new table
names(table_of_means) <- gsub('[()]','',names(table_of_means))						#renames variables without ()
names(table_of_means)[3:68] <- paste(names(table_of_means)[3:68],"-sub-act-mean",sep ='')		#appends -sub-act-mean to variable names


write.table(table_of_means,file = "/Users/Izydorczak/table_of_means.txt", row.name = FALSE)

