#!/bin/bash

# Nazwa obrazu i kontenera
IMAGE_NAME="node:12"
CONTAINER_NAME="node_server_container"
PORT=8080

# Tworzenie pliku serwera HTTP
echo "const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World');
});
server.listen(8080, () => console.log('Server running on port 8080'));
" > server.js

# Tworzenie pliku Dockerfile
echo "FROM $IMAGE_NAME
WORKDIR /app
COPY server.js .
CMD [\"node\", \"server.js\"]
" > Dockerfile

# Budowanie obrazu Dockera
docker build -t node_http_server .

# Uruchomienie kontenera
docker run -d --name $CONTAINER_NAME -p $PORT:8080 node_http_server

# Testowanie serwera
sleep 2
curl -s http://localhost:$PORT | grep "Hello World" && echo "Test passed" || echo "Test failed"
