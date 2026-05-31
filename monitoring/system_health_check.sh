#!/bin/bash

# --------------------------------------------------
# Script: system_health_check.sh
# Purpose: Generate Linux System Health Report
# Author: Pritesh Kumar
# --------------------------------------------------

echo "======================================="
echo "         SYSTEM HEALTH REPORT"
echo "======================================="

echo ""

echo "Hostname      : $(hostname)"

echo "Kernel        : $(uname -r)"

echo "Current User  : $(whoami)"

echo ""

if command -v uptime >/dev/null 2>&1; then
    echo "Uptime        : $(uptime -p)"
else
    echo "Uptime        : Not Available"
fi

if command -v free >/dev/null 2>&1; then
    MEMORY=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')
    echo "Memory Usage  : ${MEMORY}%"
else
    echo "Memory Usage  : Not Available"
fi

echo "Disk Usage    : $(df -h / | awk 'NR==2 {print $5}')"

echo "Logged Users  : $(who | wc -l)"

echo ""

echo "======================================="
echo "Report Generated Successfully"
echo "======================================="