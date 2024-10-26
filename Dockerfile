# Build step #1: Build the React front end
FROM node:18-alpine as build-step

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Build step #2: Build the NGINX container
FROM nginx:stable-alpine

COPY --from=build-step /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]