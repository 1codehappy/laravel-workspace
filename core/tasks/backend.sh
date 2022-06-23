#!/usr/bin/env bash
# Run a shell script inside container.
set -e

isBackEndStarted=$(docker container ls -q --filter name=backend)
if [ -z "${isBackEndStarted}" ]; then
    docker-compose exec backend /bin/ash -il;
else
    docker-compose run --rm backend /bin/ash -il;
fi
