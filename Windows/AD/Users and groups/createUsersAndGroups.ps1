$user1Attributes = @{
    Name="User1"
    Role="User"
    "Surname"="One"
    "Mail"="one@devops.forest"
    Enabled=$true
    AccountPassword=(Read-Host -AsSecureString "Enter password")
}
$devAttributes = @{
    Name="Developer"
    Role="Developer"
    "Surname"="Two"
    "Mail"="dev@devops.forest"
    Enabled=$true
    AccountPassword=(Read-Host -AsSecureString "Enter password")
}
$adminAttributes = @{
    Name="Admin"
    Role="Admin"
    "Surname"="Admin"
    "Mail"="support@devops.forest"
    Enabled=$true
    AccountPassword=(Read-Host -AsSecureString "Enter password")
}

$users= $user1Attributes, $devAttributes , $adminAttributes

New-ADGroup -Name "Admins" -SamAccountName Admins -GroupCategory Security -GroupScope Global -DisplayName "Administrators" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Administrators"
New-ADGroup -Name "Developers" -SamAccountName Developers -GroupCategory Security -GroupScope Global -DisplayName "Developers" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Developers"
New-ADGroup -Name "Users" -SamAccountName Users -GroupCategory Security -GroupScope Global -DisplayName "Users" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Users"

foreach ($user in $users) {
    New-ADUser $user
    if ($user.Role -eq "Admin") {
        Add-ADGroupMember -Identity Admins -Members $user.Name
    } elseif ($user.Role -eq "Developer") {
        Add-ADGroupMember -Identity Developers -Members $user.Name
    } else {
        Add-ADGroupMember -Identity Users -Members $user.Name
    }
}