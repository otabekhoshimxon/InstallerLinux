#!/bin/bash

# Step 1: Update system and install snapd if not already installed
echo "Updating system and installing snapd..."
sudo apt update
sudo apt install -y snapd

# Step 2: Enable and start the snapd service to ensure it is running
echo "Enabling and starting snapd service..."
sudo systemctl enable --now snapd

# Step 3: Check if snapd service is running
echo "Checking snapd service status..."
sudo systemctl status snapd --no-pager

# Step 4: Install Postman via Snap
echo "Installing Postman via Snap..."
sudo snap install postman

# Step 5: Verify if Postman is installed successfully
if command -v postman &> /dev/null
then
    echo "Postman has been successfully installed. You can launch it by typing 'postman' in the terminal."
else
    echo "Error: Postman installation failed. Please check the logs for details."
fi

# Step 6: (Optional) Restart system if necessary
# echo "Rebooting system to finalize configuration..."
# sudo reboot
