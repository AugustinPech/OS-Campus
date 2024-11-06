$list=Get-ADOrganizationalUnit -Filter 'Name -like "*"'
$toRemove= "Sites" , "T0" , "T1" , "T2"
foreach ($item in $list) {
    if ($toRemove -contains $item.Name) {
        Write-Host "Removing $item.Name"
        Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false -Identity $item.Name
        Remove-ADOrganizationalUnit -Identity $item.Name -Confirm:$false -Recursive
    }
}