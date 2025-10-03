#!/usr/bin/env bash
set -euo pipefail

TARGET=${1:-98}   
REST=300          
HOLD=5            
CPUS=$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)

PIDS=()

worker() {
  while true; do :; done
}

start_workers() {
  PIDS=()
  for i in $(seq 1 "$CPUS"); do
    worker &
    PIDS+=($!)
  done
}

stop_workers() {
  for pid in "${PIDS[@]}"; do
    kill "$pid" 2>/dev/null || true
  done
  wait 2>/dev/null || true
  PIDS=()
}

cleanup() {
  stop_workers
  exit 0
}
trap cleanup INT TERM

while true; do
  start_workers
  streak=0
  while true; do
    usage=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}' | tail -1)
    usage=${usage%.*}
    if [ "$usage" -ge "$TARGET" ]; then
      streak=$((streak+1))
      if [ "$streak" -ge "$HOLD" ]; then
        stop_workers
        sleep "$REST"
        break
      fi
    else
      streak=0
    fi
  done
done
