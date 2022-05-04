$users = Get-ADUser -Filter * -Properties GivenName,Surname,EmployeeID

$list = foreach ($u in $users) {
    if ( $u.GivenName -and $u.Surname -and $u.EmployeeID ) {
        $givenName = $u.GivenName.Substring(0,1).ToLower()
        $surname = $(if ($u.Surname.Length -gt 3) {$u.surname.Substring(0,3)} else {$u.surname}).ToLower()
        $employeeID = $u.EmployeeID.Substring($u.employeeID.Length-4,4)

        [PSCustomObject]@{
            samAccountName = $u.samAccountname
            password = "$givenName*$surname#$employeeID!"
        }
    }
}

$list | Export-Csv -NoTypeInformation passwords.csv
