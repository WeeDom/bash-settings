#!/usr/bin/env bash

# Check if running on AWS by testing metadata service
IS_AWS=false
if curl -s --max-time 2 http://169.254.169.254/latest/meta-data/ > /dev/null 2>&1; then
  IS_AWS=true
fi

echo "======================================"
if [ "$IS_AWS" = true ]; then
  echo " AWS INSTANCE SPECIFICATION DUMP"
else
  echo " SYSTEM SPECIFICATION DUMP"
fi
echo " Generated: $(date)"
echo " Hostname : $(hostname -f)"
echo "======================================"
echo

if [ "$IS_AWS" = true ]; then
  echo "=== INSTANCE TYPE ==="
  curl -s http://169.254.169.254/latest/meta-data/instance-type || echo "Metadata not available"
  echo

  echo "=== INSTANCE ID ==="
  curl -s http://169.254.169.254/latest/meta-data/instance-id || echo "Metadata not available"
  echo

  echo "=== AVAILABILITY ZONE ==="
  curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone || echo "Metadata not available"
  echo
fi

echo "=== CPU INFO ==="
lscpu
echo

echo "=== MEMORY ==="
free -h
echo

echo "=== BLOCK DEVICES ==="
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo

echo "=== DISK USAGE ==="
df -hT
echo

echo "=== NETWORK INTERFACES ==="
ip addr show
echo

echo "=== ROUTING TABLE ==="
ip route show
echo

echo "=== KERNEL & OS INFO ==="
uname -a
cat /etc/os-release
echo

