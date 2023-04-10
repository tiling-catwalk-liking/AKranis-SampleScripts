### This short script allows you to use Powershell to locate a user account name by entering a partial match of the users name.
### The first variable is to get a string that is part of the users name
$PartName = Read-Host -Prompt 'Enter part of the name of the user you are searching for'
### $PartNameSearch variable takes the partial name string and puts wildcards on both sides so that it may be used
### for the Get-ADUser search
$PartNameSearch = '*' + $PartName + '*'
### Show all users who share part of the string to be searched
Get-ADUser -Filter 'Name -Like $PartNameSearch'