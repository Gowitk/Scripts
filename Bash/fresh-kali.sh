#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Log path
SUMMARY_LOG="/var/log/setup.log"
DETAIL_LOG="/var/log/setup-details.log"

# Check on root
if [[ "$EUID" -ne 0 ]]; then
  echo "[!] This script must be run as root (sudo)." >&2
  exit 1
fi

# Logging function
log_summary() {
  GREEN="\e[32m"
  RESET="\e[0m"
  echo -e "${GREEN}[+] $1${RESET}"
  echo "[+] $1" >> "$SUMMARY_LOG"
}

run_quiet() {
  echo "[>] Running: $*" >> "$DETAIL_LOG"
  "$@" >> "$DETAIL_LOG" 2>&1
}

log_step() {
  log_summary "$1"
}

# Script start

log_step "Starting Kali setup"

log_step "Updating system"
run_quiet apt update -y
run_quiet apt full-upgrade -y
log_step "System updated"

log_step "Installing core packages"
run_quiet apt install -y jq flameshot tor kali-wallpapers-2020.4 kali-linux-everything
log_step "Packages installed"

log_step "Configuring Firefox extensions"
run_quiet mkdir -p /etc/firefox/policies

tee /etc/firefox/policies/policies.json > /dev/null <<EOF
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

log_step "Firefox extensions configured"

log_step "Cleaning up unused packages"
run_quiet apt autoremove -y
log_step "Cleanup done"

log_step "Clearing shell history"
history -c || true
unset HISTFILE
rm -f ~/.bash_history ~/.zsh_history
log_step "History cleared."

log_step "Setup complete. Rebooting system"
run_quiet reboot
