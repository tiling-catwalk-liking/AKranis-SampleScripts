Function Add-GoogleClasroomTeacher {
<#
.Synopsis
    Adds teacher to Google Classroom.

.Description
    Add-GoogleClasroomTeacher adds a teacher to Google Classroom. 

.Example
    Add-GoogleClassroomTeacher -CourseID 12345 -CourseTeacher teacher@contoso.com

.Inputs
    Google Classroom Alias
    Google Classroom Name
    Course ID
    Email address for additional teacher.
    
.Outputs

.Notes
#>

    param (
        [string]$CourseAlias,
        [string]$CourseName,
        [string]$CourseTeacher,
        [string]$CourseID
        )
        
### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

### Create the course with the assinged alias and name. Add the teacher to the course and make Active.
GAM course $CourseID $CourseAlias add teacher $CourseTeacher 

}