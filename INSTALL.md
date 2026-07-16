$Action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c wsl.exe --mount \\.\PHYSICALDRIVE3 --bare"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest
Register-ScheduledTask -TaskName "WSL_Mount_Music_Drive" -Action $Action -Trigger $Trigger -Principal $Principal

sudo systemctl enable cron