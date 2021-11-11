#!/usr/bin/env bash
# Run artisan commands.
set -e

docker-compose run --rm artisan "$@"
