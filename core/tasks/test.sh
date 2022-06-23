#!/usr/bin/env bash
# Run php artisan test or pestphp, if installed.
set -e

if [ -f "${BACKEND_VOL}/tests/Pest.php" ]; then
    docker-compose run --rm pest "$@"
else
    docker-compose run --rm artisan test "$@"
fi
