# Load required libraries
library(dplyr)

# Set the path to the dataset folder using forward slashes
data_path <- "C:/Users/sksha/OneDrive/Desktop/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset"

# Load activity labels and features
activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("ActivityID", "ActivityName"))
features <- read.table(file.path(data_path, "features.txt"), col.names = c("FeatureID", "FeatureName"))

# Define paths for training and test datasets
train_path <- file.path(data_path, "train")
test_path <- file.path(data_path, "test")

# Load training datasets
subject_train <- read.table(file.path(train_path, "subject_train.txt"), col.names = "SubjectID")
x_train <- read.table(file.path(train_path, "X_train.txt"))
y_train <- read.table(file.path(train_path, "y_train.txt"), col.names = "ActivityID")

# Load test datasets
subject_test <- read.table(file.path(test_path, "subject_test.txt"), col.names = "SubjectID")
x_test <- read.table(file.path(test_path, "X_test.txt"))
y_test <- read.table(file.path(test_path, "y_test.txt"), col.names = "ActivityID")

# Step 1: Merge the datasets
train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
combined_data <- rbind(train_data, test_data)

# Step 2: Extract mean and standard deviation measurements
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$FeatureName)
selected_columns <- c(1, 2, mean_std_features + 2)
tidy_data <- combined_data[, selected_columns]

# Step 3: Use descriptive activity names
tidy_data$ActivityID <- factor(tidy_data$ActivityID, 
                               levels = activity_labels$ActivityID, 
                               labels = activity_labels$ActivityName)

# Step 4: Appropriately label the dataset
colnames(tidy_data) <- c("SubjectID", "Activity", features$FeatureName[mean_std_features])

# Clean column names to make them more descriptive
colnames(tidy_data) <- gsub("^t", "TimeDomain_", colnames(tidy_data))
colnames(tidy_data) <- gsub("^f", "FrequencyDomain_", colnames(tidy_data))
colnames(tidy_data) <- gsub("Acc", "Accelerometer", colnames(tidy_data))
colnames(tidy_data) <- gsub("Gyro", "Gyroscope", colnames(tidy_data))
colnames(tidy_data) <- gsub("Mag", "Magnitude", colnames(tidy_data))
colnames(tidy_data) <- gsub("BodyBody", "Body", colnames(tidy_data))
colnames(tidy_data) <- gsub("-mean\\(\\)", "_Mean", colnames(tidy_data), ignore.case = TRUE)
colnames(tidy_data) <- gsub("-std\\(\\)", "_STD", colnames(tidy_data), ignore.case = TRUE)

# Step 5: Create a second independent tidy dataset
final_tidy_data <- tidy_data %>%
  group_by(SubjectID, Activity) %>%
  summarize(across(everything(), mean, .names = "mean_{col}"), .groups = "drop")

# Write the final dataset to a file
write.table(final_tidy_data, "C:/Users/sksha/OneDrive/Desktop/tidy_dataset.txt", row.names = FALSE)
