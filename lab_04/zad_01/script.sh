#!/bin/bash

PORT=8080
CONTAINER_NAME="lab4_nginx"
VOLUME_NAME="nginx_data"

# Sprawdzenie, czy kontener już istnieje
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Usuwanie istniejącego kontenera ${CONTAINER_NAME}..."
    docker rm -f ${CONTAINER_NAME}
fi

docker volume create ${VOLUME_NAME}
docker run --rm -v ${VOLUME_NAME}:/usr/share/nginx/html busybox sh -c "echo '<h1>Witaj na zmienionej stronie serwera Nginx!</h1>' > /usr/share/nginx/html/index.html"

docker run -d -p $PORT:80 --name $CONTAINER_NAME --volume ${VOLUME_NAME}:/usr/share/nginx/html nginx:latest

echo "Nginx uruchomiony na porcie $PORT i zawartość strony została zmieniona."