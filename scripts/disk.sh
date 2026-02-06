#!/bin/bash

LOGFILE="/tmp/devops_monitor.log"

GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

check_disk() {
  echo -e "${GREEN}===== Disk Usage =====${NC}"
  df -h

  USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

  if [ $USAGE -gt 80 ]; then
    echo -e "${RED}Warning: Disk usage above 80%${NC}"
    log "High disk usage: $USAGE%"
  else
    log "Disk OK: $USAGE%"
  fi
}

check_memory() {
  echo -e "${GREEN}===== Memory =====${NC}"
  free -m
  log "Memory checked"
}

check_user() {
  echo -e "${GREEN}===== Logged User =====${NC}"
  whoami
  log "User checked"
}

case "$1" in
  --disk) check_disk ;;
  --memory) check_memory ;;
  --user) check_user ;;
  --all)
    check_disk
    check_memory
    check_user
    ;;
  *)
    echo "Usage: $0 --disk | --memory | --user | --all"
    ;;
esac

