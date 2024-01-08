# Import the Active Directory module (only needed if not already imported)
Import-Module ActiveDirectory

# ----- Securely prompt for password with complexity check ----- #
$passwordComplexity = $false  # Set to $true if you want to enforce complexity
$passwordLength = 8  # Adjust as needed for your test environment
$passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}$"  # Example regex

do {
  $passwordForUsers = Read-Host -AsSecureString "Enter the password for new users (minimum $passwordLength characters, must meet complexity requirements if enabled):"
} while ($passwordComplexity -and -not ($passwordForUsers -match $passwordRegex))

# ----- Other variables for the test environment ----- #
$numberOfUsersToCreate = 10  # Create a smaller number for testing
$organizationalUnitName = "Test_OU"  # Use a dedicated test OU
$ouPath = "OU=$organizationalUnitName,DC=yourdomain,DC=com"  # Replace with your test domain

# ----- Function for generating random names (remains the same) ----- #
Function Generate-RandomName() {
  # ... (function code unchanged)
}

# ----- Create users in batches, potentially using parallel processing ----- #
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
