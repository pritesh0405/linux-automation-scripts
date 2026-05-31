#!/bin/bash

# -------------------------------------------------
# Script: disk_monitor.sh
# Purpose: Monitor filesystem usage and alert
# Author: Pritesh Kumar
# -------------------------------------------------

THRESHOLD=${1:-80}

echo "Disk Usage Report"
echo "================="

df -h | awk 'NR>1 {print $1,$5}' | while read filesystem usage
do
    percent=$(echo $usage | tr -d '%')

    if [ "$percent" -ge "$THRESHOLD" ]; then
        echo "WARNING: $filesystem is at $usage usage"
    else
        echo "OK: $filesystem is at $usage usage"
    fi
done