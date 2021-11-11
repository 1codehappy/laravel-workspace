#!/usr/bin/env bash
# Remove docker dangling images.
set -e

docker rmi -f $(docker images -f "dangling=true" -q)

echo -e ""
echo -e "The ${GREEN}docker dangling images${NC} have been removed."
