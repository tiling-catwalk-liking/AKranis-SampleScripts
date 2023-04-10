### The following script is intended to be used to create employee accounts using an exported CSV file from the SIS. All logic contained within is a function of how the SIS is used by staff and the features it provides.
### The CSV contains the information needed to create a user and add them to AD security groups.
### Running this scripts will prompt for the name of the CSV (location is hardcoded into the script) file and will proceed to iterate through all users provided.
###################################################
####  Define Functions to be used in script.
###
### The Add-UserADGroups function determines what AD security groups a user should be a member of and adds them as members.
function Add-UserADGroups {
    param (
        [string[]]$SAMAccountName,
        [string[]]$Department,
        [string[]]$Position,
        [string[]]$Campus
    )
### Below are standard Groups that a new AD User might be added to. There are more groups,
### however those would need to be added on an as needed basis at this time.    
$Location1 = 'Campus 1'
$Location2 = 'Campus 2'
$ECE = 'ECE'
$Elem = 'Elementary'
$Fin = 'Finance'
$FR_Location1 = 'FolderRedirection_Location1'
$FR_Location2 = 'FolderRedirection_Location2'
$Front_Off = 'Front Office'
$MidSch = 'Middle School'
$Pri = 'Principals'
$QB = 'QuickBooksUsers'
$SchAdm = 'SchoolAdministrators'
$Teachers = 'Teachers'
$ElemSch1 = 'ElementarySchool1'
$MiddleSchool1 = 'MiddleSchool1'
$MiddleSchool2 = 'MiddleSchool2'
### Array to store groups.
#### Set $G to null to remove the previous users group selection.
### Create an array to store groups to be added to.
$G = $null
$G = @()
### Using if statements, determine if user belongs in a given group and add to array.
if (($Campus -eq 'Campus1') -or ($Campus -eq 'Both') -or ($Campus -eq 'Off Campus'))
  {
     $G += $FR_Location1
  }

if ($Campus -eq 'Campus1')
  {
     $G += $Location1
  }

if ($Campus -eq 'Both')
  {
     $G += $Location1
     $G += $Location2
  }

if ($Campus -eq 'Campus2')
  {
     $G += $FR_Location2
     $G += $Location2
  }

if (($Position -like '*Account*') -or ($Department -like 'Financial'))
  {
     $G += $Front_Off
     $G += $Fin
     $G += $QB
  }

  if (($Position -like '*Principal*') -or ($Position -Like '*Head of School*') -or ($Position -like '*studies director*') `
  -or ($Position -like '*Preschool Director*') -Or ($Position -like '*Development*'))
  {
     $G += $Pri
     $G += $SchAdm
  }

  if (($Position -like "*Admin*") -or ($Department -like "*Admin*") -or ($Position -like '*secretary*') `
  -or ($Position -like '*office*') -or ($Department -like '*Office*'))
  {
     $G += $Front_Off 
  }

  if (($Position -like '*teach*') -or ($Position -like '*rebbi*') -or ($Position -like '*resource*') `
  -or ($Position -like '*tutor*') -or ($Position -like '*roam*') -or ($Position -like '*sub*') `
  -or ($Position -like '*coach*') -or ($Position -like '*morah*'))

  {
     $G += $Teachers
  }

  if (($Department -like '*elem*') -or ($Position -like '*Head of School*') -or ($Position -like '*Educational Advisor*') `
  -or ($Position -like '*ElemSch1*'))
  {
     $G += $Elem
     $G += $ElemSch1
  }

  if (($Department -like '*ece*') -or ($Position -like '*Head of School*') -or ($Position -like '*Educational Advisor*') `
  -or ($Position -like '*ece*') -or ($Department -like '*preschool*'))
  {
     $G += $ECE
     $G += $ElemSch1
  }

  if (($Department -like '*MiddleSchool2*') -or ($Position -like '*Head of School*') -or ($Position -like '*Educational Advisor*') `
  -or ($Position -like '*MiddleSchool2*'))
  {
     $G += $MiddleSchool2
     $G += $MidSch
  }

  if (($Department -like '*MiddleSchool1*') -or ($Position -like '*Head of School*') -or ($Position -like '*Educational Advisor*') `
  -or ($Position -like '*MiddleSchool1*'))
  {
     $G += $MiddleSchool1
     $G += $MidSch
  }
### Add user to groups.  
  $ADUser = Get-ADUser -Identity "$SamAccountName"
  Write-Host "Groups are $G"
  Add-ADPrincipalGroupMembership -Identity $ADUser -MemberOf $G
}
### The Check-SAMAccountName function tests for an available username.
Function Check-SAMAccountName {
    ### The $Incrementor variable (typed as an integer) will be used to append a number as needed.
    [int]$Incrementor = 0
    ### $DesiredSamAccountName will be used as the potential SAM Account Names to test.
    ### $OrigDesiredSAM will be the first possible account name to test. This is first initial + last name. eg. John Doe would be jdoe.
    $DesiredSamAccountName = $OrigDesiredSAM
    ### A loop will be used to find the first available SAM account name.
    ### Try catch will be used to search for existing names. An error will be thrown if the name does not
    ### exist, thus allowing us to determine if the account name may be used.
    do
    {
        
        try
        {
            Get-ADUser -Identity $DesiredSamAccountName
            $UsernameFree = $false
        }
        
        catch  
        {
            $UsernameFree = $true
        }
    ### An if else statement will determine if an incremented number must be appended.
    ### Each time the loop tests the SAM account name it will increment the number until
    ### the $UsernameFree variable tests as true.
        if ($UsernameFree -eq $false)
        {
            $Incrementor = ($Incrementor + 1)
            $DesiredSamAccountName = $OrigDesiredSAM + $Incrementor
        }
    
        if ($UsernameFree -eq $true)
        {
            $Global:SAM = $DesiredSamAccountName
        }
        
    } until ($UsernameFree -eq $true)
    
	Write-Host "The first username available is $Global:SAM"

    }
###################################
###################################
Import-Module ActiveDirectory
#
### Profile paths for home directory.
#
$Location1Profiles = '\\ad.contoso.com\FileShare\FolderRedirection_Profiles_Location1\'
$Location2Profiles = '\\ad.contoso.com\FileShare\FolderRedirection_Profiles_Location2\'
#
### OU paths for $User.Path | These are the paths to the OU's users may be placed in.
#
$OU_Admin = 'OU=Admins,OU=Users,OU=ad.contoso.com,DC=ad,DC=contoso,DC=com'
$OU_Office = 'OU=Office,OU=Users,OU=ad.contoso.com,DC=ad,DC=contoso,DC=com'
$OU_Teachers_Location1 = 'OU=Location1,OU=Teachers,OU=Users,OU=ad.contoso.com,DC=ad,DC=contoso,DC=com'
$OU_Teachers_Location2 = 'OU=Location2,OU=Teachers,OU=Users,OU=ad.contoso.com,DC=ad,DC=contoso,DC=com'
#
### Import CSV containing user information. The CSV for this script is an export from the SIS and contains the needed fields to complete the import.
#
$CSV = Read-Host -Prompt 'Enter CSV File Name (eg. AD-UserImport_01012021)'
$Users = Import-csv "D:\AD_Imports\$CSV.csv"
### Iterate through each line in the CSV to create accounts.
ForEach($User in $Users)
	{
### Check to see what campus the user is on. Assign HomeDirectory path accordingly.
### All users not strictly based on Location2 campus will have profiles stored on Location1 campus.
		if ($User.Campus -eq 'Campus2')
		{
		$HomeDirectory = $Location2Profiles
		}
		
		else 
		{
		$HomeDirectory = $Location1Profiles
		}
### The OU that the user is placed in will be determined based upon their role.
### If the user is listed as an Admin or if their role has the word Admin (such as an Admin Asst), they will be in the Admins OU.
### If the user has a role that includes Office responsibilites (as indicated in Staff Group [Department in this script] in SIS, they will be in the Office OU.
		if ($User.Department -like 'Admin*')
		{
		$Path = $OU_Admin
		}
		
		elseif ($User.Position -like '*admin*')
		{
		$Path = $OU_Admin
		}
		
		elseif ($User.Department -like '*financ*') 
		{
			$Path = $OU_Admin
		}

		elseif ($User.Department -like '*office*')
		{
		$Path = $OU_Office
		}
		
		else
			{
		
				if ($HomeDirectory -eq $Location1Profiles)
				{
				$Path = $OU_Teachers_Location1
				}
		
				if ($HomeDirectory -eq $Location2Profiles)
				{
				$Path = $OU_Teachers_Location2
				}
			}
		
		$Password = (ConvertTo-SecureString -AsPlainText ('Changeme!!!' + $User.IdNum) -Force)
		$Name = $User.'First Name' + " " + $User.'Last Name'
		$FirstInitial = $User.'First Name'.Substring(0,1)
		$OrigDesiredSAM = $FirstInitial + $User.'Last Name'
		Check-SAMAccountName
		$SAM = $Global:SAM
		$HomeDirectory = $HomeDirectory + $SAM

### Add values to hash table for account creation.
		$Parameters = @{
			'EmployeeNumber'        = $User.IdNum
			'GivenName'             = $User.'First Name'
			'Surname'               = $User.'Last Name'
			'SamAccountName'        = $SAM
			'UserPrincipalName'     = $SAM + '@ad.contoso.com'
			'AccountPassword'       = $Password
			'DisplayName'           = $User.'Goes By'
			'Name'                  = $Name
			'EmailAddress'          = $User.Email
			'ChangePasswordAtLogon' = $true     
			'Enabled'               = $true 
			'Path'                  = $Path
			'Title'                 = $User.Position
			'Department'            = $user.Department
			'HomeDrive'             = 'H:'
			'HomeDirectory'		  	= $HomeDirectory
       }
### Create new user.
		New-ADUser @Parameters
      Write-Host "Created user $SAM"
### Add user to relevant groups using Add-UserADGroups funtion.   
      Add-UserADGroups -SAMAccountName $SAM -Department $User.Department -Position $user.Position `
      -Campus $User.Campus
	}