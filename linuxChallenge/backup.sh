#!/bin/bash

PROJECT_DIR="/home/faddu/BashScripting/linuxChallenge/devops/academy/project"
BACKUP_DIR="/home/faddu/BashScripting/linuxChallenge/devops/academy/backup"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory does not exist: $PROJECT_DIR"
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR" || {
        echo "Error: Could not create backup directory."
        exit 1
    }
fi

if tar -czvf "$BACKUP_DIR/project_backup.tar.gz" "$PROJECT_DIR"; then
    echo "Backup successful"
else
    echo "Error: Backup failed."
    exit 1
fi
