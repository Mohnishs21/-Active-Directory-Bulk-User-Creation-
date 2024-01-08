# Import the Active Directory module
Import-Module ActiveDirectory

# ----- Securely prompt for password with complexity check ----- #
$passwordComplexity = $true  # Set to $false if not required
$passwordLength = 12  # Adjust as needed
$passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}$"  # Example regex

do {
    $passwordForUsers = Read-Host -AsSecureString "Enter the password for new users (minimum $passwordLength characters, must meet complexity requirements if enabled):"
} while ($passwordComplexity -and -not ($passwordForUsers -match $passwordRegex))

# ----- Other variables ----- #
$numberOfUsersToCreate = 800
$organizationalUnitName = "_EMPLOYEES"  # Adjust OU name if needed
$ouPath = "OU=$organizationalUnitName,$(([ADSI]"").distinguishedName)"

# ----- Function for generating random names ----- #
Function Generate-RandomName() {
    # ... (function code remains the same)
}

# ----- Create users in batches, potentially using parallel processing ----- if encounter erroe due to parallel ($usersToCreate = 1..$numberOfUsersToCreate | ForEach-Object {
})# 
$usersToCreate = 1..$numberOfUsersToCreate | ForEach-Object -Parallel {
    $firstName = Generate-RandomName
    $lastName = Generate-RandomName
    $username = $firstName + '.' + $lastName
    New-Object -TypeName PSObject -Property @{
        Name = $username
        GivenName = $firstName
        Surname = $lastName
        DisplayName = $username
        EmployeeID = $username
        AccountPassword = $passwordForUsers
        Path = $ouPath
        Enabled = $true
        # Add other desired user attributes here
    }
} | ForEach-Object { New-ADUser $_ -ErrorAction Stop }  # Create users sequentially after parallel generation
