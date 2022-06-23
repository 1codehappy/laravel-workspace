#!/usr/bin/env bash
# Set laravel app up.
set -e

CURRENT_ROOT=$(pwd)

cd ${CURRENT_ROOT} || exit

if [[ "${BACKEND_CMD}" == "composer"* ]]; then
    CMD=$(echo "${BACKEND_CMD}" | sed -e "s/composer//g")
    docker run --rm -it -v $CURRENT_ROOT:/app composer:2 ${CMD}
    sudo chown -R $(whoami):docker ${BACKEND_PATH}
else
    ${BACKEND_CMD} ${BACKEND_PATH}
fi

SOURCE_ENV_FILE=${CURRENT_ROOT}/${BACKEND_PATH}/.env.example
TARGET_ENV_FILE=${CURRENT_ROOT}/${BACKEND_PATH}/.env

# copy laravel env file.
if [[ -f ${SOURCE_ENV_FILE} && ! -f ${TARGET_ENV_FILE} ]]; then
    cp ${SOURCE_ENV_FILE} ${TARGET_ENV_FILE}
fi

# replace env vars
sed -i "s/^DB_HOST=127.0.0.1$/DB_HOST=mysql/g" ${TARGET_ENV_FILE}
sed -i "s/^DB_DATABASE=laravel$/DB_DATABASE=${MYSQL_DATABASE}/g" ${TARGET_ENV_FILE}
sed -i "s/^DB_USERNAME=laravel$/DB_USERNAME=${MYSQL_USERNAME}/g" ${TARGET_ENV_FILE}
sed -i "s/^DB_PASSWORD=$/DB_PASSWORD=${MYSQL_PASSWORD}/g" ${TARGET_ENV_FILE}
sed -i "s/^CACHE_DRIVER=file$/CACHE_DRIVER=redis/g" ${TARGET_ENV_FILE}
sed -i "s/^SESSION_DRIVER=file$/SESSION_DRIVER=redis/g" ${TARGET_ENV_FILE}
sed -i "s/^REDIS_HOST=127.0.0.1$/REDIS_HOST=redis/g" ${TARGET_ENV_FILE}

if [[ ! -d "${SOURCE_ENV_FILE}/vendor" ]]; then
    docker run --rm -it -v $CURRENT_ROOT/${BACKEND_PATH}:/app composer:2 install \
        --ignore-platform-reqs \
        --no-scripts
fi

sudo chown -R $(whoami):docker ${BACKEND_PATH}
sudo chmod -R 775 ${BACKEND_PATH}/bootstrap/cache
sudo chmod -R 775 ${BACKEND_PATH}/storage

echo -e ""
echo -e "The ${GREEN}laravel app${NC} has been configured.\n"
