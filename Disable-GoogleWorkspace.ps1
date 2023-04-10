<#
.Synopsis
    This is intended to make a quick and easy way of de-provisioning a Google Workspace Account.

.Description
    The script prompts for the email address of the user to be disabled. The script proceeds to change the password,
    deprovision (Googles deprovisioning process for tokens etc), disable, remove from groups, removed from GAL,
    change to Suspended Users OU, sign the user out anywhere they may be signed in, change the recovery email and phone number.

.Inputs
    Email Address

.Link
    https://sites.google.com/jis.edu.bn/gam-commands/people?authuser=0
    https://github.com/taers232c/GAMADV-XTD3/wiki/Users-Deprovision

    #>

### Promt user for email to disable
$DisableUser = Read-Host -Prompt "Enter email address of user to disable"

###Generate random number for the password.
$RandomNum = Get-Random
$Password = "SomethingthatIsSuperRandomAndLong" + $RandomNum

### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

gam update user $DisableUser password $Password

gam user $DisableUser deprovision

gam user $DisableUser delete groups

gam suspend user $DisableUser

gam update user $DisableUser gal false

gam update ou "/Suspended Users" move $DisableUser

gam user $DisableUser signout

gam update user $DisableUser recoveryemail "norecovery@contoso.com"

gam update user $DisableUser recoveryphone "+15555555"