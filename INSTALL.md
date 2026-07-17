# Manual Installation Steps

1. Create a scheduled task that runs at login to mount the drive containing the ext4 music partition.  From a terminal with administrative privileges:

    ```
    $Action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c wsl.exe --mount \\.\PHYSICALDRIVE3 --bare"
    $Trigger = New-ScheduledTaskTrigger -AtLogOn
    $Principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest
    Register-ScheduledTask -TaskName "WSL_Mount_Music_Drive" -Action $Action -Trigger $Trigger -Principal $Principal
    ```

1. Enable cron on WSL:
    ```
    sudo systemctl enable cron
    ```

1. Insert this line in /etc/crontab to start the backup every 30 minutes:
    ```
    0-59/30 * * * * jwd /usr/bin/flock -n /var/lock/backup-script.lock -c /home/jwd/backup-scripts/do-all-backups
    ```

