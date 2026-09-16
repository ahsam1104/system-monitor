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
