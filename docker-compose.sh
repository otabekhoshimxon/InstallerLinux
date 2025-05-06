#!/bin/bash

# Docker Compose install script for Linux (Kali)

# Step 1: Check and become root if not already
if [[ $EUID -ne 0 ]]; then
  echo "⚠️  This script must be run as root. Re-running with sudo..."
  exec sudo "$0" "$@"
fi

# Step 2: Get latest version number from GitHub
echo "📦 Fetching latest Docker Compose version..."
VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]+')

if [[ -z "$VERSION" ]]; then
  echo "❌ Could not retrieve the latest version from GitHub."
  exit 1
fi

echo "🔢 Latest version is $VERSION"

# Step 3: Download the binary to /usr/local/bin
DEST=/usr/local/bin/docker-compose
echo "⬇️  Downloading Docker Compose binary to $DEST..."

curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o $DEST

if [[ $? -ne 0 ]]; then
  echo "❌ Download failed."
  exit 1
fi

# Step 4: Make it executable
chmod +x $DEST

# Step 5: Verify installation
echo "✅ Verifying installation..."
docker-compose --version

# Step 6: (Optional) Create symlink for convenience if needed
if [[ ! -f /usr/bin/docker-compose ]]; then
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

echo "🎉 Docker Compose $VERSION has been successfully installed!"
