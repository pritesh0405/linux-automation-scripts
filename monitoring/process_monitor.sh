#!/bin/bash

# --------------------------------------------------
# Script: process_monitor.sh
# Author: Pritesh Kumar
# Purpose: Monitor Linux processes
# Usage:
# ./process_monitor.sh java
# --------------------------------------------------

LOG_FILE="process_monitor.log"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

PROCESS=$1

COUNT=$(pgrep -c "$PROCESS")

echo "================================="
echo "Process Monitoring Report"
echo "================================="
echo "Process Name : $PROCESS"
echo "Instances    : $COUNT"
echo "Generated At : $(date)"
echo "================================="

if [ "$COUNT" -eq 0 ]; then
    echo "WARNING: Process not running"

    echo "$(date) | $PROCESS not running" >> "$LOG_FILE"

    exit 1
else
    echo "OK: Process running"

    echo "$(date) | $PROCESS running ($COUNT instances)" >> "$LOG_FILE"

    exit 0
fi