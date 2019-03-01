## Please check GitHub repository for updates to that script: https://github.com/bezibaerchen/activeroles

cls

## Define path to input file
$filepath = "<full path to file containing SAMAccountNames>"

## Define group name from which users should be removed
$GroupName = "<groupname>"

## get users from importfile
$users = get-content $FilePath


## Check if group exists, if not exit the script
if((Get-QADGroup -Proxy $GroupName) -eq $null)
{
Write-Error "Didnt find group $GroupName. Breaking script."
    break
}

## Connect to ARS
Connect-QADService -Proxy

$i=0

## loop through users and remove from group
foreach ($user in $users)
{
    #progress bar
    $i++
    Write-Progress -Activity "Working on Users" -Status "Currently working on $user." -PercentComplete ($i/$users.count*100)
    Remove-QADGroupMember -Identity $GroupName $user -Proxy
}
