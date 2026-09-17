#!/bin/bash 

source config.conf



LOG_FILE="logs/system-monitor.log"













progress_bar() {
    local percent=$1
    local width=20
    local filled=$((percent * width / 100))
    local empty=$((width - filled))

    printf "["
    
    for ((i=0; i<filled; i++)); do
        printf "#"
    done

    for ((i=0; i<empty; i++)); do
        printf "-"
    done

    printf "] %s%%" "$percent"
}

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

CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -ge "$CPU_LIMIT" ]; then
    echo "WARNING: CPU usage is high!"
fi

printf "Usage: "
progress_bar "${CPU_USAGE%.*}"
echo

echo 
echo "- - - - - - - MEMORY- - - - - -"

TOTAL_RAM=$(free -m |awk '/Mem:/ {print $2}')
USED_RAM=$(free -m |awk '/Mem:/ {print $3}')
AVAILABLE_RAM=$(free -m|awk '/Mem:/ {print $7}')

RAM_USAGE=$((USED_RAM * 100 / TOTAL_RAM))

if [ "$RAM_USAGE" -ge "$RAM_LIMIT" ]; then
    echo "WARNING: RAM usage is high!"
fi


echo "Total: ${TOTAL_RAM}MB"
echo "Used: ${USED_RAM}MB"
echo "Available: ${AVAILABLE_RAM}MB"
printf "Usage: "
progress_bar "$RAM_USAGE"
echo

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

DISK_PERCENT=${DISK_USAGE%\%}
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "$TIMESTAMP|CPU=${CPU_INT}% | RAM=${RAM_USAGE}% | DISK =${DISK_PERCENT}%">> "$LOG_FILE"



if [ "$DISK_PERCENT" -ge "$DISK_LIMIT" ]; then
    echo "WARNING: Disk usage is high!"
fi


printf "Usage: "
progress_bar "$DISK_PERCENT"
echo


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

 


sleep "$REFRESH_RATE"
done
