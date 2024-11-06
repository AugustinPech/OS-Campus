$user1Attributes = @{
    Name = "User1"
    Role = "User"
}
$devAttributes = @{
    Name = "Developer"
    Role = "Developer"
}
$adminAttributes = @{
    Name = "Admin"
    Role = "Admin"
}

$users= $user1Attributes, $devAttributes , $adminAttributes

# New-ADGroup -Name "Admins" -SamAccountName Admins -GroupCategory Security -GroupScope Global -DisplayName "Administrators" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Administrators"
# New-ADGroup -Name "Developers" -SamAccountName Developers -GroupCategory Security -GroupScope Global -DisplayName "Developers" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Developers"
# New-ADGroup -Name "Users" -SamAccountName Users -GroupCategory Security -GroupScope Global -DisplayName "Users" -Path "CN=Users,DC=devops,DC=forest" -Description "Members of this group are Users"

foreach ($user in $users) {

    Remove-ADUser -Identity $user.Name -Confirm:$false
    
}

