#!/bin/bash

# --------------------------------------------------
# Script: backup_script.sh
# Author: Pritesh Kumar
# Purpose: Backup directories into compressed archive
# Usage:
# ./backup_script.sh /source/path /backup/location
# --------------------------------------------------

LOG_FILE="backup.log"

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

SOURCE=$1
DESTINATION=$2

if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source directory not found."
    exit 1
fi

mkdir -p "$DESTINATION"

BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

tar -czf "$DESTINATION/$BACKUP_NAME" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
    echo "File: $DESTINATION/$BACKUP_NAME"

    echo "$(date) | Backup successful | $BACKUP_NAME" >> "$LOG_FILE"
else
    echo "Backup failed."
    echo "$(date) | Backup failed" >> "$LOG_FILE"
fi