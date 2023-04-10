<#
.Synopsis
    Creates Google Classroom.
.Description
    Create-GoogleClasroomSingle creates a Google Classroom based on prompts from the script. 
    This includes requesting alias name, course name, and teacher email address. The script prompts you through the course creation process.
.Example

.Inputs
    Course Alias
    Course Name
    Teacher email address
.Outputs

.Notes
#>

### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

### Define Variables
$CourseAlias = Read-Host -Prompt 'Enter alias for course'
$CourseName = Read-Host -Prompt 'Enter name for course'
$CourseTeacher = Read-Host -Prompt 'Enter email address for course teacher'

### Create the course with the assinged alias and name. Add the teacher to the course and make Active.
GAM create course alias $CourseAlias name $CourseName teacher $CourseTeacher status ACTIVE