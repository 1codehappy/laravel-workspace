#!/usr/bin/env bash
# Stop the Laravel Workspace.
set -e

docker-compose down

echo -e ""
echo -e "The ${GREEN}Laravel Workspace${NC} has been ${RED}stopped${NC}."
