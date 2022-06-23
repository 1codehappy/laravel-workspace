#!/usr/bin/env bash
# Set javascript app up.
set -e

CURRENT_ROOT=$(pwd)

cd ${CURRENT_ROOT} || exit

${FRONTEND_CMD} ${FRONTEND_PATH}

sudo chown -R $(whoami):docker ${FRONTEND_PATH}

echo -e ""
echo -e "The ${GREEN}javascript app${NC} has been configured.\n"
