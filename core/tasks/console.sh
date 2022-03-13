#!/usr/bin/env bash
# Run a shell script inside container.
set -e

if [ "$1" == "--root" ]; then
    docker-compose exec --user=root laravel sh
    return
fi

docker-compose exec laravel sh
