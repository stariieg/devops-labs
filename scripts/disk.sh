#!/bin/bash

LOGFILE="/tmp/devops_monitor.log"

show_help() {
  echo "Usage: $0 [option]"
  echo "Options:"
  echo "  --disk     Show disk usage"
  echo "  --memory   Show memory usage"
  echo "  --user     Show current user"
  echo "  --all      Show all info"
}

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

check_disk() {
  echo "===== Disk Usage ====="
  df -h
  log "Disk checked"
}

check_memory() {
  echo "===== Memory ====="
  free -m
  log "Memory checked"
}

check_user() {
  echo "===== Logged User ====="
  whoami
  log "User checked"
}

case "$1" in
  --disk)
    check_disk
    ;;
  --memory)
    check_memory
    ;;
  --user)
    check_user
    ;;
  --all)
    check_disk
    check_memory
    check_user
    ;;
  *)
    show_help
    ;;
esac

