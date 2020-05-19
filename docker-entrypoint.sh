#!/bin/sh
set -e

# this is copied from https://github.com/matomo-org/docker/blob/master/fpm-alpine/docker-entrypoint.sh
# removed `chown -R www-data .`  as this fails in openshift
# added `|| true` at the end of the tar as this also throws some ignoreable errors

if [ ! -e matomo.php ]; then
	tar cf - --one-file-system -C /usr/src/matomo . | tar xf - || true
fi

exec "$@"