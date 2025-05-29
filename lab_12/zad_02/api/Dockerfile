FROM --platform=linux/arm64 node:20-alpine

WORKDIR /app

COPY package.json .
RUN npm install

COPY index.js .

CMD ["npm", "start"]