FROM matomo:fpm-alpine as matomo

FROM amazeeio/nginx

COPY --from=matomo /usr/src/matomo /var/www/html

COPY nginx.conf /etc/nginx/conf.d/app.conf

RUN fix-permissions /etc/nginx/conf.d/app.conf
