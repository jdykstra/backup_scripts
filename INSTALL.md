# Manual Installation Steps

1. Create a scheduled task that runs at login to mount the drive containing the ext4 music partition.  From a terminal with administrative privileges:

    ```
    $Action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c wsl.exe --mount \\.\PHYSICALDRIVE3 --bare"
    $Trigger = New-ScheduledTaskTrigger -AtLogOn
    $Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest
    Register-ScheduledTask -TaskName "WSL_Mount_Music_Drive" -Action $Action -Trigger $Trigger -Principal $Principal
    ```

1. Create a scheduled task that runs every 30 minutes to do the backup.  From a terminal with administrative privileges:

    ```
    $LinuxUser = "jwd"
    $Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -NoProfile -Command `"Start-Process wsl.exe -ArgumentList '-e', '/bin/bash', '-l', '-c', '/home/$LinuxUser/backup_scripts/do-all-backups' -WindowStyle Hidden -Wait`""
    $Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30)
    $Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest
    $Settings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew

    Register-ScheduledTask -TaskName "WSL_Run_Backups" -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings -Force
    ```

