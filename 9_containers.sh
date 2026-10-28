#!/bin/bash

# OpenCloud
mkdir -p $HOME/opencloud/opencloud-config
mkdir -p $HOME/opencloud/opencloud-data
docker pull opencloudeu/opencloud-rolling:latest

### Initialize
docker run --rm -it \
  -v $HOME/opencloud/opencloud-config:/etc/opencloud \
  -v $HOME/opencloud/opencloud-data:/var/lib/opencloud \
  -e IDM_ADMIN_PASSWORD=admin \
  opencloudeu/opencloud-rolling:latest init

### Start
docker run \
  --name opencloud \
  --rm \
  -d \
  -p 9200:9200 \
  -v $HOME/opencloud/opencloud-config:/etc/opencloud \
  -v $HOME/opencloud/opencloud-data:/var/lib/opencloud \
  -e OC_INSECURE=true \
  -e PROXY_HTTP_ADDR=0.0.0.0:9200 \
  -e OC_URL=https://localhost:9200 \
  opencloudeu/opencloud-rolling:latest

# OwnCloud
### https://doc.owncloud.com/server/11.0/admin_manual/installation/installing_with_docker.html


# YourTrack
### https://www.jetbrains.com/help/youtrack/server/youtrack-docker-installation.html#run-youtrack-service
docker run -it --name <youtrack-server-instance> \
-v <path to data directory>:/opt/youtrack/data \
-v <path to conf directory>:/opt/youtrack/conf \
-v <path to logs directory>:/opt/youtrack/logs \
-v <path to backups directory>:/opt/youtrack/backups \
-p <port on host>:8080 \
jetbrains/youtrack:<version>

# ActivePieces
### https://www.activepieces.com/docs/overview/welcome
docker run -d --name activepieces -p 8080:80 \
  -v ~/.activepieces:/root/.activepieces \
  -e AP_DB_TYPE=PGLITE \
  -e AP_REDIS_TYPE=MEMORY \
  -e AP_FRONTEND_URL="http://localhost:8080" \
  activepieces/activepieces:latest
