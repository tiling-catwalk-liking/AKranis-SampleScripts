<#
.Synopsis
    Creates Google Workspace Accounts for students.
.Description
    Create-GoogleWorkspaceStudents uses an export from SIS (Grid: GSuite Student Account Bulk Creation) and creates a Google Workspace account
    for the student in the OU that is specified when running the script.
.Example

.Inputs
    Full path to the CSV file to upload. Must be enclosed in double quotes.
    Path to the OU to place the accounts. Must be placed in double quotes. Starts with a leading foward slash.
    Example of path: "/Students/MiddleSchool2 Students"
.Outputs

.Notes
#>

### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

### Define Variables
$CSVFile = Read-Host -Prompt 'Enter the full path for the CSV file. Use double quotes. (eg. "C:\Users\User1\Downloads\Test_GoogleAccountCreation.csv")'
$OU = Read-Host -Prompt 'Enter the OU path for new accounts Use double quotes. (eg. "/Students/MiddleSchool2 Students")'

### Run the GAM Command to create student accounts. This also includes their SIS ID in a custom field.
gam csv $CSVFile gam create user ~Email firstname ~FirstName lastname ~LastName ou $OU password uniquerandom StudentData.id ~Id gal false