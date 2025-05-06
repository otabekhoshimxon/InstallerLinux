#!/bin/bash

# Update system and install snap if it is not already installed
echo "Updating system and installing snapd..."
sudo apt update
sudo apt install -y snapd

# Install Postman via Snap
echo "Installing Postman via Snap..."
sudo snap install postman

# Inform the user
echo "Postman has been successfully installed via Snap. You can launch it by typing 'postman' in the terminal."
