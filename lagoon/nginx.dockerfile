ARG CLI_IMAGE
FROM ${CLI_IMAGE} as cli

FROM uselagoon/nginx:latest

COPY ./lagoon/nginx.conf /etc/nginx/conf.d/app.conf

RUN fix-permissions /etc/nginx/conf.d/app.conf

COPY --from=cli /app /app
