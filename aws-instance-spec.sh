#!/usr/bin/env bash

OUTFILE=~/aws-instance-spec-$(date +%F_%H-%M-%S).txt

{
  echo "======================================"
  echo " AWS INSTANCE SPECIFICATION DUMP"
  echo " Generated: $(date)"
  echo " Hostname : $(hostname -f)"
  echo "======================================"
  echo

  echo "=== INSTANCE TYPE ==="
  curl -s http://169.254.169.254/latest/meta-data/instance-type || echo "Metadata not available"
  echo

  echo "=== INSTANCE ID ==="
  curl -s http://169.254.169.254/latest/meta-data/instance-id || echo "Metadata not available"
  echo

  echo "=== AVAILABILITY ZONE ==="
  curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone || echo "Metadata not available"
  echo

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

} > "$OUTFILE"

echo "✅ Instance spec written to $OUTFILE"

