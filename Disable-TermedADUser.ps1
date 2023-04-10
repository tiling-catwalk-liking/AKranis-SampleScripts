### Commands to disable a user in Active Directory upon seperation from the org. See also Employee Termination documentation.
### Change pwd, disable, remove from groups, change OU.
#
# Define OU for disabled user accounts.
#
### Prompt for username of user to be disabled.
$SAMAccountName = Read-Host -Prompt 'Enter Username to be disabled'
### Identify variables for the user to be disabled and the OU to move the user to.
$DisableUser = Get-ADUser -Identity $SAMAccountName
$DisabledUserOU = 'OU=Disabled Users,OU=Users,OU=ad.contoso.com,DC=ad,DC=contoso,DC=com'
### Verify that you've selected the correct user.
$DisableUser
$ConfirmDisable = Read-Host -Prompt 'Is this the user you wish to disable? Y/N'
    if (($ConfirmDisable -eq 'Y') -or ($ConfirmDisable -eq'YES')) 
    {
        ###Generate random number for the password.
        $RandomNum = Get-Random
        ### Change users password.
        Set-ADAccountPassword -Identity $DisableUser.SamAccountName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText ('A!5leJ&' + $RandomNum)  -Force)
        ### Disable user account.
        Disable-ADAccount -Identity $DisableUser.SamAccountName
        ###Identify groups that user is member of. Exclude 'Domain Users' group.
        $ADGroups = Get-ADPrincipalGroupMembership -Identity $SAMAccountName | Where-Object {$_.Name -ne 'Domain Users'}
        ### Remove user from all security groups.
        Remove-ADPrincipalGroupMembership -Identity $SAMAccountName -MemberOf $ADGroups -Verbose
        ### Move user to Disabled Users OU.
        Move-ADObject -Identity $DisableUser.DistinguishedName -TargetPath $DisabledUserOU
    
    }
    
    else 
    {
        ### Please forgive my humor on an early attempt. I chose to leave it here, and hope that it only reflects positively on my willingness to try new things.
        Write-Host "You sure? Because I didn't script this well enough, so now you have to go back and start from scratch."
    }
