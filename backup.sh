#!/bin/bash

set -e

APP_DIR="/opt/myapp"
BACKUP_DIR="/tmp/project3-backups"
BUCKET="aws-project3-backups-ad"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/myapp_$TIMESTAMP.tar.gz"

echo "Starting backup..."

mkdir -p "$BACKUP_DIR"

tar --exclude="./venv" \
    --exclude="./backups" \
    -czf "$BACKUP_FILE" \
    -C "$APP_DIR" .

echo "Uploading backup to S3..."

aws s3 cp "$BACKUP_FILE" \
    "s3://$BUCKET/backups/" \
    --region ap-south-1

echo "Verifying S3 upload..."

aws s3api head-object \
    --bucket "$BUCKET" \
    --key "backups/$(basename "$BACKUP_FILE")" \
    --region ap-south-1

echo "Removing local temporary backup..."

rm -f "$BACKUP_FILE"

echo "BACKUP SUCCESS"