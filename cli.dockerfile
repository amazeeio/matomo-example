FROM amazeeio/php:7.4-cli

ENV MATOMO_VERSION 3.13.6


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
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 814E346FA01A20DBB04B6807B5DBD5925590A237; \
	gpg --batch --verify matomo.tar.gz.asc matomo.tar.gz; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" matomo.tar.gz.asc; \
	tar -xzf matomo.tar.gz -C /app matomo/ --strip-components=1; \
	rm matomo.tar.gz; \
	apk del .fetch-deps

RUN mkdir -p /persistent && fix-permissions /persistent

COPY bootstrap.php /app/bootstrap.php

COPY 90-matomo-envs.sh  /lagoon/entrypoints/

ENV MATOMO_DATABASE_HOST=matomo-database \
		MATOMO_DATABASE_USERNAME=lagoon \
		MATOMO_DATABASE_PASSWORD=lagoon \
		MATOMO_DATABASE_DATABASE=lagoon \
		MATOMO_DATABASE_TABLES_PREFIX=matomo_