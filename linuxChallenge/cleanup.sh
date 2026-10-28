#!/bin/bash

BACKUP_DIR="/home/faddu/BashScripting/linuxChallenge/devops/academy/backup"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: Backup directory does not exist"
    exit 1
fi

find "$BACKUP_DIR" -type f -mtime +7 -delete

echo "Cleanup completed"
