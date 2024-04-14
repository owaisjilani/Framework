@echo off

setlocal enabledelayedexpansion

REM COMMENT Get current date and time components
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set datetime=%%a

REM COMMENT Set the current directory to the root of the folder i.e. APP-automation
cd %~dp0

cd ".."

cd

set /p version="Enter APP_Version (text): "
set /p choice="Enter your choice run or merge (text): "

if /i "%choice%" == "run" (

	REM COMMENT Format the date and time as (DDMMYYYY_HHMMSS)
	set formatted_datetime=!datetime:~6,2!!datetime:~4,2!!datetime:~0,4!_!datetime:~8,2!!datetime:~10,2!!datetime:~12,2!
	
	REM COMMENT Set the output folder name along with datetime
	set "output_folder=RegressionRun_!formatted_datetime!"

	cd BatchRunners
	if not exist "!output_folder!" (
		mkdir "!output_folder!"
		echo Directory created successfully: !output_folder!
	) else (
		echo Failed to create directory.
	)
	cd ".."

	REM COMMENT Below are Run statements. First one is for initial run and then one can use below statements for rerunning only the failed test cases

	python -m pabot.pabot --processes 1 --metadata APP_Version:%version% --logtitle "Regression Run" --include REGRESSION --exclude WIP --suitestatlevel 2 --tagstatexclude SMOKE --tagstatexclude REGRESSION --timestampoutputs --outputdir BatchRunners\!output_folder! Robot-taf\TestSuiteUI

	REM COMMENT Change the directory in rerunfailed option to your output directory from above run statement and keep output.xml as it is. Remove REM from below statement, add REM to other run statements and then execute the batch file. Everything else stays as it is.

	REM python -m pabot.pabot --processes 1 --metadata APP_Version:%version% --logtitle "Regression Run" --include REGRESSION --exclude BUG --suitestatlevel 2 --tagstatexclude SMOKE --tagstatexclude REGRESSION --timestampoutputs --rerunfailed BatchRunners\RegressionRun_26122023_141654\output.xml --outputdir BatchRunners\!output_folder! Robot-taf\TestSuiteUI

	REM COMMENT Change the directory in rerunfailed option to your output directory from above run statement and keep output.xml as it is. Remove REM from below statement, add REM to other run statements and then execute the batch file. Everything else stays as it is.

	REM python -m pabot.pabot --processes 1 --metadata APP_Version:%version% --logtitle "Regression Run" --include REGRESSION --exclude WIP --suitestatlevel 2 --tagstatexclude SMOKE --tagstatexclude REGRESSION --timestampoutputs --rerunfailed BatchRunners\CHANGE_THIS_FOLDERNAME\output.xml --outputdir BatchRunners\!output_folder! Robot-taf\TestSuiteUI
	
) else if /i "%choice%" == "merge" (
	REM COMMENT After using rerunfailed, separate logs are created. In order to combine them, use below:
	set formatted_date=!datetime:~6,2!!datetime:~4,2!!datetime:~0,4!

	set "output_folder_final=RegressionRun_Final_!formatted_date!"
	
	cd BatchRunners
	if not exist "!output_folder_final!" (
		mkdir "!output_folder_final!"
		echo Directory created successfully: !output_folder_final!
	) else (
		echo Failed to create directory.
	)
	cd ".."
	
	REM COMMENT In below command, only change foldername to the earlier output directory folders. We can merge 2 or more output files and generate single log, report and xml out of it. Please ensure the order, the first file must be from the main regression execution.
	rebot --logtitle "Regression Run" --outputdir BatchRunners\!output_folder_final! --output output.xml --tagstatexclude SMOKE --tagstatexclude REGRESSION --suitestatlevel 2 --merge BatchRunners\RegressionRun_12022024_203305\output.xml BatchRunners\RegressionRun_13022024_173443\output.xml
) else (
	echo Invalid Choice. Please enter a valid choice.
)

pause