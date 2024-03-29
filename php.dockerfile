ARG CLI_IMAGE
FROM ${CLI_IMAGE} as cli

FROM uselagoon/php-8.1-fpm:latest

COPY 90-matomo-envs.sh  /lagoon/entrypoints/

ENV MATOMO_DATABASE_HOST=matomo-database \
    MATOMO_DATABASE_USERNAME=lagoon \
    MATOMO_DATABASE_PASSWORD=lagoon \
    MATOMO_DATABASE_DATABASE=lagoon \
    MATOMO_DATABASE_TABLES_PREFIX=matomo_

RUN mkdir -p /persistent && fix-permissions /persistent

COPY --from=cli /app /app
