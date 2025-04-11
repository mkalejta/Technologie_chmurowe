#!/bin/bash

# Budowanie kontenera Node.js
cd node
docker build -t node .

# Budowanie kontenera Nginx
cd ../nginx
docker build -t nginx .

# Tworzenie sieci Docker
docker network create my-network

# Uruchomienie aplikacji Node.js
docker run --name my-node-app --network my-network -p 3000:3000 -d node

# Uruchomienie kontenera Nginx
docker run --name my-nginx-container --network my-network -d -p 80:80 -p 443:443 nginx