#!/bin/bash

USER_FILE="user_list.txt"
GROUP="students"
DEFAULT_PASSWORD="Student@123"

if [ ! -f "$USER_FILE" ]; then
    echo "Error: $USER_FILE not found."
    exit 1
fi

if ! getent group "$GROUP" > /dev/null; then
    sudo groupadd "$GROUP"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create group $GROUP."
        exit 1
    fi
fi

while read username
do
    if [ -z "$username" ]; then
        continue
    fi

    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping."
        continue
    fi

    sudo useradd -m -g "$GROUP" "$username"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create user $username."
        continue
    fi

    echo "$username:$DEFAULT_PASSWORD" | sudo chpasswd

    if [ $? -ne 0 ]; then
        echo "Error: Failed to set password for $username."
        continue
    fi

    sudo passwd -e "$username"

    echo "User $username created successfully."

done < "$USER_FILE"

echo "Bulk user creation completed."
