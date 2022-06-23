FROM php:8.1-fpm-alpine

LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

# default values for arguments.
ARG USER=lws
ARG GID=1000
ARG UID=1000
ARG PATH_TO_APP="/var/www/html"
ARG MEMORY_LIMIT=512M
ARG MAX_UPLOAD_FILE=20M
ARG PHP_LIBS=""
ARG PHP_CONFIGURE_DEPS="[]"
ARG PHP_INSTALL_DEPS=""
ARG PECL_INSTALL_DEPS=""
ARG PHP_ENABLE_DEPS=""
ARG NEW_RELIC_KEY
ARG NEW_RELIC_APP_NAME
ARG NEW_RELIC_AGENT_VERSION

# set enviroment variables.
ENV USER=${USER} \
  GID=${GID} \
  UID=${UID} \
  PATH_TO_APP=${PATH_TO_APP} \
  PHP_LIBS=${PHP_LIBS} \
  PHP_INSTALL_DEPS=${PHP_INSTALL_DEPS} \
  PHP_CONFIGURE_DEPS=${PHP_CONFIGURE_DEPS} \
  PHP_ENABLE_DEPS=${PHP_ENABLE_DEPS} \
  PECL_INSTALL_DEPS=${PECL_INSTALL_DEPS} \
  MEMORY_LIMIT=${MEMORY_LIMIT} \
  MAX_UPLOAD_FILE=${MAX_UPLOAD_FILE} \
  NEW_RELIC_KEY=${NEW_RELIC_KEY} \
  NEW_RELIC_APP_NAME=${NEW_RELIC_APP_NAME} \
  NEW_RELIC_AGENT_VERSION=${NEW_RELIC_AGENT_VERSION}

# set persistent packages.
ENV PERSISTENT_DEPS \
  sudo

# set build packages.
ENV BUILD_DEPS \
  gettext \
  shadow \
  zlib-dev \
  openssl-dev

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
COPY ./custom.ini /usr/local/etc/php/conf.d/zzz-custom.ini
COPY ./opcache.ini /tmp/zzz-opcache.ini
COPY ./xdebug.ini /tmp/zzz-xdebug.ini
COPY ./php-fpm.sh /home/php-fpm.sh

RUN set -ex \
  # install jq.
  && apk --no-cache add jq \
  # check php deps.
  && if [ ! -z "$PHP_LIBS" ]; \
    then \
      for dep in ${PHP_LIBS}; \
        do \
          case "$dep" in \
            # amqp.
            (amqp) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} rabbitmq-c" \
              BUILD_DEPS="${BUILD_DEPS} rabbitmq-c-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} amqp" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} amqp" \
              ;; \
            # apcu.
            (apcu) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} apcu" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} apcu" \
              ;; \
            # bcmath.
            (bcmath) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} bcmath" \
              ;; \
            # calendar.
            (calendar) \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "calendar"}]') \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} calendar" \
              ;; \
            # decimal.
            (decimal) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} mpdecimal" \
              BUILD_DEPS="${BUILD_DEPS} mpdecimal-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} decimal" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} decimal" \
              ;; \
            # exif.
            (exif) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} exif" \
              ;; \
            # gettext.
            (gd) \
              BUILD_DEPS="${BUILD_DEPS} freetype-dev libjpeg-turbo-dev libwebp" \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "gd", "args": "--enable-gd --with-freetype --with-jpeg --with-webp"}]') \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} gd" \
              ;; \
            # gettext.
            (gettext) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} gettext" \
              BUILD_DEPS="${BUILD_DEPS} gettext-dev" \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} gettext" \
              ;; \
            # gmp.
            (gmp) \
              BUILD_DEPS="${BUILD_DEPS} gmp-dev" \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} gmp" \
              ;; \
            # imagick.
            (imagick) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} imagemagick" \
              BUILD_DEPS="${BUILD_DEPS} imagemagick-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} imagick" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} imagick" \
              ;; \
            # imap.
            (imap) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} imap c-client" \
              BUILD_DEPS="${BUILD_DEPS} imap-dev krb5-dev" \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "imap", "args": "--with-imap --with-kerberos --with-imap-ssl"}]') \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} imap" \
              ;; \
            # intl.
            (intl) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} icu" \
              BUILD_DEPS="${BUILD_DEPS} icu-dev" \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "intl"}]') \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} intl" \
              ;; \
            # ldap.
            (ldap) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} libldap" \
              BUILD_DEPS="${BUILD_DEPS} ldb-dev openldap-dev" \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "ldap", "arguments": "--prefix=/usr/local/php --with-ldap=/usr/lib/i386-linux-gnu"}]') \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} ldap" \
              ;; \
            # mailparse.
            (mailparse) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} mailparse" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} mailparse" \
              ;; \
            # memcached.
            (memcached) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} libmemcached" \
              BUILD_DEPS="${BUILD_DEPS} libmemcached-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} memcached" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} memcached" \
              ;; \
            # mongo.
            (mongo) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} mongodb" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} mongodb" \
              ;; \
            # mysqli.
            (mysqli) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} mysqli" \
              ;; \
            # new relic agent.
            (newrelic) \
              curl -L http://download.newrelic.com/php_agent/release/newrelic-php5-`${NEW_RELIC_AGENT_VERSION}`-linux.tar.gz | tar -C /tmp -zx \
              && export NR_INSTALL_USE_CP_NOT_LN=1 \
              && export NR_INSTALL_SILENT=1 \
              && /tmp/newrelic-php5-*/newrelic-install install \
              && sed -i \
                -e 's/"REPLACE_WITH_REAL_KEY"/"'${NEW_RELIC_KEY}'"/' \
                -e 's/newrelic.appname = "PHP Application"/newrelic.appname = "'${NEW_RELIC_APP_NAME}'"/' \
                -e 's/;newrelic.daemon.app_connect_timeout =.*/newrelic.daemon.app_connect_timeout=15s/' \
                -e 's/;newrelic.daemon.start_timeout =.*/newrelic.daemon.start_timeout=5s/' \
                /usr/local/etc/php/conf.d/newrelic.ini \
              ;; \
            # opcache.
            (opcache) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} opcache" \
              && cp /tmp/zzz-opcache.ini /usr/local/etc/php/conf.d/zzz-opcache.ini \
              ;; \
            # pcov.
            (pcov) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} pcov" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} pcov" \
              ;; \
            # pdo_mysql
            (pdo_mysql) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} pdo_mysql" \
              ;; \
            # pgsql.
            (pdo_pgsql) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} libpq" \
              BUILD_DEPS="${BUILD_DEPS} libpq-dev" \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} pdo_pgsql" \
              ;; \
            # pcntl.
            (pcntl) \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} pcntl" \
              ;; \
            # rdkafka.
            (rdkafka) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} librdkafka" \
              BUILD_DEPS="${BUILD_DEPS} librdkafka-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} rdkafka" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} rdkafka" \
              ;; \
            # redis.
            (redis) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} redis" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} redis" \
              ;; \
            # smb.
            (smb) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} samba" \
              BUILD_DEPS="${BUILD_DEPS} libsmbclient samba-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} smbclient" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} smbclient" \
              ;; \
            # soap.
            (soap) \
              BUILD_DEPS="${BUILD_DEPS} libxml2-dev php-soap" \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} soap" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} soap" \
              ;; \
            # swoole.
            (swoole) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} swoole" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} swoole" \
              ;; \
            # trader.
            (trader) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} trader" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} trader" \
              ;; \
            # xdebug.
            (xdebug) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} xdebug" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} xdebug" \
              && cp /tmp/zzz-xdebug.ini /usr/local/etc/php/conf.d/zzz-xdebug.ini \
              ;; \
            # xlswriter.
            (xlswriter) \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} xlswriter" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} xlswriter" \
              ;; \
            # xmlrpc.
            (xmlrpc) \
              BUILD_DEPS="${BUILD_DEPS} libxml2-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} xmlrpc-1.0.0RC3" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} xmlrpc" \
              ;; \
            # xsl.
            (xsl) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} libxslt" \
              BUILD_DEPS="${BUILD_DEPS} libxslt-dev" \
              PHP_INSTALL_DEPS="${PHP_INSTALL_DEPS} xsl" \
              ;; \
            # yaml.
            (yaml) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} yaml" \
              BUILD_DEPS="${BUILD_DEPS} yaml-dev" \
              PECL_INSTALL_DEPS="${PECL_INSTALL_DEPS} yaml" \
              PHP_ENABLE_DEPS="${PHP_ENABLE_DEPS} yaml" \
              ;; \
            # zip.
            (zip) \
              PERSISTENT_DEPS="${PERSISTENT_DEPS} zip" \
              BUILD_DEPS="${BUILD_DEPS} libzip-dev" \
              PHP_CONFIGURE_DEPS=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '. += [{"dep": "zip", "args": "--with-libzip"}]') \
              ;; \
            (*) \
              echo "Extension not allowed: ${dep}" \
              break \
              ;; \
          esac \
        ;done \
    ;fi \
  # install persistent packages.
  && apk --no-cache add --virtual .persistent-deps ${PERSISTENT_DEPS} \
  # install build packages.
  && apk --no-cache add --virtual .build-deps ${PHPIZE_DEPS} \
    ${BUILD_DEPS} \
  # configure php extensions.
  && if [ $(echo "$PHP_CONFIGURE_DEPS" | jq '. | length') -ge 1 ]; \
    then \
      for dep in $(echo "${PHP_CONFIGURE_DEPS}" | jq -r '.[] | .dep'); \
        do \
          json=$(echo "$PHP_CONFIGURE_DEPS" | jq -c '.[] | select(.dep | contains("$dep"))') \
          && args=$(echo "$json" | jq '.args') \
          && if [[ -z ${args} ]]; \
            then \
              docker-php-ext-configure $(echo ${dep} | tr -d '"') $(echo ${args} | tr -d '"') \
            ;else \
              docker-php-ext-configure $(echo ${dep} | tr -d '"') \
            ;fi \
        ;done \
    ;fi \
  # install php extensions.
  && if [ ! -z "$PHP_INSTALL_DEPS" ]; \
    then \
      NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
      && docker-php-ext-install -j${NUMPROC} ${PHP_INSTALL_DEPS} \
    ;fi \
  # install pecl packages.
  && if [ ! -z "$PECL_INSTALL_DEPS" ]; \
    then \
      echo "DEBUG: pecl install ${PECL_INSTALL_DEPS}" \
      && pecl install ${PECL_INSTALL_DEPS} \
    ;fi \
  # enable php extensions.
  && if [ ! -z "$PHP_ENABLE_DEPS" ]; \
    then \
      echo "DEBUG: pecl install ${PECL_INSTALL_DEPS}" \
      && docker-php-ext-enable ${PHP_ENABLE_DEPS} \
    ;fi \
  && envsubst < /usr/local/etc/php/conf.d/zzz-custom.ini \
  && sed -i "s/user = www-data/user = ${USER}/g" /usr/local/etc/php-fpm.d/www.conf \
  && sed -i "s/group = www-data/group = ${USER}/g" /usr/local/etc/php-fpm.d/www.conf \
  && echo "php_admin_flag[log_errors] = on" >> /usr/local/etc/php-fpm.d/www.conf \
  && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
  # create application path.
  && mkdir -p ${PATH_TO_APP} \
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
  && chown ${USER}:${GROUP} /home/php-fpm.sh \
  && chmod +x /home/php-fpm.sh \
  # put docker image name in bash prompt.
  && sed -i "s/%%PHP_FPM_ALPINE_VERSION%%/php:8.1-fpm-alpine/g" /home/${USER}/.profile \
  && sed -i "s/%%PHP_FPM_ALPINE_VERSION%%/php:8.1-fpm-alpine/g" /root/.profile \
  # remove unused files.
  && docker-php-source delete \
  && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
  && apk del --no-cache --no-network .build-deps jq \
  && rm -rf ${UNUSED_FILES}

# set default path.
WORKDIR ${PATH_TO_APP}

# set user.
USER ${USER}

# start php-fpm.
CMD ["/bin/ash", "/home/php-fpm.sh"]
