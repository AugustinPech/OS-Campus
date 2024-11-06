$list=Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name -A
foreach ($item in $list) {
    Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion $false -Identity $item
    Remove-ADOrganizationalUnit -Identity $item -Confirm:$false
}