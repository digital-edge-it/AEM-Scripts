Copy-Item -Force "D:\INFINITY\iBackup\dbbak.ibu" "D:\Weekly Infinity Backup\dbbak.ibu"
$FileDate = [datetime](Get-ItemProperty -Path "D:\Weekly Infinity Backup\dbbak.ibu" -Name LastWriteTime).lastwritetime
write-host "The file date on D:\Weekly Infinity Backup\dbbak.ibu is " $FileDate
