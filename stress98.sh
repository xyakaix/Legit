#!/usr/bin/env bash

set -euo pipefail

TARGET=${1:-98}        
CYCLE_MS=${2:-100}     

if ! command -v python3 >/dev/null 2>&1; then
  >&2
  exit 1
fi

if [ "$TARGET" -le 0 ] || [ "$TARGET" -ge 100 ]; then
  >&2
  exit 1
fi

CPUS=$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo )
if [ "$CPUS" -lt 1 ]; then
  CPUS=1
fi

BURN_MS=$(( (CYCLE_MS * TARGET + 50) / 100 ))
SLEEP_MS=$(( CYCLE_MS - BURN_MS ))

PIDS=()

PYWORKER=$(cat <<'PY'
import time,sys,signal
burn = int(sys.argv[1]) / 1000.0
sleep_ms = int(sys.argv[2]) / 1000.0
running = True
def _sig(signum, frame):
    global running
    running = False
signal.signal(signal.SIGINT, _sig)
signal.signal(signal.SIGTERM, _sig)
time.sleep(0.005 * (hash(str(time.time())) % 10))
while running:
    end = time.time() + burn
    # Busy loop
    while time.time() < end and running:
        pass
    if not running:
        break
    if sleep_ms > 0:
        time.sleep(sleep_ms)
PY
)

for i in $(seq 1 "$CPUS"); do
  python3 -c "$PYWORKER" "$BURN_MS" "$SLEEP_MS" &
  PIDS+=($!)
done

cleanup() {
  for pid in "${PIDS[@]}"; do
    kill "$pid" 2>/dev/null || true
  done
  sleep 0.2
  for pid in "${PIDS[@]}"; do
    kill -9 "$pid" 2>/dev/null || true
  done
  exit 0
}
trap cleanup INT TERM

while true; do
  sleep 60 &
  wait $!
done
