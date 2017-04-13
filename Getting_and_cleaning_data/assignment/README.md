# how all of the scripts work and how they are connected.

1. Test data
	- read x_test
	- read feature names
	- input feature names as variable names
	- add y_test as columnn (action_code)
	- add action description by action_code
	- add subject as column(subject)

2. Train data 
	- read x_train
	- read feature names
	- input feature names as variable names
	- add y_train as columnn (action_code)
	- add action description by action_code
	- add subject as column(subject)

3. Whole data
	- rbind train and test data

4. Select mean and std
	- extract measurements on the mean and standard deviation by selecting variable names with mean() and std() in them

5. Average of each variable for each activity and each subject
	- group by activity and subject, and calculate the mean
	- the data is clean, as their is own observation on each row