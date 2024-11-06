# Définir les groupes
New-ADGroup -Name "T0 Admins" -SamAccountName Admins -GroupCategory Security -GroupScope Global -DisplayName "Administrators" -Path "OU=Groups,OU=T0,DC=devops,DC=forest" -Description "Members of this group are Administrators"
New-ADGroup -Name "T0 Developers" -SamAccountName Developers -GroupCategory Security -GroupScope Global -DisplayName "Developers" -Path "OU=Groups,OU=T0,DC=devops,DC=forest" -Description "Members of this group are Developers"
New-ADGroup -Name "T0 Users" -SamAccountName Users -GroupCategory Security -GroupScope Global -DisplayName "Users" -Path "OU=Groups,OU=T0,DC=devops,DC=forest" -Description "Members of this group are Users"

New-ADGroup -Name "T1 Admins" -SamAccountName Admins -GroupCategory Security -GroupScope Global -DisplayName "Administrators" -Path "OU=Groups,OU=T1,DC=devops,DC=forest" -Description "Members of this group are Administrators"
New-ADGroup -Name "T1 Developers" -SamAccountName Developers -GroupCategory Security -GroupScope Global -DisplayName "Developers" -Path "OU=Groups,OU=T1,DC=devops,DC=forest" -Description "Members of this group are Developers"
New-ADGroup -Name "T1 Users" -SamAccountName Users -GroupCategory Security -GroupScope Global -DisplayName "Users" -Path "OU=Groups,OU=T1,DC=devops,DC=forest" -Description "Members of this group are Users"

New-ADGroup -Name "T2 Admins" -SamAccountName Admins -GroupCategory Security -GroupScope Global -DisplayName "Administrators" -Path "OU=Groups,OU=Site1,OU=Sites,OU=T2,DC=devops,DC=forest" -Description "Members of this group are Administrators"
New-ADGroup -Name "T2 Developers" -SamAccountName Developers -GroupCategory Security -GroupScope Global -DisplayName "Developers" -Path "OU=Groups,OU=Site1,OU=Sites,OU=T2,DC=devops,DC=forest" -Description "Members of this group are Developers"
New-ADGroup -Name "T2 Users" -SamAccountName Users -GroupCategory Security -GroupScope Global -DisplayName "Users" -Path "OU=Groups,OU=Site1,OU=Sites,OU=T2,DC=devops,DC=forest" -Description "Members of this group are Users"

# Créer les utilisateurs pour T0
$password = (ConvertTo-SecureString -AsPlainText "P@ssword123" -Force)
for ($i = 1; $i -le 10; $i++) {
    # Définir les attributs des utilisateurs
    $username = "User0$i"
    $role = if ($i -le 2) { "Admin" } elseif ($i -le 5) { "Developer" } else { "User" }
    $userAttributes = @{
        Name = $username
        GivenName = "FirstName0$i"
        Surname = "LastName0$i"
        SamAccountName = $username
        UserPrincipalName = "$username@devops.forest"
        Path = "OU=Users,OU=T0,DC=devops,DC=forest"
        AccountPassword = $password
        Enabled = $true
        PasswordNeverExpires = $false
        ChangePasswordAtLogon = $true
    }

    # Créer l'utilisateur
    New-ADUser @userAttributes

    # Ajouter l'utilisateur au groupe correspondant
    switch ($role) {
        "Admin" { Add-ADGroupMember -Identity "Admins" -Members $username }
        "Developer" { Add-ADGroupMember -Identity "Developers" -Members $username }
        "User" { Add-ADGroupMember -Identity "Users" -Members $username }
    }

    Write-Host "User $username with role $role created and added to the appropriate group."
}

# Créer les utilisateurs pour T1
$password = (ConvertTo-SecureString -AsPlainText "P@ssword123" -Force)
for ($i = 1; $i -le 10; $i++) {
    # Définir les attributs des utilisateurs
    $username = "User1$i"
    $role = if ($i -le 2) { "Admin" } elseif ($i -le 5) { "Developer" } else { "User" }
    $userAttributes = @{
        Name = $username
        GivenName = "FirstName0$i"
        Surname = "LastName0$i"
        SamAccountName = $username
        UserPrincipalName = "$username@devops.forest"
        Path = "OU=Users,OU=T1,DC=devops,DC=forest"
        AccountPassword = $password
        Enabled = $true
        PasswordNeverExpires = $false
        ChangePasswordAtLogon = $true
    }

    # Créer l'utilisateur
    New-ADUser @userAttributes

    # Ajouter l'utilisateur au groupe correspondant
    switch ($role) {
        "Admin" { Add-ADGroupMember -Identity "Admins" -Members $username }
        "Developer" { Add-ADGroupMember -Identity "Developers" -Members $username }
        "User" { Add-ADGroupMember -Identity "Users" -Members $username }
    }

    Write-Host "User $username with role $role created and added to the appropriate group."
}

# Créer les utilisateurs pour T2/Sites/Site1
$password = (ConvertTo-SecureString -AsPlainText "P@ssword123" -Force)
for ($i = 1; $i -le 10; $i++) {
    # Définir les attributs des utilisateurs
    $username = "User2$i"
    $role = if ($i -le 2) { "Admin" } elseif ($i -le 5) { "Developer" } else { "User" }
    $userAttributes = @{
        Name = $username
        GivenName = "FirstName0$i"
        Surname = "LastName0$i"
        SamAccountName = $username
        UserPrincipalName = "$username@devops.forest"
        Path = "OU=Users,OU=Site1,OU=Sites,OU=T2,DC=devops,DC=forest"
        AccountPassword = $password
        Enabled = $true
        PasswordNeverExpires = $false
        ChangePasswordAtLogon = $true
    }

    # Créer l'utilisateur
    New-ADUser @userAttributes

    # Ajouter l'utilisateur au groupe correspondant
    switch ($role) {
        "Admin" { Add-ADGroupMember -Identity "Admins" -Members $username }
        "Developer" { Add-ADGroupMember -Identity "Developers" -Members $username }
        "User" { Add-ADGroupMember -Identity "Users" -Members $username }
    }

    Write-Host "User $username with role $role created and added to the appropriate group."
}


# Activer ou désactiver un compte spécifique
function Set-UserStatus {
    param (
        [string]$Username,
        [bool]$Enable
    )
    if ($Enable) {
        Enable-ADAccount -Identity $Username
        Write-Host "User $Username has been enabled."
    } else {
        Disable-ADAccount -Identity $Username
        Write-Host "User $Username has been disabled."
    }
}

# Exemple d'activation ou désactivation
Set-UserStatus -Username "User09" -Enable $false  # Désactiver User3
Set-UserStatus -Username "User19" -Enable $true   # Activer User4
