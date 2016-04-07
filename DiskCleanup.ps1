$StartDiskFree = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}

#Clear Recycle Bin
Remove-Item 'C:\$RecycleBin\*' -Recurse -WhatIf

Remove-Item 'C:\Windows\Installer\*' -Recurse

#$EndDiskFree = "15299767808"
$EndDiskFree = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.FreeSpace}
$Savings = $StartDiskFree - $EndDiskFree

#Turns values into human readable for output
$StartDiskFree = [math]::round($StartDiskFree / 1Gb, 2)
$EndDiskFree = [math]::round($EndDiskFree / 1Gb, 2)
$Savings = [math]::round($Savings / 1Gb, 2)
Write-Host "Space Free at Start: $StartDiskFree GB`r`nSpace Free at End $EndDiskFree GB`r`nSpace Reclaimed $Savings GB"