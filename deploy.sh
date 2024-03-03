#!/bin/bash

{
    echo "stop container"
    docker stop amazoncorretto17
} && 
{
    echo "rerun container"
    docker start amazoncorretto17
} && 
{
    echo "container started, getting JAR_PATH..."
    JAR_PATH=$(docker exec amazoncorretto17 find /app/deploy -name "*.jar" | tr -d '\r')
    if [ -n "$JAR_PATH" ]; then
        echo "run server"
        docker exec -d amazoncorretto17 nohup java -jar -Dspring.profiles.active=production -Dserver.port=$PORT $JAR_PATH &
    else
        echo "Failed to get JAR_PATH."
    fi
}
