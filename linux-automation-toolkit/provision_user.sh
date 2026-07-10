#!/bin/bash

# provision_user.sh
# Automates creation of a new user, adds them to a specified group,
# and ensures correct ownership/permissions on their home directory.

# Usage: ./provision_user.sh <username> <groupname>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <groupname>"
    exit 1
fi

USERNAME=$1
GROUPNAME=$2

# Create the group if it doesn't already exist
if ! getent group "$GROUPNAME" > /dev/null 2>&1; then
    echo "Creating group: $GROUPNAME"
    sudo groupadd "$GROUPNAME"
else
    echo "Group $GROUPNAME already exists, skipping creation."
fi

# Create the user with a home directory
if ! id "$USERNAME" > /dev/null 2>&1; then
    echo "Creating user: $USERNAME"
    sudo useradd -m "$USERNAME"
else
    echo "User $USERNAME already exists, skipping creation."
fi

# Add user to the group
echo "Adding $USERNAME to $GROUPNAME"
sudo usermod -aG "$GROUPNAME" "$USERNAME"

# Set ownership and permissions on home directory
echo "Setting ownership and permissions on /home/$USERNAME"
sudo chown -R "$USERNAME":"$GROUPNAME" "/home/$USERNAME"
sudo chmod 750 "/home/$USERNAME"

echo "Done. $USERNAME provisioned and added to $GROUPNAME."
