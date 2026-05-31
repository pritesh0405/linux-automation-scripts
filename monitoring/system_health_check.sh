#!/bin/bash

# --------------------------------------------------
# Script: system_health_check.sh
# Purpose: Generate a Linux system health report
# Author: Pritesh Kumar
# --------------------------------------------------

echo "======================================="
echo "         SYSTEM HEALTH REPORT"
echo "======================================="

# Hostname
HOSTNAME=$(hostname)

# Uptime
UPTIME=$(uptime -p)

# Memory Usage
MEMORY=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

# Root Disk Usage
DISK=$(df -h / | awk 'NR==2 {print $5}')

# Logged In Users
USERS=$(who | wc -l)

echo ""
echo "Hostname      : $HOSTNAME"
echo "Uptime        : $UPTIME"
echo "Memory Usage  : ${MEMORY}%"
echo "Disk Usage    : $DISK"
echo "Logged Users  : $USERS"
echo ""
echo "======================================="
echo "Report Generated Successfully"
echo "======================================="