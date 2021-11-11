#!/usr/bin/env bash
# Create .env file from example file.
set -e

CURRENT_ROOT=$(pwd)

SOURCE_ENV_FILE=${CURRENT_ROOT}/.env.example
TARGET_ENV_FILE=${CURRENT_ROOT}/.env

# set defaults.
if [[ -f ${SOURCE_ENV_FILE} && ! -f ${TARGET_ENV_FILE} ]]; then
    cp ${SOURCE_ENV_FILE} ${TARGET_ENV_FILE}
    # print the help line for the command.
    printf "The ${GREEN}.env${NC} file has been created.\n"
fi
