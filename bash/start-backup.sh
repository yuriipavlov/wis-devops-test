#!/bin/bash

# Stop when error
set -e

# Default mode
MODE="daily"
MODE_TIMER=6
# Backups folder
BACKUPS_DIR=~/backups
# WordPress root directory
WP_DIR=~/public

DATE_FILENAME=$(date +%Y-%m-%d)

# Parse args
if [ "$1" ] && ([ "$1" == "daily" ] || [ "$1" == "weekly" ]); then
    MODE="$1"
fi

if [ "$MODE" == "weekly" ]; then
    MODE_TIMER=30
fi


# Create backups directory (if not exist)
mkdir -p "$BACKUPS_DIR"
mkdir -p "$BACKUPS_DIR"/"$MODE"

# Create a backup of the WordPress files
cd "$WP_DIR"

# Make database backup via WP_CLI
wp --allow-root db export "$BACKUPS_DIR"/"$MODE"/database-"$DATE_FILENAME".sql

# Make uploads folder archive
tar -cf - -C wp-content/ uploads > "$BACKUPS_DIR"/"$MODE"/"$MODE"-"$DATE_FILENAME".tar

cd "$BACKUPS_DIR"/"$MODE"/

tar -rf "$MODE"-"$DATE_FILENAME".tar database-"$DATE_FILENAME".sql

rm database-"$DATE_FILENAME".sql

gzip -f "$MODE"-"$DATE_FILENAME".tar


# Check old files to delete
find "$BACKUPS_DIR"/"$MODE"/"$MODE"-* -mtime +$MODE_TIMER -delete

echo "[Success] [$MODE] Backup done $(date +%Y'-'%m'-'%d' '%H':'%M)"


# Optional: Upload the backup to remote storage (e.g., Amazon S3, Google Drive)
# Example: Use the AWS CLI to upload to Amazon S3
# aws s3 cp "$MODE"-"$DATE_FILENAME".tar.gz s3://your-s3-bucket/

# Optional: Send a notification (e.g., email) to confirm the backup
# Example: Send an email using the 'mail' command
# echo "WordPress backup completed on $(date)" | mail -s "WordPress Backup" your@email.com
