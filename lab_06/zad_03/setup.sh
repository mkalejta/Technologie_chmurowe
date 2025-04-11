#!/bin/bash

# 1. Tworzenie sieci
docker network create frontend_network
docker network create --internal backend_network

# 2. Budowanie obrazów
docker build -t my-frontend3 ./frontend
docker build -t my-backend3 ./backend

# 3. Uruchomienie bazy danych
docker run -d --name database3 \
  --network backend_network \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=appdb \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=password \
  -v "C:/Users/kalej/Uczelnia/TechnologieChmurowe/lab_06/zad_03/db/init.sql:/docker-entrypoint-initdb.d/init.sql" \
  mysql:8

# 4. Czekam na gotowość bazy danych
echo "Czekam aż baza danych będzie gotowa..."
until docker exec database3 mysqladmin ping -uuser -ppassword --silent &> /dev/null ; do
    sleep 2
done
echo "Baza danych jest gotowa!"

# 5. Uruchomienie backendu
docker run -d --name backend3 \
  --network frontend_network \
  -p 3000:3000 \
  my-backend3
docker network connect backend_network backend3

# 6. Czekam na uruchomienie backendu
sleep 5

# 7. Uruchomienie frontendu
docker run -d --name frontend3 \
  --network frontend_network \
  -p 8080:8080 \
  my-frontend3


echo "Wszystko uruchomione"
