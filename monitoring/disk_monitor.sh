#!/bin/bash

# --------------------------------------------------
# Script: disk_monitor.sh
# Author: Pritesh Kumar
# Purpose: Monitor filesystem utilization and alert
# Usage: ./disk_monitor.sh <threshold>
# Example: ./disk_monitor.sh 80
# --------------------------------------------------

LOG_FILE="disk_monitor.log"

# Validate input
if [ $# -gt 1 ]; then
    echo "Usage: $0 <threshold>"
    exit 1
fi

THRESHOLD=${1:-80}

if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Error: Threshold must be a number."
    exit 1
fi

echo "========================================"
echo "          DISK USAGE REPORT"
echo "========================================"
echo "Threshold: ${THRESHOLD}%"
echo

echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check started" >> "$LOG_FILE"

ALERT_FOUND=0

df -h | awk 'NR>1 {print $1,$5}' | while read -r filesystem usage
do
    percent=$(echo "$usage" | tr -d '%')

    if [ "$percent" -ge "$THRESHOLD" ]; then
        echo "WARNING: $filesystem is at $usage usage"
        echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING: $filesystem is at $usage" >> "$LOG_FILE"
        ALERT_FOUND=1
    else
        echo "OK: $filesystem is at $usage usage"
    fi
done

echo
echo "Report completed."
echo "$(date '+%Y-%m-%d %H:%M:%S') - Disk check completed" >> "$LOG_FILE"

exit 0
