
#url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#destfile<-"dataset.zip"
#download.file(url, destfile)

#read test and train data in as data.frames
train<-read.table("./UCI HAR Dataset/train/X_train.txt")
test<-read.table("./UCI HAR Dataset/test/X_test.txt")
train.activity<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names="activity")
test.activity<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names="activity")
train.subject<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")
test.subject<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")

#combine numeric test and train data
data<-rbind(test,train)

#label variables in combined data (v1 -> tBodyAcc-mean()-X, etc.)
labels<-read.table("./UCI HAR Dataset/features.txt", row.names=1, col.names="labels")
colnames(data)<-labels$labels

#add on the activity ids
data.activity<-rbind(test.activity,train.activity)
data<-cbind(data.activity,data)

#add on the subject ids
data.subject<-rbind(test.subject,train.subject)
data<-cbind(data.subject,data)

#subset 'mean()' and 'std()' related columns + activity + subject
data.tidy<-data[, c(1:2,grep("mean()",names(data), fixed=TRUE),grep("std()",names(data), fixed=TRUE))]
data.tidy$activity<-factor(data.tidy$activity,labels=c("Walking","Walking_Upstairs","Walking_downstairs","Sitting","Standing","Laying"))

#group by subject and activity, return mean for each numeric variable in data
data.tidy.agg<-aggregate(data.tidy,
                         by=list(activity=data.tidy$activity,subject=data.tidy$subject),
                         FUN="mean")
data.tidy.agg<-data.tidy.agg[,-c(3,4)]

#write out txt file for project
destfile<-"data_tidy_output.txt"
write.table(data.tidy.agg, destfile)
