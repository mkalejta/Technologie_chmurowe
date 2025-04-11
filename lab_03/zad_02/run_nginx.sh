#!/bin/bash

# Domyślne wartości
CONTAINER_NAME="custom_nginx"
IMAGE_NAME="nginx:latest"
CONFIG_FILE=""
PORT="8080"

# Funkcja wyświetlająca pomoc
usage() {
    echo "Użycie: $0 [-c plik_konfiguracyjny] [-p port]"
    echo "  -c  Ścieżka do niestandardowego pliku konfiguracyjnego Nginx."
    echo "  -p  Port, na którym Nginx ma nasłuchiwać (domyślnie 8080)."
    exit 1
}

# Parsowanie argumentów
while getopts "c:p:" opt; do
    case "${opt}" in
        c)
            CONFIG_FILE=${OPTARG}
            ;;
        p)
            PORT=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

# Sprawdzenie, czy kontener już istnieje
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Usuwanie istniejącego kontenera ${CONTAINER_NAME}..."
    docker rm -f ${CONTAINER_NAME}
fi

# Opcje montowania konfiguracji
MOUNT_OPTION=""
if [[ -n "$CONFIG_FILE" ]]; then
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Błąd: Podany plik konfiguracyjny nie istnieje."
        exit 1
    fi
    MOUNT_OPTION="-v $(realpath "$CONFIG_FILE"):/etc/nginx/nginx.conf:ro"
fi

# Uruchomienie kontenera
echo "Tworzenie kontenera ${CONTAINER_NAME} na porcie ${PORT}..."
docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${MOUNT_OPTION} ${IMAGE_NAME}

# Sprawdzenie statusu kontenera
if docker ps | grep -q "${CONTAINER_NAME}"; then
    echo "Serwer Nginx działa na porcie ${PORT}."
else
    echo "Błąd: Nie udało się uruchomić kontenera."
    exit 1
fi