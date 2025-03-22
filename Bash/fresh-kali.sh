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

sudo mkdir -p /etc/firefox/policies

sudo tee /etc/firefox/policies/policies.json > /dev/null <<EOF
{
  "policies": {
    "Extensions": {
      "Install": [
        "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi",
        "https://addons.mozilla.org/firefox/downloads/latest/wappalyzer/addon-wappalyzer-latest.xpi"
      ]
    }
  }
}
EOF


# Keep at end
sudo apt autoremove -y
