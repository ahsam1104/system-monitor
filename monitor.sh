#!/bin/bash 



while true
do
clear




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


echo 

echo "- - - - - - - DISK - - - - - - - -"
DISK_INFO=$(df -h /|tail -1)


DISK_TOTAL=$(echo "$DISK_INFO"|awk '{print $2}')
DISK_USED=$(echo "$DISK_INFO" |awk '{print $3}')
DISK_AVAILABLE=$(echo "$DISK_INFO" |awk '{print $4}')
DISK_USAGE=$(echo "$DISK_INFO"|awk '{print $5}')


echo "Total: $DISK_TOTAL"
echo "Used : $DISK_USED"
echo "Available: $DISK_AVAILABLE"
echo "Usage : $DISK_USAGE"

echo 
echo "- - - - - - - - - PROCESSES- - - - - - - - "

echo "Running processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

echo 
echo "Top RAM processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -6
  



echo 

echo "- - - - - - -NETWORK - - - - - - - -"


echo "Interfaces:"
ip -br addr
  echo 

echo "Default route:"
ip route|grep default 

echo 

echo "Network statistics:"
ip -s link 


sleep 2
done
