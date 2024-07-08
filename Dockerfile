# BUILD STAGE
FROM node:18.17.0-alpine as build-step

WORKDIR /app

COPY package.json /app/

RUN npm i

COPY . /app

RUN npm run build

# ========================================
# NGINX STAGE
# ========================================

FROM nginx:1.23-alpine 

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=react-build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]