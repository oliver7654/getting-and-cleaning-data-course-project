# Peer-graded Assignment: Getting and Cleaning Data Course Project
# CodeBook

# Data

The raw data set for this assignment is the UCI [
Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
It is primarily designed for machine learning, consisting of a training and a test dataset,
with a huge number of features (561). Input features and classification labels are kept in different files, as well as column names.

The features are essentially derived from two sensors (accelerometer and gyroscope),
each producing 3D signals (XYZ).
The dataset is not designed to be 'tidy' as it is proposed by H. Wickham in the paper 'Tidy Data'.
Instead it contains a huge number of aggregated features, which is typically good for machine learning.

For example, there are features `tBodyAcc-mean()-X`, `tBodyAcc-std()-X`, and `tBodyAcc-entropy()-X`.
From Wickham's paper, this would indicate a common mistake: column headers are values, not variable names. All three are derived from the Accelerometer's `X` signal (`Acc...-X`). `t` means `time` as opposed to `f` for `frequency` (resuling from Fourier transformation). `Body` means that a Butterworth filter has been applied to detect if the source of the force was the `body` or `gravity`. The parts `mean()`, `std()`, and `entropy()` indicate different accumulations computed on a sliding window of the raw sensor signal.

Turning the dataset into a truely tidy dataset, as formulated by Wickham, seems to be pretty hard or even impossible without changing the nature of the dataset entirely.
Thus, the aim of this project is making the dataset at least a little bit 'tidier', mainly by pulling data together in one dataset, renaming columns, and replacing numeric labels for activities with readable strings.

Beyond that, there seem to be errors in the feature table (`features.txt`):
- columns 303-316 are redundant with 317-330, and 331-344. It seems that suffixes for dimension 'X', 'Y', and 'Z' are missing
- same with columns 382-423 and columns 461-502
- columns 516-554 contain a double 'BodyBody' which does not match the feature description, e.g `fBodyBodyAccJerkMag-mean()`. Assuming that this a mistake and should be `fBodyAccJerkMag-mean()`

# Transformation

As requested in the programming assignment description, the following transformations are performed by the script
`run_analysis.R`:
1. Merging the training and the test sets to create one data set.
2. Retaining only features which represent the `mean` or `standard deviation (std)` of a measurment. I.e. discarding all the other accumlations, such as `min`, `max`, `entropy`, etc.
3. Introducing descriptive labels for the activities in the data set.
4. Introducing more descriptive variable names.

As part of Step 1, the mentioned problems with the original feature names are fixed.

In Step 4 the following renamings are applied:
- dropping the 't' in time domain features, because the time domain is the original domain
- renaming 'f' to 'frequency domain' and moving into the end indicating a 'flavour'
- renaming 'Acc' to 'accelerometer'
- renaming 'Gyro' to 'gyroscope'
- rearranging names such as 'Acc-mean()-X' to 'Mean accelerometer x', so that the name better reflects the underlying source of the variable (e.g. mean of accelerometer x).
- moving 'Body' and 'Gravity' to the end of the name indicating a 'flavour'

For example, `tBodyAcc-mean()-X` is renamed into `Mean accelerometer x (body)`,
or `fBodyGyro-mean()-X` is renamed into `Mean gyroscope x (body, frequency domain)`

# Result

The transformed dataset is stored into `output/har-tidy.csv`.
A second dataset obtained by aggregating the average of each variable for each subject and activity is stored
in `output/har-summary.csv`.

Both files contain the following columns:
- `subjectId`: A unique id of the person carrying out the observed activity
- `activity`: The name of the activity (WALKING, WALKING_UPSTEARS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- feature columns: following the pattern `<aggregation> <sensor> <jerk>? <mag>? <dim>? (<source of fource>, <frequency domain>?)`
  - `Mean accelerator x ( body )`
  - `Mean accelerator y ( body )`
  - `Mean accelerator z ( body )`
  - `Mean accelerator x ( gravity )`
  - `Mean accelerator y ( gravity )`
  - `Mean accelerator z ( gravity )`
  - `Mean accelerator jerk x ( body )`
  - `Mean accelerator jerk y ( body )`
  - `Mean accelerator jerk z ( body )`
  - `Mean gyro x ( body )`
  - `Mean gyro y ( body )`
  - `Mean gyro z ( body )`
  - `Mean gyro jerk x ( body )`
  - `Mean gyro jerk y ( body )`
  - `Mean gyro jerk z ( body )`
  - `Mean accelerator magnitude ( body )`
  - `Mean accelerator magnitude ( gravity )`
  - `Mean accelerator jerk magnitude ( body )`
  - `Mean gyro magnitude ( body )`
  - `Mean gyro jerk magnitude ( body )`
  - `Mean accelerator x ( body, frequency )`
  - `Mean accelerator y ( body, frequency )`
  - `Mean accelerator z ( body, frequency )`
  - `Mean accelerator jerk x ( body, frequency )`
  - `Mean accelerator jerk y ( body, frequency )`
  - `Mean accelerator jerk z ( body, frequency )`
  - `Mean gyro x ( body, frequency )`
  - `Mean gyro y ( body, frequency )`
  - `Mean gyro z ( body, frequency )`
  - `Mean accelerator magnitude ( body, frequency )`
  - `Mean accelerator jerk magnitude ( body, frequency )`
  - `Mean gyro magnitude ( body, frequency )`
  - `Mean gyro jerk magnitude ( body, frequency )`
  - `Std accelerator x ( body )`
  - `Std accelerator y ( body )`
  - `Std accelerator z ( body )`
  - `Std accelerator x ( gravity )`
  - `Std accelerator y ( gravity )`
  - `Std accelerator z ( gravity )`
  - `Std accelerator jerk x ( body )`
  - `Std accelerator jerk y ( body )`
  - `Std accelerator jerk z ( body )`
  - `Std gyro x ( body )`
  - `Std gyro y ( body )`
  - `Std gyro z ( body )`
  - `Std gyro jerk x ( body )`
  - `Std gyro jerk y ( body )`
  - `Std gyro jerk z ( body )`
  - `Std accelerator magnitude ( body )`
  - `Std accelerator magnitude ( gravity )`
  - `Std accelerator jerk magnitude ( body )`
  - `Std gyro magnitude ( body )`
  - `Std gyro jerk magnitude ( body )`
  - `Std accelerator x ( body, frequency )`
  - `Std accelerator y ( body, frequency )`
  - `Std accelerator z ( body, frequency )`
  - `Std accelerator jerk x ( body, frequency )`
  - `Std accelerator jerk y ( body, frequency )`
  - `Std accelerator jerk z ( body, frequency )`
  - `Std gyro x ( body, frequency )`
  - `Std gyro y ( body, frequency )`
  - `Std gyro z ( body, frequency )`
  - `Std accelerator magnitude ( body, frequency )`
  - `Std accelerator jerk magnitude ( body, frequency )`
  - `Std gyro magnitude ( body, frequency )`
  - `Std gyro jerk magnitude ( body, frequency )`

> Note: units are not given because the original dataset does not come with it.

A second dataset is stored into `har-summary.csv` containing the average of each variable for each activity and each subject.
