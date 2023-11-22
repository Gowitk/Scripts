# Author: Jelle Van Holsbeeck
# Contact : jelle.vanholsbeeck@outlook.com

# ExecutionPolicy : https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6
Set-ExecutionPolicy Bypass -Scope Process

# Install Chocolatey : https://chocolatey.org/install
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# All packages : https://chocolatey.org/packages
choco install firefox -y 
choco install git -y 
choco install vscode -y 
choco install adobereader -y 
choco install virtualbox -y 
choco install notepadplusplus -y 
choco install python -y 
choco install 7zip -y 
choco install drawio -y 
choco install vlc -y 
choco install putty -y 
choco install wireshark -y 
choco install steam -y 
choco install discord -y 
choco install vagrant -y
choco install spotify -y 

# Install WSL : https://docs.microsoft.com/en-us/windows/wsl/install-win10
wsl --install 