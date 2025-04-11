#!/bin/bash

# Nazwa kontenerów
NODE_CONTAINER="node_app"
MONGO_CONTAINER="mongo_db"
MONGO_PORT=27017
APP_PORT=8080

# Tworzenie sieci Docker, jeśli nie istnieje
docker network create app_network || true

# Uruchomienie kontenera MongoDB
docker run -d --name $MONGO_CONTAINER \
  --network app_network \
  -p $MONGO_PORT:27017 \
  mongo:latest

# Tworzenie folderu dla aplikacji
mkdir -p node_app && cd node_app

# Inicjalizacja projektu Node.js
echo "{}" > package.json

# Instalacja Express.js i Mongoose
npm install express mongoose

# Tworzenie pliku serwera (server.js)
cat <<EOF > server.js
const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = process.env.PORT || $APP_PORT;
const MONGO_URI = "mongodb://$MONGO_CONTAINER:$MONGO_PORT/test";

mongoose.connect(MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error(err));

const ItemSchema = new mongoose.Schema({ name: String });
const Item = mongoose.model('Item', ItemSchema);

app.get('/', async (req, res) => {
  const items = await Item.find();
  res.json(items);
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Tworzenie pliku Dockerfile
cat <<EOF > Dockerfile
FROM node:16
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "server.js"]
EOF

# Budowanie obrazu i uruchomienie kontenera aplikacji
docker build -t node_app .
docker run -d --name $NODE_CONTAINER \
  --network app_network \
  -p $APP_PORT:8080 \
  node_app

# Testy
sleep 5  # Czekamy na uruchomienie kontenerów
echo "Testowanie dostępu do aplikacji..."
curl -s http://localhost:$APP_PORT | grep "\[" && echo "Test udany!" || echo "Test nieudany!"

