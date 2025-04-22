#!/bin/bash

rm -rf ./data
mkdir ./data

docker-compose down
docker-compose up -d

# Pętla próbująca połączenia z MongoDB
for i in {1..30}; do
    if docker exec db mongo --host db --eval "db.adminCommand('ping')" &> /dev/null; then
        echo "MongoDB gotowe!"
        break
    else
        sleep 1
    fi
done

echo "Sprawdzanie zawartości kolekcji 'users'..."
docker exec -it db mongo -u admin -p admin --authenticationDatabase admin --eval "db = db.getSiblingDB('my-db'); db.users.find().pretty()"
