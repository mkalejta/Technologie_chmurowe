FROM node:20-alpine
WORKDIR /app
COPY index.js .
RUN npm install express mongodb
CMD ["node", "index.js"]