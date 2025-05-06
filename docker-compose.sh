#!/bin/bash

# If not root, re-run script with sudo su -c
if [[ $EUID -ne 0 ]]; then
    echo "🔐 Switching to root using sudo su..."
    exec sudo su -c "$0"
fi

echo "🚀 Installing Docker Compose v2 plugin..."

# Create plugins directory if not exists
mkdir -p /usr/libexec/docker/cli-plugins

# Fetch latest version
VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]+')
echo "📦 Latest version: $VERSION"

# Download the binary
curl -SL "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/libexec/docker/cli-plugins/docker-compose

# Make it executable
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Symlink (optional)
ln -sf /usr/libexec/docker/cli-plugins/docker-compose /usr/bin/docker-compose

# Verify
echo "✅ Verifying installation..."
docker compose version || echo "❌ Something went wrong"

echo "🎉 Docker Compose v2 installed successfully!"
