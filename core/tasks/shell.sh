#!/usr/bin/env bash
# Run a shell script inside container.
set -e

docker-compose exec "$@" sh
