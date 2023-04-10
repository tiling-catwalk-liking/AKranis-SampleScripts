<#
Zendesk Ticket # - $User asked that prior to me deleting all student accounts 
(to start with fresh ones). all their Drive files be saved.

The files are being moved so that they can be kept as a record, but without needing to keep the accounts.

1. Export the relevant account info from Google Admin
2. Iterate through it calling GAM to run the command to move the files
See the following resources:
https://sites.google.com/jis.edu.bn/gam-commands/services/drive#h.p_e5EXCxmr69c_
https://github.com/GAM-team/GAM/wiki/BulkOperations#bulk-operations-on-windows
https://www.reddit.com/r/sysadmin/comments/7pg2oc/powershell_gam_is_glorious/
#>

$Students = Import-Csv "C:\Users\user1\Downloads\Students_GsuiteAccounts.csv"

ForEach ($Student in $Students)
{
& "C:\GamADV-XTD3\gam.exe" user ($Student."Email Address [Required]") transfer drive user2@contoso.com
}