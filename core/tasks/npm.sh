#!/usr/bin/env bash
# Run NPM commands.
set -e

docker-compose run --rm --service-ports npm "$@"
