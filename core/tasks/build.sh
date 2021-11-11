#!/usr/bin/env bash
# Build docker images.
set -e

export USERID=$(id -u)
export GROUPID=$(cut -d: -f3 < <(getent group docker))

docker-compose build

printf "The ${GREEN}docker images${NC} have been created.\n"