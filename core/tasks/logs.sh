#!/usr/bin/env bash
# Display logs from container.
set -e

docker-compose logs "$@"
