FROM node:20-alpine
WORKDIR /app
COPY index.js .
RUN npm install express mysql2
CMD ["node", "index.js"]