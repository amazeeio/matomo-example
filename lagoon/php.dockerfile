ARG CLI_IMAGE
FROM ${CLI_IMAGE} as cli

FROM uselagoon/php-8.3-fpm:latest

COPY ./lagoon/90-matomo-envs.sh  /lagoon/entrypoints/

RUN mkdir -p /persistent && fix-permissions /persistent

COPY --from=cli /app /app
