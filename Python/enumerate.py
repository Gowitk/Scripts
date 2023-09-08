import requests
import time


def is_account_active(username, password):
    # Update with your website's login URL
    login_url = 'URL'

    session = requests.Session()

    login_payload = {
        'username': username,
        'password': password
    }

    response = session.post(login_url, data=login_payload)

    # Check the status code of the response
    if response.status_code == 200:  # 200 indicates a successful request
        return True
    else:
        return False


# Update with your path
desktop_path = r'PATH'


with open(desktop_path, 'r') as file:
    for line in file:
        parts = line.strip().rsplit(':', 1)
        if len(parts) == 2:
            username, password = parts
            if is_account_active(username, password):
                print(f"Account {username} is active.")
            else:
                print(f"Account {username} is not active.")
            time.sleep(5)
        else:
            print(f"Invalid line format: {line.strip()}")
