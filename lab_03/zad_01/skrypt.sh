#!/bin/bash

PORT=8080

docker run -it --rm -d -p $PORT:80 --name nginx-zad1 -v C:/Users/kalej/Uczelnia/TechnologieChmurowe/lab_03/zad_01/strona:/usr/share/nginx/html nginx
echo "Nginx uruchomiony na porcie $PORT"

echo "Testowanie serwera..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$PORT)
if [ "$response" -eq 200 ]; then
    echo "Test zakończony pomyślnie: serwer zwraca kod 200."
else
    echo "Błąd: serwer nie zwraca kodu 200. Kod odpowiedzi: $response"
    exit 1
fi

echo "Zmiana zawartości strony..."
echo "<h1>Nowa zawartosc strony</h1>" > ./strona/index.html
sleep 5
response_body=$(curl -s http://localhost:$PORT)
if [[ "$response_body" == *"Nowa zawartosc strony"* ]]; then
    echo "Test zakończony pomyślnie: zmiana zawartości strony działa."
else
    echo "Błąd: zawartość strony nie została zmieniona."
    exit 1
fi