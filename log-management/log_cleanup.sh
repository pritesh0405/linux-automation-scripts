#!/bin/bash

# --------------------------------------------------
# Script: log_cleanup.sh
# Author: Pritesh Kumar
# Purpose: Remove old log files and reclaim disk space
# Usage: ./log_cleanup.sh <directory> <retention_days>
# Example: ./log_cleanup.sh /var/log 30
# --------------------------------------------------

LOG_FILE="cleanup.log"

# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <retention_days>"
    exit 1
fi

TARGET_DIR=$1
RETENTION_DAYS=$2

# Check if directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Validate retention days
if ! [[ "$RETENTION_DAYS" =~ ^[0-9]+$ ]]; then
    echo "Error: Retention days must be numeric."
    exit 1
fi

echo "========================================"
echo "          LOG CLEANUP REPORT"
echo "========================================"
echo "Directory       : $TARGET_DIR"
echo "Retention Days  : $RETENTION_DAYS"
echo

# Find matching log files
FILES=$(find "$TARGET_DIR" -type f -name "*.log" -mtime +"$RETENTION_DAYS")

FILE_COUNT=$(echo "$FILES" | grep -c .)

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No log files found for cleanup."
    exit 0
fi

# Calculate total size before deletion
TOTAL_SIZE=$(find "$TARGET_DIR" -type f -name "*.log" -mtime +"$RETENTION_DAYS" -exec du -ch {} + 2>/dev/null | tail -1 | awk '{print $1}')

echo "Files Found      : $FILE_COUNT"
echo "Space To Recover : $TOTAL_SIZE"
echo

echo "Files Scheduled For Deletion:"
echo "--------------------------------"

find "$TARGET_DIR" -type f -name "*.log" -mtime +"$RETENTION_DAYS" -print

echo
read -p "Proceed with deletion? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "Operation cancelled."
    exit 0
fi

# Delete files
find "$TARGET_DIR" -type f -name "*.log" -mtime +"$RETENTION_DAYS" -delete

echo
echo "Cleanup Complete"
echo "Files Deleted    : $FILE_COUNT"
echo "Space Reclaimed  : $TOTAL_SIZE"

echo "$(date '+%Y-%m-%d %H:%M:%S') | Deleted $FILE_COUNT files | Reclaimed $TOTAL_SIZE" >> "$LOG_FILE"

echo
echo "Log written to: $LOG_FILE"

exit 0