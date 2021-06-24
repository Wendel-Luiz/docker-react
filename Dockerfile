# Primeira fase
FROM node:alpine as builder

USER node

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY --chown=node:node package.json .

RUN npm install

COPY --chown=node:node . .

RUN npm run build

# Segunda fase
FROM nginx 
COPY --from=builder /home/node/app/build /usr/share/nginx/html

# Não precisa iniciar o NGINX pois a imagem já tem como comando padrão iniciar o server

