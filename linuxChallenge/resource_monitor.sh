#!/bin/bash

LOG_FILE="resource_usage.log"

while true
do
    date >> "$LOG_FILE"

    echo "CPU Usage:" >> "$LOG_FILE"
    top -bn1 | grep "%Cpu" >> "$LOG_FILE"

    echo "Memory Usage:" >> "$LOG_FILE"
    free -h >> "$LOG_FILE"

    echo "Disk Usage:" >> "$LOG_FILE"
    df -h >> "$LOG_FILE"

    CPU_USAGE=$(top -bn1 | grep "%Cpu" | awk '{print $2}')

    if (( ${CPU_USAGE%.*} > 80 )); then
        echo "WARNING: CPU usage exceeds 80%!"
    fi

    DISK_USAGE=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')

    if (( DISK_USAGE > 80 )); then
        echo "WARNING: Available disk space is below 20%!"
    fi

    sleep 300
done
