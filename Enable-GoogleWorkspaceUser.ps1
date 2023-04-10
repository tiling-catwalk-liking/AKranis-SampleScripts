<#
.Synopsis
    Re-enable a disabled Google Workspace user.

.Description
    Uses GAM to enable a previously disable Google Workspace user while moving them to the correct OU, adding a recovery email, turning
    on the GAL, adding to groups, and updating the password.

.Inputs
    Email Address of account to reactivate
    Recovery email to update
    Org Unit
    Email address of groups

.Link
    https://github.com/taers232c/GAMADV-XTD3/wiki/Groups-Membership
    https://sites.google.com/jis.edu.bn/gam-commands/people/users?authuser=0#h.5hg8izojc442

    #>

$EnableUser = Read-Host -Prompt "Enter email address of user to enable"

$OrgUnit = Read-Host -Prompt "Org Unit for user? eg. /Staff/Middle School" 

$RecoveryEmail = Read-Host -Prompt "Enter new recovery email for user"

$Password = Read-Host -Prompt "Enter new password for user (to be changed by user)"

### Create array of groups to be added.
$Groups = @()
do {
    $EmailGroup = (Read-Host "Enter Group Email (eg. elementary@contoso.com). When done, enter nothing and click enter")
    if ($EmailGroup -ne ''){$Groups += $EmailGroup}
    }
    until ($EmailGroup -eq '')


### Set the path the executable for GAM.exe
Set-Location "C:\GAMADV-XTD3"

gam unsuspend user $EnableUser

gam update ou $OrgUnit move $EnableUser

gam update user $EnableUser password $Password

gam update user $EnableUser changepassword true

gam update user $EnableUser gal true

gam update user $EnableUser recoveryemail $RecoveryEmail

foreach ($Group in $Groups) {
    gam update group $Group add member $EnableUser
}