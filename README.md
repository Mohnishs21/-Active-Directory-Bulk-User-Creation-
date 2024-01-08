# Active Directory Bulk User Creation

This repository contains PowerShell scripts and resources for automating the bulk creation of users in Active Directory.

## Features

Efficient user creation: Generates a specified number of users with random names and passwords (optional).
Customizable attributes: Specifies user attributes such as organizational unit, password complexity, and more.
Parallel processing: Leverages multithreading for potentially faster user creation (PowerShell 3.0 or later).
Error handling: Includes basic error handling to aid in troubleshooting.
## Requirements

Windows PowerShell: Version 3.0 or later recommended for parallel processing.
Active Directory Module: Install using Install-Module ActiveDirectory.
Domain Administrator Permissions: Required to create users in Active Directory.
## Usage

Clone the repository:
git clone https://github.com/Mohnishs21/-Active-Directory-Bulk-User-Creation-
Open a PowerShell window: Run as administrator.
Navigate to the repository directory:
cd -Active-Directory-Bulk-User-Creation-
Run the script:
.\demo.ps1 for test
or full function on gentrate ramdom names.ps1
Follow the prompts: Provide inputs for the number of users, password requirements, and other settings.
## Configuration
Customize script parameters: Adjust variables within the demo.ps1 script to tailor user creation settings.
## Additional Information
Contributions: Welcome! Please submit pull requests or open issues for suggestions and improvements.
## Contact
Mohnishsaxena21@gmail.com
