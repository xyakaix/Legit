#!/bin/bash
set -euo pipefail

TARGET=${1:-98} 
REST=300    
HOLD=5            

CPUS=$(getconf _NPROCESSORS_ONLN 2>/dev/null || grep -c '^processor' /proc/cpuinfo || echo 1)

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

get_cpu_usage() {
  read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  total1=$((user+nice+system+idle+iowait+irq+softirq+steal))
  idle1=$((idle+iowait))
  sleep 1
  read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  total2=$((user+nice+system+idle+iowait+irq+softirq+steal))
  idle2=$((idle+iowait))

  dt=$((total2 - total1))
  di=$((idle2 - idle1))
  if [ "$dt" -le 0 ]; then
    echo 0
  else
    echo $(( (100 * (dt - di)) / dt ))
  fi
}

while true; do
  start_workers
  streak=0
  while true; do
    usage=$(get_cpu_usage)
    echo "CPU load: ${usage}% (streak ${streak}/${HOLD})"
    if [ "$usage" -ge "$TARGET" ]; then
      streak=$((streak + 1))
      if [ "$streak" -ge "$HOLD" ]; then
        echo "Held ${TARGET}%+ for ${HOLD}s → resting ${REST}s..."
        stop_workers
        sleep "$REST"
        break
      fi
    else
      streak=0
    fi
  done
done
