# README OF SSH.PY 

Script is used to provision UniFi devices by checking the status of the inform and in case anything else than connected is returned, forcing the "Set-Inform" command to run. 

User input: 

1. VLAN ID
2. DEVICE ID (**last digits of the IP**)
3. USERNAME 
4. PASSWORD

Good to know that the IP of the controller is hardcoded, probally gonna be changed to also prompt user for this. 