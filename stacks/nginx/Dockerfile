FROM nginx:stable-alpine

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

ARG GROUPNAME
ARG GROUPID
ARG USERNAME
ARG USERID
ARG MAX_UPLOAD_FILE

ENV GROUPNAME=${GROUPNAME} \
    GROUPID=${GROUPID} \
    USERNAME=${USERNAME} \
    USERID=${USERID} \
    MAX_UPLOAD_FILE=${MAX_UPLOAD_FILE}

ADD ./default.conf /etc/nginx/conf.d/

RUN apk add --no-cache shadow \
    && mkdir -p /var/www/html \
    && (getent group ${GROUPID} || addgroup -g ${GROUPID} ${GROUPNAME}) \
    && export GROUPNAME=$(getent group "$GROUPID" | cut -d: -f1) \
    && adduser -u ${USERID} -D -G ${GROUPNAME} ${USERNAME} \
    && usermod -aG nginx ${USERNAME} \
    && chown -R ${USERNAME}:${GROUPNAME} /var/www/html \
    && chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
    && echo "$USERNAME ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
    && sed -i "s/client_max_body_size {{MAX_UPLOAD_FILE}};/client_max_body_size ${MAX_UPLOAD_FILE};/g" /etc/nginx/conf.d/default.conf \
    && apk del shadow
