<#
.Synopsis
    Adds students to Google Classroom.
.Description
    Add-GoogleClassroomStudents uses a CSV export from the SIS (must have student email address) and creates a Google Workspace account
    for the student in the OU that is specified when running the script.
.Example

.Inputs
    Full path to the CSV file to upload. Must not be enclosed in quotes.
    CourseID for Google Classroom
    
.Outputs

.Notes
#>

### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

### Define Variables
$CSVFile = Read-Host -Prompt 'Enter the full path for the CSV file. WITHOUT quotes.'
$Students = Import-Csv $CSVFile
$CourseID = Read-Host -Prompt 'Enter the CourseID'

### 
ForEach($Student in $Students)
{
    GAM course $CourseID add student $Student.Email
}