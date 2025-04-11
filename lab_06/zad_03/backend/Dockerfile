FROM node:18-alpine

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

RUN apk add --no-cache curl mysql-client

CMD ["node", "index.js"]
