#!/bin/bash

# Must be run as root or with sudo
if [[ $EUID -ne 0 ]]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

echo "Fetching latest Docker Compose version..."
VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]+')

if [ -z "$VERSION" ]; then
  echo "❌ Failed to retrieve latest Docker Compose version."
  exit 1
fi

echo "Latest version is: $VERSION"
DEST=/usr/local/bin/docker-compose

echo "📦 Downloading Docker Compose $VERSION..."
curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o $DEST

if [ $? -ne 0 ]; then
  echo "❌ Download failed. The URL may not exist."
  exit 1
fi

echo "🔧 Making it executable..."
chmod +x $DEST

echo "✅ Installed Docker Compose version:"
docker-compose --version
