test1 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt");
test2 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt");
test3 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt");
train3 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt");
train2 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt");
train1 <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt");
mergedTest <- merge(test1,test2,by ="row.names");
mergedTest$Row.names <- NULL;
mergedTest <- merge(mergedTest,test3,by ="row.names");
mergedTest$Row.names <- NULL;
library(dplyr);
mergedTest <- rename(mergedTest,activity=V1.y,subject=V1);
mergedTrain <- merge(train1,train2,by ="row.names");
mergedTrain$Row.names <- NULL;
mergedTrain <- merge(mergedTrain,train3,by ="row.names");
mergedTrain$Row.names <- NULL;
mergedTrain <- rename(mergedTrain,activity=V1.y,subject=V1);
finalMerge <- rbind(mergedTest, mergedTrain);
finalMerge <- finalMerge[,c(1:6,41:46,81:86,121:126,161:166,201:201,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562,563)];
finalMerge$activity[finalMerge$activity == 1] <- "WALKING"
finalMerge$activity[finalMerge$activity == 2] <- "WALKING_UPSTAIRS"
finalMerge$activity[finalMerge$activity == 3] <- "WALKING_DOWNSTAIRS"
finalMerge$activity[finalMerge$activity == 4] <- "SITTING"
finalMerge$activity[finalMerge$activity == 5] <- "STANDING"
finalMerge$activity[finalMerge$activity == 6] <- "LAYING"
activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
subjects <- c(1:30)
actsub <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING",(1:30))
data <- data.frame(Date=as.Date(character()),
                 File=character(), 
                 User=character(), 
                 stringsAsFactors=FALSE) 

for(i in 1:length(activities)){
newdata <- finalMerge[finalMerge$activity == activities[i],];
newdata <- sapply(newdata[,(1:65)],mean);
data <- rbind(data,newdata);
}


for(i in 1:length(subjects)){
newdata <- finalMerge[finalMerge$subject == subjects[i],];
newdata <- sapply(newdata[,(1:65)],mean);
data <- rbind(data,newdata);
}

data <- cbind(data,actsub)


