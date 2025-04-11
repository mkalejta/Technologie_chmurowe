#!/bin/bash

# Funkcja do sprawdzania danych z curl
check_curl_response() {
  URL=$1
  RESPONSE=$(curl -s $URL)

  if [ -z "$RESPONSE" ]; then
    echo "Brak odpowiedzi z $URL"
  else
    echo "Odpowiedź z $URL:"
    echo "$RESPONSE"
  fi
}

# Funkcja do sprawdzania serwisów w sieci Docker
check_services_in_network() {
  NETWORK=$1
  EXPECTED_SERVICES=$2

  echo "Sprawdzam usługi w sieci $NETWORK..."

  SERVICES=$(docker network inspect $NETWORK --format '{{range .Containers}}{{.Name}}{{end}}')

  for SERVICE in $EXPECTED_SERVICES; do
    if echo "$SERVICES" | grep -q "$SERVICE"; then
      echo "Usługa $SERVICE jest w sieci $NETWORK"
    else
      echo "Usługa $SERVICE nie jest w sieci $NETWORK"
    fi
  done
}

# 1. Sprawdzamy połączenie frontend → backend
echo "Sprawdzam połączenie frontend → backend"
check_curl_response "http://localhost:8080"

echo

# 2. Sprawdzamy połączenie backend → database
echo "Sprawdzam połączenie backend → database"
check_curl_response "http://localhost:3000/data"

echo

# 3. Sprawdzamy serwisy w sieci frontend_network
check_services_in_network "frontend_network" "frontend3 backend3"

echo

# 4. Sprawdzamy serwisy w sieci backend_network
check_services_in_network "backend_network" "backend3 database3"
