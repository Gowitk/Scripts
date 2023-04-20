#!/bin/bash

# Update the package index
sudo apt update

# Install required packages
sudo apt install build-essential dkms linux-headers-$(uname -r)

# Mount the Guest Additions ISO file
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom

# Run the installer script
sudo sh /media/cdrom/VBoxLinuxAdditions.run

# Unmount the ISO file and remove the temporary directory
sudo umount /media/cdrom
sudo rmdir /media/cdrom

# Reboot the system to load the Guest Additions kernel modules
sudo reboot