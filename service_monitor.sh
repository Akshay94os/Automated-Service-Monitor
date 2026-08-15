#!/usr/bin/env bash
set -u

if [[ "$#" -gt 0 ]]; then
  SERVICES=("$@")
else
  SERVICES=(ssh cron nginx)
fi

LOG_DIR="$(dirname "$0")/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/service_status.log"
failed=0

echo "===== SERVICE MONITOR ====="
echo "Date: $(date)"
echo

for service in "${SERVICES[@]}"; do
  if systemctl is-active --quiet "$service"; then
    status="RUNNING"
  else
    status="NOT RUNNING"
    failed=1
  fi
  echo "$(date '+%Y-%m-%d %H:%M:%S') | $service | $status" | tee -a "$LOG_FILE"
done

if [[ "$failed" -eq 0 ]]; then
  echo "All checked services are running."
else
  echo "One or more services are not running."
fi

exit "$failed"
