#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating package lists..."
sudo apt update && sudo apt upgrade -y

echo "Installing XFCE4 and essential goodies..."
sudo apt install -y xfce4 xfce4-goodies xserver-xephyr

echo "Setup complete! You can now use your run script to start the environment."