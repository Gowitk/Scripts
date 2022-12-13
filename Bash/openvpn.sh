#! /bin/bash 

# Author: Jelle Van Holsbeeck <jelle.vanholsbeeck@outlook.com>

# Abort on nonzero exitstatus
set -o errexit
# Abort on unbound variable 
set -o nounset
# Don't hide errors within pipes
set -o pipefail

if [ "${#}" -gt 0 ]; then
    if [ "${1}" = "htb" ];then 
        sudo openvpn ~/openvpn/academy-regular.ovpn
    elif [ "${1}" = "thm" ];then 
        sudo openvpn ~/openvpn/DextroAD.ovpn
    else
        echo "De mogelijke opties zijn htb of thm, probeer opnieuw"
    fi
else 
    echo "Er moet een parameter worden meegegeven om te weten welke vpn verbinding je tot stand wilt brengen"
fi