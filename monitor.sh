#!/bin/bash 

echo "= = = = = = = = = = = = = = = = = = = "
echo "          SYSTEM MONITOR              "
echo "= = = = = = = = = = = = = = = = = = = "
  
echo "Hostname: $(hostname)"
echo "kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"


echo 

echo "- - - - - - - CPU- - - - - - - - "

CPU_MODEL=$(lscpu | grep "Model name:"|sed 's/Model name:[[:space:]]*//')
CPU_CORES=$(nproc)

echo "Model: $CPU_MODEL"

echo "Cores: $CPU_CORES"

CPU_USAGE=$(top -bn1| grep "Cpu(s)"| awk '{print 100 -$8}')

echo "Usage: ${CPU_USAGE}%"

echo 
echo "- - - - - - - MEMORY- - - - - -"

TOTAL_RAM=$(free -m |awk '/Mem:/ {print $2}')
USED_RAM=$(free -m |awk '/Mem:/ {print $3}')
AVAILABLE_RAM=$(free -m|awk '/Mem:/ {print $7}')

RAM_USAGE=$((USED_RAM * 100 / TOTAL_RAM))

echo "Total: ${TOTAL_RAM}MB"
echo "Used: ${USED_RAM}MB"
echo "Available: ${AVAILABLE_RAM}MB"
echo "Usage: ${RAM_USAGE}%"
