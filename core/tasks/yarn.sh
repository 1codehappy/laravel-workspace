#!/usr/bin/env bash
# Run Yarn commands.
set -e

docker-compose run --rm yarn "$@"
