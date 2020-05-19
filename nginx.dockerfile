FROM amazeeio/nginx

COPY nginx.conf /etc/nginx/conf.d/app.conf

RUN fix-permissions /etc/nginx/conf.d/app.conf
