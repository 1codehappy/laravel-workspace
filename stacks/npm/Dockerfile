FROM mhart/alpine-node:16

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

ARG GROUPNAME
ARG GROUPID
ARG USERNAME
ARG USERID

ENV GROUPNAME=${GROUPNAME} \
    GROUPID=${GROUPID} \
    USERNAME=${USERNAME} \
    USERID=${USERID}

RUN mkdir -p /var/www/html \
    && (getent group ${GROUPID} || addgroup -g ${GROUPID} ${GROUPNAME}) \
    && export GROUPNAME=$(getent group "$GROUPID" | cut -d: -f1) \
    && adduser -u ${USERID} -D -G ${GROUPNAME} ${USERNAME} \
    && chown -R ${USERNAME}:${GROUPNAME} /var/www/html \
    && echo "$USERNAME ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers

USER ${USERNAME}

WORKDIR /var/www/html
