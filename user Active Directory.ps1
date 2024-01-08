# Import the Active Directory module once at the beginning
Import-Module ActiveDirectory

# ----- Edit these variables for your use case ----- #
$passwordForUsers = Read-Host -AsSecureString "Enter the password for new users:"
$userListFile = "C:\path\to\your\names.txt"  # Specify full path to the list of names
$organizationalUnitName = "NewUsers"  # Adjust the OU name if needed
# ------------------------------------------------------ #

# Read user data from the file efficiently
$userList = Get-Content $userListFile -ReadCount 0  # Read all lines at once

# Create the OU if it doesn't exist, using a more concise syntax
New-ADOrganizationalUnit -Name $organizationalUnitName -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue

# Create users in a streamlined loop
foreach ($name in $userList) {
    $nameParts = $name.Split(" ")
    $firstName = $nameParts[0].ToLower()
    $lastName = $nameParts[1].ToLower()
    $username = "$($firstName.Substring(0,1))$($lastName)".ToLower()

    # Create the user with optimized cmdlet usage
    New-ADUser -Name "$username" -GivenName $firstName -Surname $lastName -DisplayName "$username" -SamAccountName "$username" -EmployeeID "$username" -Path "OU=$organizationalUnitName" -AccountPassword $passwordForUsers -Enabled $true -ErrorAction Stop

    Write-Host "Created user: $username" -BackgroundColor Black -ForegroundColor Cyan
}
