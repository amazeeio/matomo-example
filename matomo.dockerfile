FROM matomo:fpm-alpine

ENV MATOMO_DATABASE_USERNAME=lagoon \
    MATOMO_DATABASE_PASSWORD=lagoon \
    MATOMO_DATABASE_DBNAME=lagoon \
    MATOMO_DATABASE_HOST=matomo-database