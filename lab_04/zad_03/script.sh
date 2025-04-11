#!/bin/bash

# Pobranie listy wszystkich woluminów Docker
docker_volumes=$(docker volume ls -q)

# Sprawdzenie, czy są jakieś wolumeny
if [ -z "$docker_volumes" ]; then
    echo "Brak woluminów Docker."
    exit 0
fi

# Sprawdzenie użycia dysku dla każdego woluminu
echo "Zużycie przestrzeni dyskowej dla woluminów Docker:"
echo "--------------------------------------------"
for volume in $docker_volumes; do
    mountpoint=$(docker volume inspect --format '{{ .Mountpoint }}' "$volume")
    if [ -d "$mountpoint" ]; then
        usage=$(df -h "$mountpoint" | awk 'NR==2 {print $5}')
        echo "$volume ($mountpoint): $usage zajęte"
    else
        echo "$volume: Brak danych o punkcie montowania"
    fi
done