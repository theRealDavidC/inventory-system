#!/bin/bash

# Backup script for inventory_db
# Usage: bash scripts/backup.sh

DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR=~/inventory-backups
FILENAME="inventory_db_$DATE.sql"

# Create backup directory if it does not exist
mkdir -p $BACKUP_DIR

# Run backup
sudo -u postgres pg_dump inventory_db > $BACKUP_DIR/$FILENAME

echo "Backup completed: $BACKUP_DIR/$FILENAME"
