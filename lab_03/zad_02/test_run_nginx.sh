#!/bin/bash

TEST_CONTAINER="test_nginx"
TEST_CONFIG="C:/Users/kalej/Uczelnia/TechnologieChmurowe/lab_03/zad_02/test_nginx.conf"

# Tworzenie testowego pliku konfiguracyjnego
echo "events {} 
http { 
    server { 
        listen 8081;
    } 
}" > ${TEST_CONFIG}

# Test 1: Sprawdzenie, czy skrypt uruchamia kontener na domyślnym porcie
bash run_nginx.sh
if ! docker ps | grep -q "custom_nginx"; then
    echo "Test 1 nie powiódł się: Kontener nie został uruchomiony."
    exit 1
else
    echo "Test 1 zakończony sukcesem."
fi

# Test 2: Sprawdzenie, czy można ustawić niestandardowy port
bash run_nginx.sh -p 8082
if ! docker ps | grep -q "0.0.0.0:8082->80/tcp"; then
    echo "Test 2 nie powiódł się: Port nie został zmieniony."
    exit 1
else
    echo "Test 2 zakończony sukcesem."
fi

# Test 3: Sprawdzenie, czy można podać niestandardowy plik konfiguracyjny
bash run_nginx.sh -c ${TEST_CONFIG} -p 8083
if ! docker exec custom_nginx nginx -T 2>&1 | grep -q "listen 8081"; then
    echo "Test 3 nie powiódł się: Niestandardowa konfiguracja nie została zastosowana."
    exit 1
else
    echo "Test 3 zakończony sukcesem."
fi

# Sprzątanie
docker rm -f custom_nginx
rm -f ${TEST_CONFIG}

echo "Wszystkie testy zakończone sukcesem."