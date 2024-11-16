Here’s a comprehensive and polished `CodeBook.md` for your project. This document covers all necessary details and is formatted to align with standard practices.

---

# CodeBook

This CodeBook describes the variables, data, and transformations performed in the `run_analysis.R` script for the **Getting and Cleaning Data Project**.

---

## Overview

The dataset was derived from the **Human Activity Recognition Using Smartphones Dataset**, which contains data collected from accelerometers and gyroscopes embedded in smartphones. This project aims to clean, process, and create a tidy dataset for further analysis.

The output consists of two datasets:

1. `tidy_data`: The cleaned dataset containing descriptive variable names and extracted measurements on the mean and standard deviation.
2. `final_tidy_data`: An independent dataset summarizing the average of each variable for each activity and each subject.

---

## Variables in `final_tidy_data`

The `final_tidy_data` dataset contains **68 variables** and represents the average of each measurement for each subject and activity.

### Key Variables

1. **SubjectID**: An integer (1–30) identifying the participant.
2. **ActivityName**: A descriptive factor representing the activity performed:
    - `WALKING`
    - `WALKING_UPSTAIRS`
    - `WALKING_DOWNSTAIRS`
    - `SITTING`
    - `STANDING`
    - `LAYING`

3. **Measurement Variables**: A total of **66 measurement variables** derived from the original dataset. These represent the mean and standard deviation of signals. Below is a breakdown:

#### Time-Domain Variables:
- **TimeBodyAccelerometerMeanX**
- **TimeBodyAccelerometerMeanY**
- **TimeBodyAccelerometerMeanZ**
- **TimeBodyAccelerometerSTDX**
- **TimeBodyAccelerometerSTDY**
- **TimeBodyAccelerometerSTDZ**

#### Frequency-Domain Variables:
- **FrequencyBodyAccelerometerMeanX**
- **FrequencyBodyAccelerometerMeanY**
- **FrequencyBodyAccelerometerMeanZ**
- **FrequencyBodyAccelerometerSTDX**
- **FrequencyBodyAccelerometerSTDY**
- **FrequencyBodyAccelerometerSTDZ**

Other measurements include data from gyroscopes, jerk signals, and magnitudes.

---

## Data Transformation Steps

The following steps were performed in `run_analysis.R` to produce the tidy datasets:

### Step 1: Merge the Training and Test Datasets
- Combined `X_train.txt` and `X_test.txt` (measurements).
- Combined `y_train.txt` and `y_test.txt` (activity labels).
- Combined `subject_train.txt` and `subject_test.txt` (subject IDs).

### Step 2: Extract Mean and Standard Deviation Measurements
- Used `features.txt` to identify variables containing `mean()` or `std()` in their names.
- Subsetted the combined dataset to retain only these columns.

### Step 3: Use Descriptive Activity Names
- Replaced activity IDs in the dataset with descriptive names from `activity_labels.txt`.

### Step 4: Appropriately Label the Dataset
- Renamed variable columns to be more descriptive:
    - Prefix `t` changed to `Time`.
    - Prefix `f` changed to `Frequency`.
    - Expanded abbreviations:
        - `Acc` → `Accelerometer`
        - `Gyro` → `Gyroscope`
        - `Mag` → `Magnitude`
        - `BodyBody` → `Body`

### Step 5: Create a Second Independent Tidy Dataset
- Grouped the data by `SubjectID` and `ActivityName`.
- Calculated the mean for each variable in each group.
- Saved the result as `final_tidy_data.txt`.

---

## Files Used in the Analysis

- **activity_labels.txt**: Links activity IDs with activity names.
- **features.txt**: Contains names of all features.
- **X_train.txt** and **X_test.txt**: Measurements from training and test sets.
- **y_train.txt** and **y_test.txt**: Activity labels for training and test sets.
- **subject_train.txt** and **subject_test.txt**: Subject IDs for training and test sets.

---

## Notes on Naming Conventions

- **Descriptive Variable Names**:
    - All variable names are human-readable and follow tidy data principles.
    - No abbreviations are used unless they are clear (e.g., `STD` for Standard Deviation).

- **Tidy Data Principles**:
    - Each variable is in one column.
    - Each observation is in one row.
    - Each type of observational unit forms a table.

---

## Outputs

1. **`tidy_data.txt`**:
   - Contains measurements of mean and standard deviation, along with descriptive variable names.

2. **`final_tidy_data.txt`**:
   - Aggregates `tidy_data` by calculating the mean for each variable for each `SubjectID` and `ActivityName`.

---

This `CodeBook.md` file is ready for direct use in your GitHub repository. Let me know if you need additional adjustments!
