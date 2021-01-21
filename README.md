# CTX-PS-Process-Spreadsheet

This library contains a set of Flows and subtasks to process spreadsheets:
- CTX-PS-Main is a subtask to be invoked by a LivePortal flow that allows a user to:
  - view a list of files that have been uploaded, alongside their status
  - view a list of the lines inside uploaded files, alongside their status
  - upload new files and begin prcessing their contained lines
- CTX-PS-Process-File is a Flow to import data from a file on the Cortex server, and start asynchronously one execution of the CTX-PS-Process-Line flow for each line in the file
- CTX-PS-Process-Line is a Cortex Flow to process a single line in an uploaded file, and to maintain the status of both the line and the file; this flow starts synchronousy via a Cortex FlowAPI an execution of a user-defined worker flow.
 
Example use of this library is shown in the CTX-PS-Example-GUI and CTX-PS-Example-Worker flows which are included in the package.

 # Dependencies
This library uses subtasks from the following libraries;
- CTX-Logging
- CTX-Configuration-Store
- CTX-Excel
- CortexMaterialDesignSubtasks
- CTX-Gateway

# Installation
1. Download the Studio Package file and Import it into your Cortex Environment. Don't forget to apply rights using the Studio Authorization module.
1. In the SQL Database of your choice, create two tables, using the Files.sql and Lines.sql files.
1. Using a database tool of your choice, extend the Lines database table with additional character-type columns, reflecting the data that will be included in imported spreadsheets.
1. Import the CTX-PS-Process-Spreadsheet studio package; remember to set studio access rights appropriately

# Use
To use this library, in a LivePortal flow invoke the subtask CTX-PS-Main.
This subtask will provide a cycle of three LivePortal GUI pages:
- the first page will display all files that have been uploaded, and will allow navigation to the other two pages
- the second page will display all lines uploaded from a single file selected on the first page; it will allow in-page refreshing of the data and navigation to the first page
- the third page will allow the user to identify one or more spreadsheets for uploading, and will start separate flows asynchronously for each file; it will allow navigation to the first page

The subtask will only return to the calling LivePortal flow if the LivePortal user clicks the 'Quit' button on any of the three pages, or they do not press any button for 5 minutes.
The subtask takes the following parameters:
Parameter Name | Description | Type | M/O |
---------------|-------------|------|-----|
**i_connection-String**| The connection string to the database hosting the FILES and LINES tables created above; no default value is set| Text| M
**i_FILES-tablename**| The name of the FILES table in the database; it defaults to "FILES"|Text|O
**i_LINES-tablename**| The name of the LINES table in the database; it defaults to "LINES"| Text|O
**i_Files-header**|Text to display in the panel title in the LivePortal GUI showing uploaded files; it defaults to "List of uploaded files"|Text|O
**i_Lines-header**|Text to display in the panel title in the LivePortal GUI showing uploaded lines, where it will be follwed by the selected file name; it defaults to "Lines in file "|Text|O
**i_log-handler**|A log handler provided by the CTX-Logging library; if not provided then no logging is performed|Structure|O
**i_user-columns**|A list of structures defining user columns in both the spreadsheets to be uploaded, and the LINES database table. See below for detail|Structure|O
**i_FlowAPI-URI**|The URI of the FlowAPI that will be used to execute a Worker Flow for each uploaded line; the default value is "https://localhost:10000"|Text|O
**i_FlowAPI-authentication-type**|The authentication type required by the Flow API; the default value is "Basic"|Text|O
**i_FlowAPI-authentication-credentials**|The authentication credentials required by the Flow API; the default value is the same as the default configuruation of the cortex FlowAPI|Structure|O
**i_worker-flow-name**|The name of the worker flow that will be executed for each uploaded line in the spreadsheet; see below for more information|Text|M
**i_user-data**|Additional user data that will be passed to each execution of the worker flow; the default value is ""|Text|O

## Spreadsheet to be uploaded
Each Microsoft Excel spreadsheet to be uploaded must have a sheet named "Sheet1", and the first row of the sheet must be column titles. Only columns with a title matching the SPREADSHEET-COLUMN field of an element in the **i_user-columns** input parameter are uploaded; other columns present in the spreadsheet are ignored. The columns may occur in any order in the spreadsheet. An error is reported against the file if any column listed in the **i_user-columns** parameter is missing; this will be displayed on the Files page of the LivePortal GUI.

## **i_user-columns** detail
Each element of the **i_user-columns** input variable list is a structure with the following fields:
- SPREADSHEET-COLUMN: (optional) the value in the first row of the uploaded spreadsheet; if not present then this column is not uploaded from the spreadsheet
- DATABASE-COLUMN: the name of the column in the LINES table of the database
- DISPLAYTEXT: The text to use as the column header in the LivePortal GUI showing uploaded lines

## Worker flows
A separate flow is initiated in parallel for each uploaded line in a spreadsheet.
### Input parameters
The worker flow should accept the following input parameters:
- **i_line-data**: A Structure variable with a field for each user column added to the LINES table; the field name is the name of the database column, and the field value will bethe value uploaded from the spreadsheet
- **i_user-data**: A Text variable containing the value passed to the i_user-data parameter of the CTX-PS-Main subtask
### Output parameters
The worker flow should set the following two output parameters:
- **o_status**: A Text variable to contain the status ofthe line; this should be set to either "Fail" or "Success"
- **o_status-reason**: A Text variable describing the cause of the status

Additionally, the worker flow may return the following output parameter:
- **o_line-data** A Structure variable with a field for each user column to be updated for this entry in the LINES table; the field name is the name of the database column


:thumbsup: Enjoy! :wink:
