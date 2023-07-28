import os
import paramiko
import getpass
import time
import re
from colorama import Fore, Style


def print_banner():
    banner = """
\033[1;35m
********************************************************************************
************************************████████************************************
**********************************█████████████*********************************
*******************************███████████████████******************************
****************************█████████████████████████***************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************█████████████████████████████*************************
**************************███████████████████████████***************************
*******************************████████****███████******************************
******************************████████*****███████******************************
******************************███████******███████******************************
********************************************************************************

  █████████                                                                 
 ███░░░░░███                                                                
░███    ░░░  █████████████    ██████   ████████  ████████   ██████   ██████ 
░░█████████ ░░███░░███░░███  ░░░░░███ ░░███░░███░░███░░███ ███░░███ ███░░███
 ░░░░░░░░███ ░███ ░███ ░███   ███████  ░███ ░███ ░███ ░███░███████ ░███████ 
 ███    ░███ ░███ ░███ ░███  ███░░███  ░███ ░███ ░███ ░███░███░░░  ░███░░░  
░░█████████  █████░███ █████░░████████ ░███████  ░███████ ░░██████ ░░██████ 
 ░░░░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░░░  ░███░░░   ░███░░░   ░░░░░░   ░░░░░░  
                                       ░███      ░███                       
                                       █████     █████                      
                                      ░░░░░     ░░░░░                       
                                                                         
Author: Jelle Van Holsbeeck 
Contact: jelle@holsbeeck.com
\033[0m
"""
    print(banner)


def get_user_input(prompt):
    try:
        if hasattr(__builtins__, 'raw_input'):
            return raw_input(prompt)
        else:
            return input(prompt)
    except EOFError:
        return None


def send_command(channel, command):
    channel.send(command + "\n")
    time.sleep(2)  # Wait for output to be available
    output = ""
    while channel.recv_ready():
        output += channel.recv(1024).decode()
        time.sleep(1)
    return output


def establish_ssh_connection(ip, username, password):
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        ssh_client.connect(hostname=ip, username=username, password=password)
        print(Fore.GREEN + "SSH connection established successfully!" + Style.RESET_ALL)

        # Use invoke_shell() to access an interactive shell
        channel = ssh_client.invoke_shell()

        # Send the "info" command and read the output
        output = send_command(channel, "info")
        print(output)

        # Parse the output to extract relevant information
        lines = output.strip().split("\n")
        status_connected = False
        for line in lines:
            if line.startswith("Status:"):
                connection_status = line.split(":")[1].strip()
                connection_status_clean = connection_status.split(
                    "(")[0].strip()  # Clean cutoff after 'D'
                print(Fore.CYAN +
                      f"Status: {connection_status_clean}" + Style.RESET_ALL)
                # Check connection status using regular expression
                if re.search(r'connected', connection_status, re.IGNORECASE):
                    status_connected = True
                    break

        # Check the connection status and take appropriate action
        if not status_connected:
            inform_command = "set-inform http://192.168.9.12:8080/inform"
            print(
                Fore.RED + "Status is not connected. Invoking 'set-inform' command." + Style.RESET_ALL)
            output_set_inform = send_command(channel, inform_command)
            print(output_set_inform)

    except paramiko.AuthenticationException:
        print(Fore.RED + "Authentication failed. Please check your username and password." + Style.RESET_ALL)
    except paramiko.SSHException as e:
        print(Fore.RED + f"SSH connection failed: {e}" + Style.RESET_ALL)
    finally:
        ssh_client.close()


def main():
    os.system("clear")
    print_banner()

    vlan = get_user_input("Enter the VLAN ID: ")
    device = get_user_input("Enter the number of the device: ")

    ip = "192.168." + str(vlan) + "." + str(device)
    if not ip:
        print("Invalid IP address.")
        return

    username = get_user_input("Enter the username: ")
    if not username:
        print("Invalid username.")
        return

    password = getpass.getpass("Enter the password: ")
    if not password:
        print("Invalid password.")
        return

    establish_ssh_connection(ip, username, password)


if __name__ == "__main__":
    main()
