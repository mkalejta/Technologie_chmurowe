FROM node:latest
ENV MY_VARIABLE="my_value"
WORKDIR /node-app
COPY app/ ./
RUN npm install
EXPOSE 3000
CMD ["npm", "run", "start"]