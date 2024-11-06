# Suppression des utilisateurs et des groupes créés
function CleanUp {
    Write-Host "Cleaning up users and groups created in Site1..."

    $list = Get-ADUser -Filter 'Name -like "User*"'
    # Suppression des utilisateurs
    foreach ($username in $list) {
        Remove-ADUser -Identity $username.Name -Confirm:$false
        Write-Host "User $username has been removed."
    }
}
CleanUp
