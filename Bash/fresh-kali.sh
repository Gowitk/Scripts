#!/bin/bash

# Abort on nonzero exitstatus
set -o errexit
# Abort on unbound variable 
set -o nounset
# Don't hide errors within pipes
set -o pipefail

sudo apt update -y
sudo apt upgrade -y

# Add a choice menu
sudo apt install -y kali-linux-everything
sudo apt install -y kali-wallpapers-2020.4

sudo DEBIAN_FRONTEND=noninteractive apt install -y flameshot

# Keep at end
sudo apt autoremove -y
