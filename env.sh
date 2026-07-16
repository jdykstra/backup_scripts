LOGDIR=/mnt/c/"BackupLogs"
LOGFILENAME=$LOGDIR/"$(date +"%F").log"

# Symbolic names for the volumes we want to back up.
JUNIPER=/mnt/c/
IMGARCH=/mnt/f/ 
VIDARCH=/mnt/g/
MISC=/mnt/j/
CATALOG=/mnt/n/
USERS=/mnt/c/Users/
MUSIC=/music/

# Local backup destination
DEST=remotebk@birch.local:/srv
