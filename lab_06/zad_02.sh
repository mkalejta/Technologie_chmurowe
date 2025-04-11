#!/bin/bash

# Polecenia oddzielone spacjami należy wykonać w konsoli znajdując się w katalogu zad_02
docker stop web && docker rm web
docker stop db && docker rm db
docker network rm my_network2
docker image rm web-app
docker network create my_network2

docker run -d \
  --name db \
  --network my_network2 \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=testdb \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=pass \
  mysql:8

docker build -t web-app .

docker run -d \
  --name web \
  --network my_network2 \
  -p 8080:3000 \
  web-app