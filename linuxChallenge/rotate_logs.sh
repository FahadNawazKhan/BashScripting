#!/bin/bash

FILE="/home/faddu/BashScripting/linuxChallenge/timestamp.txt"

if [ -f "$FILE" ] && [ "$(wc -c < "$FILE")" -gt 1048576 ]; then
    mv "$FILE" "${FILE}_$(date +%Y%m%d_%H%M%S)"
    touch "$FILE"
    echo "Log rotated successfully"
else
    echo "File does not exist or is not larger than 1MB"
fi
