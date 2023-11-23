#!/bin/bash

PID=$(pgrep -f "$PORT" -u ubuntu)

echo $PID

if [ -z "$PID" ]; then
  echo "포트 $PORT에서 실행 중인 프로세스가 없습니다."
else
  echo "포트 $PORT에서 실행 중인 프로세스 종료: $PID"
  kill -9 "$PID"
fi

JAR_PATH=$(docker exec -it amazoncorretto17 find /app/deploy -name "*.jar")

echo "run server"

docker exec -it amazoncorretto17 nohup java -jar -Dspring.profiles.active=production -Dserver.port=$PORT $JAR_PATH &
