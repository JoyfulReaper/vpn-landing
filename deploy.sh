#!/usr/bin/env bash
set -euo pipefail

APP_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SERVICE="vpn-landing.service"
BINARY="$APP_DIR/vpn-landing"
TMP_BINARY="$APP_DIR/.vpn-landing.new"

cd "$APP_DIR"

if [[ "$(id -u)" -eq 0 ]]; then
    echo "Run this as your normal user, not root." >&2
    exit 1
fi

echo "Updating repository..."
git pull --ff-only

echo "Running tests..."
go test ./...

echo "Building..."
rm -f "$TMP_BINARY"
trap 'rm -f "$TMP_BINARY"' EXIT

go build -trimpath -o "$TMP_BINARY" .
chmod 0755 "$TMP_BINARY"

echo "Installing binary..."
mv "$TMP_BINARY" "$BINARY"
trap - EXIT

echo "Restarting $SERVICE..."
sudo systemctl restart "$SERVICE"

echo "Checking service..."
sudo systemctl is-active --quiet "$SERVICE"

echo "Checking HTTP..."
curl -fsS --max-time 5 http://10.99.0.1:8081/ >/dev/null

echo
echo "VPN Landing deployed successfully."
echo "http://10.99.0.1:8081/"
