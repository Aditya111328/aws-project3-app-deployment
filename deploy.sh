#!/bin/bash

set -e

APP_DIR="/opt/myapp"
SERVICE="myapp"
VENV="$APP_DIR/venv/bin"

echo "Starting deployment..."

cd "$APP_DIR"

echo "Pulling latest code..."
git pull origin main

echo "Installing dependencies..."
"$VENV/pip" install -r requirements.txt

echo "Restarting application..."
sudo -n /usr/bin/systemctl restart myapp

echo "Checking application status..."
sudo -n /usr/bin/systemctl is-active myapp

echo "Checking health endpoint..."
sleep 2
curl -f http://127.0.0.1:5000/health

echo ""
echo "DEPLOYMENT SUCCESS"