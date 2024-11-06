# Suppression des utilisateurs et des groupes créés
function CleanUp {
    Write-Host "Cleaning up users and groups created in Site1..."

    $list = Get-ADUser -Filter 'Name -like "User*"' -SearchBase "OU=Users,OU=Site1,OU=Sites,OU=T2,DC=devops,DC=forest"
    
    # Suppression des utilisateurs
    foreach ($username in $list) {
        Remove-ADUser -Identity $username -Confirm:$false
        Write-Host "User $username has been removed."
    }
}
