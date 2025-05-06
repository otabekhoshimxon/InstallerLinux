#!/bin/bash

# Re-run as root if needed
if [[ $EUID -ne 0 ]]; then
  echo "🔒 Root access required. Re-running with sudo..."
  exec sudo "$0" "$@"
fi

# Step 1: Create plugins directory
mkdir -p ~/.docker/cli-plugins/

# Step 2: Download latest release from GitHub
VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]+')
echo "📦 Latest version is $VERSION"

URL="https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)"
DEST=~/.docker/cli-plugins/docker-compose

echo "⬇️  Downloading Docker Compose plugin..."
curl -SL $URL -o $DEST

# Step 3: Make it executable
chmod +x $DEST

# Step 4: Test it
echo "✅ Installed version:"
docker compose version
