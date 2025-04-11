#!/bin/bash

# Nazwa obrazu i kontenera
IMAGE_NAME="node14_express_app"
CONTAINER_NAME="express_server"

# Tworzenie katalogu roboczego
WORKDIR="express_app"
mkdir -p $WORKDIR
cd $WORKDIR

# Tworzenie pliku package.json
cat <<EOF > package.json
{
  "name": "express-server",
  "version": "1.0.0",
  "description": "Simple Express.js server",
  "main": "server.js",
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

# Tworzenie pliku server.js
cat <<EOF > server.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.json({ datetime: new Date().toISOString() });
});

app.listen(8080, () => console.log('Server running on port 8080'));
EOF

# Tworzenie Dockerfile
cat <<EOF > Dockerfile
FROM node:14
WORKDIR /app
COPY package.json .
RUN npm install
COPY server.js .
CMD ["node", "server.js"]
EOF

# Budowanie obrazu Dockera
docker build -t $IMAGE_NAME .

# Uruchamianie kontenera
docker run -d --rm --name $CONTAINER_NAME -p 8080:8080 $IMAGE_NAME

# Czekanie na uruchomienie serwera
sleep 3

# Testowanie aplikacji
RESPONSE=$(curl -s http://localhost:8080)
if echo "$RESPONSE" | grep -q '"datetime"'; then
    echo "Test passed: Server returned datetime JSON"
else
    echo "Test failed: No valid response from server"
    docker logs $CONTAINER_NAME
    docker stop $CONTAINER_NAME
    exit 1
fi

echo "Script execution completed successfully!"
