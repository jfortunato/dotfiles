#!/usr/bin/env bash

# The remote host should first boot into the NixOS installer, and set a password for the "nixos" user
# via `passwd`. The remote host will also need to connect to a network so we can reach it via SSH.

# Ensure the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <hostname> <target-host-ip>"
    exit 1
fi

HOSTNAME=$1
TARGET_HOST_IP=$2
LOCAL_PW_FILE=/tmp/secret.key
REMOTE_PW_FILE=/tmp/secret.key

# Verify that the target host is reachable
echo "Testing connection to target host..."
ssh -o "ConnectTimeout=5" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" "nixos@$TARGET_HOST_IP" "echo 'Connection successful'" || exit 1
echo "You will be prompted again for the password during the installation process."

# Prompt for the disk encryption password, and store it in a temporary file
echo -n "Enter disk encryption password: "
read -s DISK_ENCRYPTION_PASSWORD
echo
echo -n "Confirm disk encryption password: "
read -s DISK_ENCRYPTION_PASSWORD_CONFIRM
echo

if [ "$DISK_ENCRYPTION_PASSWORD" != "$DISK_ENCRYPTION_PASSWORD_CONFIRM" ]; then
    echo "Passwords do not match"
    exit 1
fi

echo "$DISK_ENCRYPTION_PASSWORD" > "$LOCAL_PW_FILE"

# Warn and confirm the user before proceeding
echo ""
echo ""
echo ""
echo "WARNING: This script will install NixOS on the target host, and will erase all data on the target host's primary disk."
echo -n "Do you want to proceed? [y/N]: "
read -r CONFIRMATION

if [ "$CONFIRMATION" != "y" ]; then
    echo "Aborting"
    exit 1
fi

nix run github:nix-community/nixos-anywhere -- \
    --flake ".#$HOSTNAME" \
    --target-host "nixos@$TARGET_HOST_IP" \
    --disk-encryption-keys "$LOCAL_PW_FILE" "$REMOTE_PW_FILE"
