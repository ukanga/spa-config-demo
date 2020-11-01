FROM node:14.9.0-alpine as build
ENV REACT_DIST=/usr/share/nginx/html

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN yarn install

COPY ./public /app/public
COPY ./src /app/src

RUN yarn build

FROM nginx:1.19.3-alpine as final
COPY --from=build /app/build /usr/share/nginx/html
COPY ./docker/nginx-config/gzip.conf /etc/nginx/conf.d/gzip.conf

