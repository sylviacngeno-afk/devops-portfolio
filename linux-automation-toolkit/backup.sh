#!/bin/bash

# backup.sh
# Creates a timestamped tar.gz backup of a specified directory.

# Usage: ./backup.sh <directory_to_backup> <backup_destination>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory_to_backup> <backup_destination>"
    exit 1
fi

SOURCE_DIR=$1
DEST_DIR=$2
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$(basename "$SOURCE_DIR")_$TIMESTAMP.tar.gz"

# Check source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: source directory $SOURCE_DIR does not exist."
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Create the backup
sudo tar -czf "$DEST_DIR/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

if [ $? -eq 0 ]; then
    echo "Backup created: $DEST_DIR/$BACKUP_NAME"
else
    echo "Backup failed."
    exit 1
fi
