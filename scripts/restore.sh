#!/bin/bash

# Restore script for inventory_db
# Usage: bash scripts/restore.sh <backup_file>

BACKUP_FILE=$1

if [ -z "$BACKUP_FILE" ]; then
    echo "Error: No backup file provided."
    echo "Usage: bash scripts/restore.sh <path_to_backup_file>"
    exit 1
fi

# Drop and recreate database
sudo -u postgres psql -c "DROP DATABASE IF EXISTS inventory_db;"
sudo -u postgres psql -c "CREATE DATABASE inventory_db;"

# Restore from backup
sudo -u postgres psql -d inventory_db < $BACKUP_FILE

echo "Restore completed from: $BACKUP_FILE"
