#Functions
function Clean
{
    Remove-Item $args[0] -Recurse -Force -ErrorAction SilentlyContinue
}

#Main
$StartDiskFree = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}

#Clear Windows Installer Directory
Clean 'C:\Windows\Installer\*'

#Clear Windows Temp Folder
Clean 'C:\Windows\temp\*'

#Clear Windows Logs
Clean 'C:\Windows\logs\*'

#Clear Windows Update Cache
Stop-Service wuauserv
Clean 'C:\Windows\SoftwareDistribution\*'
Start-Service wuauserv

#Clear Temp Folders
Clean 'C:\temp\*'
clean $env:temp

#$EndDiskFree = "15299767808"
$EndDiskFree = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}
$Savings = $EndDiskFree - $StartDiskFree

#Turns values into human readable for output
$StartDiskFree = [math]::round($StartDiskFree / 1Gb, 2)
$EndDiskFree = [math]::round($EndDiskFree / 1Gb, 2)
$Savings = [math]::round($Savings / 1Gb, 2)
Write-Host "Space Free at Start: $StartDiskFree GB`r`nSpace Free at End $EndDiskFree GB`r`nSpace Reclaimed $Savings GB"