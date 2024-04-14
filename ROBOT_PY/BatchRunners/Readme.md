# Batch Runners Documentation

**Important:** All the comments inside the batch file are starting with REM COMMENT and the commented execution statements start with just REM.  
<mark>*We need to enter few values manually.*</mark> Please go through all the comments to understand better.  

### Usage
Batch run utility is required to run the test cases in batches. The utilities in this folder are:
1. RegressionRun.bat: It will run all the test cases from Folder Test Suite UI with Tags REGRESSION.

### How to Run
1. Double-click on the filename in your windows system   
OR  
Open command prompt and navigate to BatchRunners folder and run the batch file.
2. We need to provide an input of choice:

| Choice | Purpose |
| ------ | ------- |
| run | Used for doing batch run of the test cases |
| merge | Used for merging two output files. Use case: Suppose we ran all 20 test cases with Sanity tag. 5 of them failed. Now we have utility to run only the failed 5 test cases, but it creates different output files. In order to merge these logs and create just one log we use the merge choice. We need to **pass the Paths of the output.xml files** to be merged in this command.|


### Tools Used
1. RobotFramework-Pabot
2. RobotFramework-Rebot

### Dependancies
- Added to requirements.txt
- Install Project dependencies from IDE **TERMINAL** window using command
```
    pip install -r requirements.txt
```
