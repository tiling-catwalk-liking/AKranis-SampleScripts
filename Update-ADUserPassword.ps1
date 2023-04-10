### Work in progress for changing an AD user password by putting in SAMAccountName and staff ID (to generate password)

$User = Read-Host -Prompt 'Enter username'
$StaffID = Read-Host -Prompt 'Enter Staff_ID #'
$NewPassword = 'Changeme!!!' + $StaffID

Set-ADAccountPassword -Identity $User -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $NewPassword -force)
Set-ADUser -Identity $User  -ChangePasswordAtLogon $true