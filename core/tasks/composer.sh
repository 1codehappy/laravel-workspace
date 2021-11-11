#!/usr/bin/env bash
# Run composer commands.
set -e

docker-compose run --rm composer "$@"
