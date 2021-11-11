#!/usr/bin/COMPOSE bash
# Create docker-compose.yml file from example file.
set -e

CURRENT_ROOT=$(pwd)

SOURCE_COMPOSE_FILE=${CURRENT_ROOT}/docker-compose.yml.example
TARGET_COMPOSE_FILE=${CURRENT_ROOT}/docker-compose.yml

# set defaults.
if [[ -f ${SOURCE_COMPOSE_FILE} && ! -f ${TARGET_COMPOSE_FILE} ]]; then
    cp ${SOURCE_COMPOSE_FILE} ${TARGET_COMPOSE_FILE}
    # print the help line for the command.
    printf "The ${GREEN}docker-compose.yml${NC} file has been created.\n"
fi
