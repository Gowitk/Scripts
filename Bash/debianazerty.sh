#!/bin/bash

echo "XKBMODEL=\"pc105\"" | sudo tee -a /etc/default/keyboard > /dev/null
echo "XKBLAYOUT=\"be\"" | sudo tee -a /etc/default/keyboard > /dev/null
echo "XKBVARIANT=\"\"" | sudo tee -a /etc/default/keyboard > /dev/null
echo "XKBOPTIONS=\"\"" | sudo tee -a /etc/default/keyboard > /dev/null

# Reload keyboard configuration
sudo dpkg-reconfigure -u keyboard-configuration