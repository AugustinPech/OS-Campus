# Suppression des utilisateurs et des groupes créés
function CleanUp {
    Write-Host "Cleaning up users and groups created in Site1..."

    $list = Get-ADUser -Filter 'Name -like "User*"'
    # Suppression des utilisateurs
    foreach ($username in $list.Name) {
        Remove-ADUser -Identity $username -Confirm:$false
        Write-Host "User $username has been removed."
    }
    $groups = Get-ADGroup -Filter 'DistinguishedName -like "*T[0-2]*"' 
    # Suppression des groupes
    foreach ($group in $groups) {
        Remove-ADGroup -Identity $group -Confirm:$false
        Write-Host "Group $($group.Name) has been removed."
    }
}
CleanUp
