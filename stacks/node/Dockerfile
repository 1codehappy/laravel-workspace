FROM node:lts-alpine

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

# default values for arguments.
ARG USER=lws
ARG GID=1000
ARG UID=1000
ARG PATH_TO_APP="/var/www/html"

# set environment variables.
ENV USER=${USER} \
  GID=${GID} \
  UID=${UID} \
  PATH_TO_APP=${PATH_TO_APP}

# set packages.
ENV PERSISTENT_DEPS \
  sudo

# set packages to build.
ENV BUILD_DEPS \
  shadow

# remove unused files.
ENV UNUSED_FILES \
  /tmp/* \
  /usr/includes/* \
  /usr/local/lib/php/doc/* \
  /usr/share/man/* \
  /usr/src/* \
  /var/cache/apk/* \
  /var/tmp/*

# copy files.
COPY ./.profile /root/.profile

RUN set -ex \
  # install persistent packages.
  && apk --no-cache add --virtual .persistent-deps ${PERSISTENT_DEPS} \
  # install packages to build.
  && apk add --no-cache --virtual .build-deps "${BUILD_DEPS}" \
  # create application path.
  && mkdir -p ${PATH_TO_APP} \
  # remove node user
  && deluser --remove-home node \
  # create user and set user's permissions.
  && adduser -u ${UID} -D -g ${GID} ${USER} \
  && export GROUP=$(getent group ${GID} | cut -d: -f1) \
  && if [ -z "$GROUP" ]; \
    then \
        addgroup -g ${GID} ${USER} \
        && export GROUP=${USER} \
    ;fi \
  && cp /root/.profile /home/${USER}/.profile \
  && chown -R ${USER}:${GROUP} /home/${USER} \
  && chown -R ${USER}:${GROUP} ${PATH_TO_APP} \
  && echo "$USER ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
  # put docker image name in bash prompt.
  && sed -i "s/%%NODE_ALPINE_VERSION%%/node:lts-alpine/g" /home/${USER}/.profile \
  && sed -i "s/%%NODE_ALPINE_VERSION%%/node:lts-alpine/g" /root/.profile \
  # remove build dependencies.
  && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
  && apk del .build-deps \
  # remove unused files.
  && rm -rf ${UNUSED_FILES}

WORKDIR ${PATH_TO_APP}

USER ${USER}
