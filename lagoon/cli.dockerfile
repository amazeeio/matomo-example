FROM uselagoon/php-8.3-cli:latest

# @see https://github.com/matomo-org/matomo/releases
ENV MATOMO_VERSION 5.0.3

RUN set -ex; \
    apk add --no-cache --virtual .fetch-deps \
        gnupg \
    ; \
    \
    curl -fsSL -o matomo.tar.gz \
        "https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz"; \
    curl -fsSL -o matomo.tar.gz.asc \
        "https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keyserver.ubuntu.com --recv-keys F529A27008477483777FC23D63BB30D0E5D2C749; \
    gpg --batch --verify matomo.tar.gz.asc matomo.tar.gz; \
    gpgconf --kill all; \
    rm -rf "$GNUPGHOME" matomo.tar.gz.asc; \
    tar -xzf matomo.tar.gz -C /app matomo/ --strip-components=1; \
    rm matomo.tar.gz; \
    apk del .fetch-deps

RUN mkdir -p /persistent && \
    fix-permissions /persistent && \
    # Allow this directory to be writeable, to allow the geo-ip database to be
    # downloaded.
    fix-permissions /app/misc && chmod +w /app/misc && \
    # Allow the tracking file to be modified by Matomo. Used by plugins.
    fix-permissions /app/matomo.js && chmod +w /app/matomo.js

COPY ./lagoon/bootstrap.php /app/bootstrap.php
COPY ./lagoon/90-matomo-envs.sh  /lagoon/entrypoints/
