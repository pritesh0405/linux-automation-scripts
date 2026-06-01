#!/bin/bash

# --------------------------------------------------
# Script: create_user.sh
# Author: Pritesh Kumar
# Purpose: Automate Linux user provisioning
# Usage:
# ./create_user.sh username group
# Example:
# ./create_user.sh john developers
# --------------------------------------------------

LOG_FILE="user_creation.log"

# Root check
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Please run as root."
    exit 1
fi

# Validate arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <group>"
    exit 1
fi

USERNAME=$1
GROUPNAME=$2

# Check if user exists
if id "$USERNAME" &>/dev/null; then
    echo "ERROR: User already exists."
    exit 1
fi

# Create group if missing
if ! getent group "$GROUPNAME" >/dev/null; then
    echo "Group does not exist. Creating group..."
    groupadd "$GROUPNAME"
fi

# Create user
useradd -m -g "$GROUPNAME" "$USERNAME"

# Generate random password
PASSWORD=$(openssl rand -base64 12)

echo "$USERNAME:$PASSWORD" | chpasswd

echo
echo "===================================="
echo "User Created Successfully"
echo "===================================="
echo "Username : $USERNAME"
echo "Group    : $GROUPNAME"
echo "Password : $PASSWORD"
echo "Home Dir : /home/$USERNAME"
echo "===================================="

echo "$(date) | Created user $USERNAME in group $GROUPNAME" >> "$LOG_FILE"

exit 0