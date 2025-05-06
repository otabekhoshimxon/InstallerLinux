#!/bin/bash

# Update system and install necessary dependencies
echo "Updating system and installing dependencies..."
sudo apt update
sudo apt install -y wget libgconf-2-4

# Download the latest Postman .tar.gz file from the official repository
echo "Downloading Postman..."
wget -q https://dl.pstmn.io/download/latest/linux -O /tmp/postman.tar.gz

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Postman downloaded successfully."
else
    echo "Error downloading Postman. Exiting script."
    exit 1
fi

# Extract the downloaded file
echo "Extracting Postman..."
tar -xzf /tmp/postman.tar.gz -C /opt

# Remove the downloaded tar.gz file
rm /tmp/postman.tar.gz

# Create a symlink for Postman to run from the terminal
echo "Creating symlink for Postman..."
sudo ln -s /opt/Postman/Postman /usr/bin/postman

# Optionally, create a desktop shortcut for Postman
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

# Final message
echo "Postman installation is complete! You can launch Postman by typing 'postman' in the terminal."
