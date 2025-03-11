#!/bin/bash

echo "=== Server Performance Stats ==="

echo -e "\nTotal CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
  sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
  awk '{print "CPU Usage: " 100 - $1 "%"}'

echo -e "\nMemory Usage:"
free -h | grep Mem | \
  awk '{print "Used: " $3 " / Total: " $2 " (" int($3/$2 * 100) "%)"}'
  
echo -e "\nDisk Usage:"
df -h | grep '^/dev' | \
  awk '{print $1 ": Used: " $3 " / Total: " $2 " (" $5 ")"}'

echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
