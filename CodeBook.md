###
The whole exercise required us to filter the columns which represents mean and
standard deviation. It also needs to create a group by subject id and the activities. 

To do this the whole project will need following things:

1. Reading all the necessary files for activity and features.
2. Filter out the relevant columns using grep command to extract the columns with mean() and std()

3. Read test and train files along with activity and subject number.

4. Name the column of the dataset using data.table::setNames. This will change the default name to a new 
name as extracted from grep. [line No 39 and 48]

5. Since we have three column of data which can be combined to create a dataset. The dataset will 
be test and train. Using rbind, these are combined to generate a bigger dataset.  [Line no 44 and 53]

4. we can create a class lables from the data using factors. It is used to create a list 
of subjects and the activity. [line no 57 and 62]

5. The melt command from reshape2 is added so that the data can be converted into long format.
with two labels based on the subject and activity. [line No 63]

6. Finally, the data is converted into wide format using cast function [line no 64]


```
Variable Definition:

"activity_label" : Activity label from the dataset 
"combined"        : Final dataset for generating tidy.txt
"data_url"         : File url to download the data
"features"         : All the feature name
"measurements"     : All the required features with cleaned syntax
"required_feat"   : Required feature grabbed using grep 
"test"            : test set loaded into the memory
 "test_activities" : List of activities
 "testSubjects" : test subjects ( participant id)
 "train"           : train set
 "train_activities" : train activities
 "trainSubjects"   : train subject (participant id)
 ```
 
