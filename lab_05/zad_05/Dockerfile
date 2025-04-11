FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Instalacja Node.js i zależności
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

# Usunięcie domyślnej konfiguracji
RUN rm /etc/nginx/conf.d/default.conf

# Skopiowanie własnej konfiguracji nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Skopiowanie zbudowanej aplikacji do katalogu Nginx
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
