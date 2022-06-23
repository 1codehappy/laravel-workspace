#!/usr/bin/env bash
# Run a shell script inside container.
set -e

isFrontEndStarted=$(docker container ls -q --filter name=frontend)
if [ -z "${isFrontEndStarted}" ]; then
    docker-compose exec frontend /bin/ash -il;
else
    docker-compose run --rm frontend /bin/ash -il;
fi
