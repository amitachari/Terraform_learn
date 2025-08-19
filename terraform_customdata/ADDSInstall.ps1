# Run as Administrator

# Variables
$DomainName = "corp.local"           # Replace with your domain name
$SafeModeAdminPassword = (ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force)  # DSRM password

# Install ADDS Role
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Import ADDS Module
Import-Module ADDSDeployment

# Promote Server as Domain Controller (create new forest)
Install-ADDSForest `
    -DomainName $DomainName `
    -SafeModeAdministratorPassword $SafeModeAdminPassword `
    -DomainNetbiosName "CORP" `
    -InstallDns `
    -Force `
    -NoRebootOnCompletion:$false
