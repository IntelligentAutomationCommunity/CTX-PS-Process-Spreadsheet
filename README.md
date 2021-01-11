# CTX-PS-Process-Spreadsheet

This library contains a set of Flows and subtasks to process spreadsheets:
- CTX-PS-Display-File-Status is a LivePortal flow that allows a user to:
 - view a list of files that have been uploaded, alongside their status
 - view a list of the lies inside uploaded files, alongside their status
 - upload new files and begin prcessing their contained lines
 - CTX-PS-Process-File is a Flow to import data from a file on the Cortex server, and start one execution of the CTX-PS-Process-Line flow for each line in the file
 - CTX-PS-Process-Line is a Cortex Flow to process a single line in an uploaded file, and to maintain the status of both the line and the file
 
 # Dependencies
This library uses subtasks from the following libraries;
- CTX-Logging
- CTX-Configuration-Store
- CTX-Excel

# installation
- Edit the Lines.sql file included in this library to include additional columns reflecting the data that will be included in imported spreadsheets.
- In the SQL Database of your choice, create two tables, using the Files.sql and Lines.sql files.
- Import the CTX-PS-Process-Spreadsheet studio package; remember to set studio access rights appropriately
- Set the ($)g_Config-Area and ($)g_Config-Customer global variables in the CTX-PS-Display-File-Status Cortex Flow. the CTX-Configuration-Store for this Area/Customer combination should include the following paramaters:
- FILES_TABLE - the name of the SQL Server database table created from the Files.sql file
- LINES_TABLE - The name of the SQL Server database table created from the Lines.sql file
-CONNECTIONSTRING - the configuration to access the Microsoft SQL Serevr Database containing the two database tables

Modify the Upload-State of the CTX-PS-Process-File Cortex Flow to process the columns in the imported spreadsheet, as inidctaed by the RED notes
Modify the Process-Line state of the CTX-PS-Process-Line Cortex Flow to undertake the work to do for each row in the file

# Configuration
This library uses 
