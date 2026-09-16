#!/bin/bash 

echo "= = = = = = = = = = = = = = = = = = = "
echo "          SYSTEM MONITOR              "
echo "= = = = = = = = = = = = = = = = = = = "
  
echo "Hostname: $(hostname)"
echo "kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"

