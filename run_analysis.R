library(dplyr)
library(stringr)

# Preparation: Getting the data

if (!file.exists("data")) {
  dir.create("data")
}
#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
#unzip(temp, exdir = "data")
#unlink(temp)

# 1. Merging training and test data

# Pulling together training and test data files
# including activity (train_Y.txt, test_Y.txt)
# and subject id (subject_train.txt, subject_test.txt)
data_dir <- file.path("data", "UCI HAR Dataset")
# loading the training data
x_train <- read.delim(file.path(data_dir, "train", "X_train.txt"),
  header = FALSE, sep = "")
subject_train <- read.delim(file.path(data_dir, "train", "subject_train.txt"),
  header = FALSE, sep = "")
y_train <- read.delim(file.path(data_dir, "train", "y_train.txt"),
  header = FALSE, sep = "")
train_data <- cbind(subject_train, x_train, y_train)
# loading the test data
x_test <- read.delim(file.path(data_dir, "test", "X_test.txt"),
  header = FALSE, sep = "")
subject_test <- read.delim(file.path(data_dir, "test", "subject_test.txt"),
  header = FALSE, sep = "")
y_test <- read.delim(file.path(data_dir, "test", "y_test.txt"),
  header = FALSE, sep = "")
test_data <- cbind(subject_test, x_test, y_test)
# merging train and test data
merged_data <- rbind(train_data, test_data)
# Retrieving column names
# Note: taking only the second column from features.txt
x_column_names <- read.delim(file.path(data_dir, "features.txt"),
  sep = " ", header = FALSE)[, 2]
# Fixing column names: 'BodyBody' -> 'Body' (see CodeBook)
x_column_names <- sub("BodyBody", "Body", x_column_names)
# Disambiguating columns 303-344
x_column_names[303:316] <- paste(x_column_names[303:316], "-X", sep = "")
x_column_names[317:330] <- paste(x_column_names[317:330], "-Y", sep = "")
x_column_names[331:344] <- paste(x_column_names[331:344], "-Z", sep = "")
# Disambiguating columns 382-423
x_column_names[382:395] <- paste(x_column_names[382:395], "-X", sep = "")
x_column_names[396:409] <- paste(x_column_names[396:409], "-Y", sep = "")
x_column_names[410:423] <- paste(x_column_names[410:423], "-Z", sep = "")
# Disambiguating columns 461-502
x_column_names[461:474] <- paste(x_column_names[461:474], "-X", sep = "")
x_column_names[475:488] <- paste(x_column_names[475:488], "-Y", sep = "")
x_column_names[489:502] <- paste(x_column_names[489:502], "-Z", sep = "")
column_names <- append(append("subject_id", x_column_names), "activity")
colnames(merged_data) <- column_names

# 2. Reducing features
reduced_data <- as_tibble(merged_data) %>%
  select("subject_id", "activity",
         contains("mean()") | contains("std()"))

# 3. Substituting activity labels
activity_labels <- read.delim(file.path(data_dir, "activity_labels.txt"),
  sep = " ", header = FALSE)[, 2]
tidy_data <- reduced_data %>% mutate(activity = activity_labels[activity])

# 4. Renaming feature columns
source('transform_column_names.R')
column_names <- colnames(tidy_data)
tidy_column_names <- transform_column_names(column_names)
colnames(tidy_data) <- tidy_column_names

# 5. Creating a summary data set
summary <- tidy_data %>%
  group_by(subject_id, activity) %>%
  summarise_all(mean)

# 6. Storing generated tables
if (!file.exists("output")) {
  dir.create("output")
}
write.csv(tidy_data, file.path("output", "har-tidy.csv"), row.names = FALSE)
write.csv(summary, file.path("output", "har-summary.csv"), row.names = FALSE)