FROM composer:2

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

# arguments to build.
ARG USER=lws
ARG GID=1000
ARG UID=1000
ARG PATH_TO_APP="/var/www/html"

# set environment variables.
ENV USER=${USER} \
	GID=${GID} \
	UID=${UID} \
	PATH_TO_APP=${PATH_TO_APP}

# remove unused files.
ENV UNUSED_FILES \
  /tmp/* \
  /usr/includes/* \
  /usr/local/lib/php/doc/* \
  /usr/share/man/* \
  /usr/src/* \
  /var/cache/apk/* \
  /var/tmp/*

RUN set -ex \
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
  # remove unused files.
  && rm -rf ${UNUSED_FILES}

USER ${USER}

WORKDIR ${PATH_TO_APP}
