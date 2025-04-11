#!/bin/bash

PORT=3000
CONTAINER_NAME="lab4_node"
VOLUME_NAME="nodejs_data"
VOLUME_NAME2="all_volumes"

# Sprawdzenie, czy kontener już istnieje
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Usuwanie istniejącego kontenera ${CONTAINER_NAME}..."
    docker rm -f ${CONTAINER_NAME}
fi

docker volume create ${VOLUME_NAME}
docker volume create ${VOLUME_NAME2}

docker run -d -p $PORT:3000 --name $CONTAINER_NAME --volume ${VOLUME_NAME}:/app node:latest
echo "Node uruchomiony na porcie $PORT"

docker run --rm -v nginx_data:/source -v all_volumes:/backup busybox sh -c "cp -r /source/* /backup/"

docker run --rm -v ${VOLUME_NAME2}:/backup \
-v C:/Users/kalej/Uczelnia/TechnologieChmurowe/lab_04/zad_02/app:/source busybox sh -c "cp -r /source/* /backup/"

echo "Pliki zostały skopiowane do wolumenu ${VOLUME_NAME2}"