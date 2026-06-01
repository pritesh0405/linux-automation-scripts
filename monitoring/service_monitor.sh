#!/bin/bash

# --------------------------------------------------
# Script: service_monitor.sh
# Author: Pritesh Kumar
# Purpose: Monitor Linux services
# Usage:
# ./service_monitor.sh sshd
# --------------------------------------------------

LOG_FILE="service_monitor.log"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

SERVICE=$1

if systemctl is-active --quiet "$SERVICE"
then
    echo "OK: $SERVICE is running"

    echo "$(date) | $SERVICE running" >> "$LOG_FILE"
else
    echo "WARNING: $SERVICE is NOT running"

    echo "$(date) | $SERVICE stopped" >> "$LOG_FILE"

    echo "Attempting restart..."

    systemctl restart "$SERVICE"

    if systemctl is-active --quiet "$SERVICE"
    then
        echo "SUCCESS: $SERVICE restarted"
    else
        echo "FAILED: Unable to restart $SERVICE"
    fi
fi