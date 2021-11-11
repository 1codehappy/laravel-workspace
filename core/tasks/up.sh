#!/usr/bin/env bash
# Start the Laravel Workspace.
set -e

docker-compose up "$@"

echo -e ""
echo -e "The ${GREEN}Laravel Workspace${NC} has been ${GREEN}started${NC}."
