#!/usr/bin/env bash
# Validate the Laravel Workspace.
set -e

CURRENT_ROOT=$(pwd)

ENV_FILE=${CURRENT_ROOT}/.env
COMPOSE_FILE=${CURRENT_ROOT}/docker-compose.yml

# validate env file.
if [[ ! -f ${ENV_FILE} ]]; then
  echo -e "=> ${RED}ERROR${NC}: The ${RED}.env${NC} file does not exists."
fi

# validate compose file.
if [[ ! -f ${COMPOSE_FILE} ]]; then
  echo -e "=> ${RED}ERROR${NC}: The ${RED}docker-compose.yml${NC} file does not exists."
fi

if [[ -f ${ENV_FILE} && -f ${COMPOSE_FILE} && -z "$1" ]]; then
  echo -e  "The ${GREEN}Laravel Workspace${NC} is valid.\n"
fi
