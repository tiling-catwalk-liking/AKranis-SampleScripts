<#
.Synopsis
    This is intended to make a quick and easy way of removing user from all group membership as part of the 
    deprovisioning process. Long term, it should be a component of a single script that handles all parts (disable AD, email, etc) 

.Description
    The script prompts for the SAM account name of the user to be disabled. The script then identifies all groups that
    user is member of, while excluding "Domain Users" group. Finally, the user is removed from all groups.

.Inputs
    SAM Account Name

.Link
https://mcsaguru.com/adgroup/

    #>

### Promt username to remove from groups
$SAMAccountName = Read-Host -Prompt "Enter Username for AD Group removal"
###Identify groups that user is member of. Exclude "Domain Users" group.
$ADGroups = Get-ADPrincipalGroupMembership -Identity $SAMAccountName | where {$_.Name -ne "Domain Users"}
### Remove user from groups.
Remove-ADPrincipalGroupMembership -Identity $SAMAccountName -MemberOf $ADGroups -Verbose