#!/bin/bash

# Abort on nonzero exitstatus
set -o errexit
# Abort on unbound variable 
set -o nounset
# Don't hide errors within pipes
set -o pipefail

# Update & upgrade
sudo apt update -y
sudo apt upgrade -y

# Install useful tools
sudo apt install -y jq kali-linux-everything kali-wallpapers-2020.4

# Install with suppressed prompts
sudo DEBIAN_FRONTEND=noninteractive apt install -y tor flameshot

# Create Firefox policies directory
sudo mkdir -p /etc/firefox/policies

# Apply Firefox extension policies
sudo tee /etc/firefox/policies/policies.json > /dev/null <<EOF
{
  "policies": {
    "Extensions": {
      "Install": [
        "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi",
        "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/addon-wappalyzer-latest.xpi",
        "https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi",
        "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      ]
    }
  }
}
EOF

# Clean up unused packages
sudo apt autoremove -y

# Clear bash history
history -c
unset HISTFILE
rm -f ~/.bash_history ~/.zsh_history

# Reboot the system
sudo reboot
