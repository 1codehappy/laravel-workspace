#!/usr/bin/env bash

# determine dset root.
CURRENT_ROOT=$(dirname $0)

# enter the root folder directory before starting.
cd ${CURRENT_ROOT} || exit

# include color helpers.
source ./core/helpers/colors.sh

# source env vars.
if [[ -f ".env" ]]; then
  source .env
fi

# define directory where tasks are stored.
TASKS_DIR="./core/tasks"

RAW_TASK_NAME=${1:-"help"}

# assign the first arg as task name, removing starting dashes (help vs --help)
TASK_NAME=$(echo "$RAW_TASK_NAME" | sed 's/^[^\(-)]+*-//'); shift

# display banner.
echo -e "\n${GREEN}Laravel Workspace${NC} Task Runner.\n"

# when the task exists...
if [[ -f "core/tasks/${TASK_NAME}.sh" ]]; then
  # run the task, passing extra args.
  source "core/tasks/${TASK_NAME}.sh" "$@"
# when the task does not exists.
else
  echo -e "=> ${RED}ERROR${NC}: Task ${RED}${TASK_NAME}${NC} does not exists."
  echo -e "   use ${GREEN}--help${NC} for listing the available tasks."
fi

# append a new line after all tasks output
echo -e ""
