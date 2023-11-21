#!/bin/bash

port=8080

pid=$(pgrep -f "$port" -u ubuntu)

echo $pid

if [ -z "$pid" ]; then
  echo "포트 $port에서 실행 중인 프로세스가 없습니다."
else
  echo "포트 $port에서 실행 중인 프로세스 종료: $pid"
  kill -9 "$pid"
fi

JAR_PATH=$(docker exec -it amazoncorretto17 find /app/deploy -name "*.jar")

echo "run server"

docker exec -it amazoncorretto17 nohup java -jar -Dspring.profiles.active=production -Dserver.port=$port $JAR_PATH &
