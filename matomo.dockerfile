FROM matomo:fpm-alpine

ENV MATOMO_DATABASE_USERNAME=lagoon \
    MATOMO_DATABASE_PASSWORD=lagoon \
    MATOMO_DATABASE_DATABASE=lagoon \
    MATOMO_DATABASE_HOST=matomo-database

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
