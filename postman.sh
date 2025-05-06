#!/bin/bash

# Update the system and install required dependencies
echo "Updating system and installing dependencies..."
sudo apt update && sudo apt install -y wget libgconf-2-4

# Download Postman from the official source (check for the latest version URL)
echo "Downloading Postman..."
wget https://dl.pstmn.io/download/latest/linux -O postman.tar.gz

# Extract the downloaded tarball
echo "Extracting Postman..."
tar -xvzf postman.tar.gz

# Move Postman to /opt directory
echo "Moving Postman to /opt..."
sudo mv Postman /opt/Postman

# Create a symlink to make it easier to run Postman from the terminal
echo "Creating symlink for Postman..."
sudo ln -s /opt/Postman/Postman /usr/bin/postman

# Create a desktop shortcut (optional)
echo "Creating desktop shortcut..."
sudo bash -c 'cat > /usr/share/applications/postman.desktop <<EOF
[Desktop Entry]
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOF'

# Clean up downloaded tarball
echo "Cleaning up..."
rm postman.tar.gz

# Inform the user
echo "Postman installation is complete! You can now launch it by typing 'postman' in the terminal."
