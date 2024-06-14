FROM node:latest

WORKDIR /usr/src/app

COPY app/package*.json ./
COPY app/ ./

RUN npm install

CMD ["npm", "start"]
