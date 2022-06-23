FROM nginx:stable-alpine

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

# default values for arguments.
ARG USER=lws
ARG GID=1000
ARG UID=1000
ARG PATH_TO_APP="/var/www/html"
ARG MAX_UPLOAD_FILE=20M

# set enviroment variables.
ENV USER=${USER} \
  GID=${GID} \
  UID=${UID} \
  PATH_TO_APP=${PATH_TO_APP} \
  MAX_UPLOAD_FILE=${MAX_UPLOAD_FILE}

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

# override nginx config.
ADD ./default.conf /etc/nginx/conf.d/

RUN set -ex \
# install packages to build.
&& apk add --no-cache --virtual .build-deps ${BUILD_DEPS} \
# create application path.
&& mkdir -p ${PATH_TO_APP} \
# create user and set user's permissions.
&& export OLDUSER=$(getent passwd ${UID} | cut -d: -f1) \
&& if [ -z "$OLDUSER" ]; \
  then \
      adduser -u ${UID} -D -g ${GID} ${USER} \
  ;else \
      usermod -l ${USER} ${OLDUSER} \
  ;fi \
&& export GROUP=$(getent group ${GID} | cut -d: -f1) \
&& if [ -z "$GROUP" ]; \
  then \
    addgroup -g ${GID} ${USER} \
    export GROUP=${USER} \
  ;fi \
&& chown -R ${USER}:${GROUP} ${PATH_TO_APP} \
&& echo "$USER ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
# remove build dependencies.
&& { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
&& apk del .build-deps \
# replace with enviroment variables.
&& sed -i "s|root %PATH_TO_APP%/public;|root ${PATH_TO_APP}/public;|g" /etc/nginx/conf.d/default.conf \
&& sed -i "s/client_max_body_size %MAX_UPLOAD_FILE%;/client_max_body_size ${MAX_UPLOAD_FILE};/g" /etc/nginx/conf.d/default.conf \
# remove unused files.
&& rm -rf ${UNUSED_FILES}
