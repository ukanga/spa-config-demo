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

# confd
RUN curl -sSL -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 \
  && chmod +x /usr/local/bin/confd

COPY ./docker/confd_env.toml /etc/confd/conf.d/appconfig.toml
COPY ./docker/config.js.tmpl /etc/confd/templates/config.js.tmpl

COPY ./docker/app.sh /usr/local/bin/app.sh
RUN chmod +x /usr/local/bin/app.sh

CMD ["/bin/sh", "-c", "/usr/local/bin/app.sh && nginx -g \"daemon off;\"" ]
