#!/usr/bin/env bash
# Display help (list commands).

# define the directory where tasks exists.
TASKS_DIR="./core/tasks"

# get tasks by detecting all the .sh files.
ALL_TASKS=$(find ${TASKS_DIR} -type f -name '*.sh')

# sub banner for commands list.
echo -e "Commands:\n"

# loop tasks.
for TASK_PATH in ${ALL_TASKS}; do
  # detect task name based on file name.
  TASK_NAME=$(basename ${TASK_PATH} .sh)
  # use the second line of the file as help description.
  TASK_HELP=$(cat ${TASK_PATH} | head -2 | tail -1)

  # print the help line for the command.
  printf "bash lws.sh ${GREEN}%-25s${NC}" ${TASK_NAME}; printf "${TASK_HELP}\n"
done


