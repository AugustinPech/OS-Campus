$list=Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name -A
$toRemove= "Sites" , "T0" , "T1" , "T2"
foreach ($item in $list) {
    if ($toRemove -contains $item) {
        Write-Host "Removing $item"
        Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false -Identity $item
        Remove-ADOrganizationalUnit -Identity $item -Confirm:$false -Recursive
    }
}