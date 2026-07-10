#!/bin/bash

# health_check.sh
# Reports basic system health: running processes, disk usage, and memory usage.

echo "===== SYSTEM HEALTH CHECK ====="
echo ""

echo "--- Top 5 Processes by CPU Usage ---"
ps aux --sort=-%cpu | head -n 6
echo ""

echo "--- Top 5 Processes by Memory Usage ---"
ps aux --sort=-%mem | head -n 6
echo ""

echo "--- Disk Usage ---"
df -h --output=source,size,used,avail,pcent,target | grep -E '^/dev/'
echo ""

echo "--- Memory Usage ---"
free -h
echo ""

echo "===== END OF REPORT ====="
