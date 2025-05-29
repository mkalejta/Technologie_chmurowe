FROM node:20-alpine

WORKDIR /app

COPY package.json .
RUN npm install

COPY index.js .

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -f http://localhost:3000/health || exit 1

CMD ["npm", "start"]