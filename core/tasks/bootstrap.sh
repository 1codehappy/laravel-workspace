#!/usr/bin/env bash
# Bootstrap the application.
set -e

bash lws.sh copy-env "$@"
bash lws.sh copy-compose "$@"
