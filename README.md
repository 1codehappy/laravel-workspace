# Laravel Workspace

An unique development experience using [Laravel](https//laravel.com) based on docker-compose workflow with the minimal settings to your local environment.

You can customize everything here. Feel free to modify as you need.

## Requirements

- A supported OS:
    - macOS
    - Linux
- GIT
- Docker
  - macOS: [docker-ce-desktop-mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
  - Linux: [get.docker.com](https://get.docker.com)
- Docker Compose
    - macOS [install guide](https://docs.docker.com/compose/install/#install-compose-on-macos) (Already installed with Docker for Mac)
    - Linux: [install guide](https://docs.docker.com/compose/install/#install-compose-on-linux-systems)

## Services

- nginx (:80)
- backend (:9000)
- mysql (:3306)
- phpmyadmin (:8080)
- redis (:6379) `optional`.
- redis-commander (:8081) `optional`.
- mailhog (:1025, :8025) `optional`.
- minio (:9001, :9080)  `optional`.
- frontend (:3000) `optional`.
- storybook (:6006) `optional`.

## Installation

Type the follow command in your terminal:

```bash
 wget https://github.com/1codehappy/laravel-workspace/archive/refs/heads/master.zip
 unzip master
 rm master.zip
 cd laravel-workspace-master
 ```

 Or

 ```bash
git clone git@github.com:1codehappy/laravel-workspace.git
 ```

## Available PHP Extensions

amqp  apcu  bcmath  calendar  decimal  exif  gd  gettext  gmp  imagick  imap  intl  ldap  mailparse  memcached  mongo  mysqli  newrelic  opcache  pcov  pdo_mysql  pdo_pgsql  pcntl  rdkafka  redis  smb  soap  swoole  trader  xdebug  xlswriter  xmlrpc  xsl  yaml  zip

## Usage

### Bootstrap
To generate the `.env` and the `docker-compose.yml` file for the **Laravel Workspace** type:
```bash
./lws.sh bootstrap
```

#### Editing your .env file

The code above represents the simple structure of `.env` file.

```env
# User
LWUSER=lws
LWGID=1000 # id -g
LWUID=1000 # id -u

# Laravel configs
BACKEND_VOL=./backend
BACKEND_CMD="composer create-project --prefer-dist laravel/laravel"
BACKEND_PATH=/var/www/html

# Javascript configs
FRONTEND_VOL=./frontend
FRONTEND_CMD="git clone git@<<GIT_REPOSITORY_PATH>>/<<vendor>>/<<project>>"
FRONTEND_PATH=/var/www/html

# PHP configs
FPM_MEMORY_LIMIT=512M
CLI_MEMORY_LIMIT=1G
MAX_UPLOAD_FILE=20M
PERSISTENT_DEPS="sudo"
BUILD_DEPS="gettext shadow"
PHP_LIBS="pdo_mysql redis xdebug"
NEW_RELIC_KEY=
NEW_RELIC_APP_NAME=
NEW_RELIC_AGENT_VERSION=

# Database configs
MYSQL_DATABASE=lws
MYSQL_USERNAME=lws
MYSQL_PASSWORD=secret
MYSQL_ROOT_PASSWORD=secret
```

#### User Environment Variables

- `LWUSER`: represents the user's name.
- `LWGID`: represents the user's group ID.
- `LWUID`: represents the user's ID.

You can change the LWUSER variable as you need. But the other 2 of them need to be configured carefully.

Open a ssh terminal and type:

```bash
id -g $(whoami) # LWGID
id -u $(whoami) # LWUID
```

- By default, LWGID/LWUID came with values of Ubuntu fresh install.
- If you have more then one user or use another OS you will need do set correctly to avoid permission issues.

#### Laravel Environment Variables

- `BACKEND_VOL`: path to share with the container.
- `BACKEND_CMD`: command to install repository (if needed).
- `BACKEND_PATH`: repository path inside container.

You need to declare these variables to configure the laravel project path.

#### Javascript Environment Variables
- `FRONTEND_VOL`: path to share with the container.
- `FRONTEND_CMD`: command to install repository (if needed).
- `FRONTEND_PATH`: repository path inside container.

#### PHP Environment Variables

- `FPM_MEMORY_LIMIT`: `php_memory_limit` configuration to web.
- `CLI_MEMORY_LIMIT`: `php_memory_limit` configuration to console.
- `MAX_UPLOAD_FILE`: `max_upload_file` and `post_max_size` configuration to web.
- `PERSISTENT_DEPS`: packages to install.
- `BUILD_DEPS`: packages to install and delete after installing php extensions.
- `PHP_LIBS`: PHP/PECL extensions to configure, enable and install them.
- `NEW_RELIC_KEY`: New Relic key to authorize the agent.
- `NEW_RELIC_APP_NAME`: New Relic application name.
- `NEW_RELIC_AGENT_VERSION`: New Relic agent version to download.

Edit your `.env` file and add the [available php extensions](https://github.com/1codehappy/laravel-workspace/blob/master/README.md#available-php-extensions) that you need. You don't need to know what package is required.

```ini
PHP_LIBS="amqp apcu bcmath calendar decimal exif gd gettext gmp imagick imap intl ldap mailparse memcached mongo mysqli newrelic opcache pcov pdo_mysql pdo_pgsql pcntl rdkafka redis smb soap swoole trader xdebug xlswriter xmlrpc xsl yaml zip"
```

#### Database Environment Variables

- `MYSQL_DATABASE`: database name.
- `MYSQL_USERNAME`: database user's name.
- `MYSQL_PASSWORD`: database user's password
- `MYSQL_ROOT_PASSWORD`: database root password.

### docker-compose.yml

#### Default Services

- The `docker-compose.yml` is generated as a copy of `docker-compose.yml.example`.
- The initial is setted up to run a basic laravel application.

**Original file:**
```.yaml
services:
  nginx: # request and deliver content for the backend application.
    # ...
  backend: # laravel applicaiton.
    # ...
  composer: # to composer functions.
    # ...
  artisan: # artisan commands.
    # ...
  mysql: database container.
    # ...
  phpmyadmin: visual web IDE for MySQL database.
    # ...
```

#### Available Services

- The others services are commented by default.
- You can uncomment, modify or add new services to run in development environment.

```.yaml
services:
  pestphp: # if you install pestphp you can uncomment it to use the container.
    # ...
  frontend: # you can use a docker container for the javascript application.
    # ... you can modify it and put how it works for you.
  storybook: # you can use a docker container for storybook.
    # ... you can modify it and put how it works for you.
  redis: database container.
    # ... You must uncomment the related docker volume at the end of file.
  rc: visual web IDE for Redis.
    # ...
  mailhog: An email service.
    # ... Some instructions about how it needs to configure in Laravel are commented.
  minio: Simulates a AWS S3 to use with Laravel.
    # ... Some instructions about how it needs to configure in Laravel are commented.
    # ... You must uncomment the related docker volume at the end of file.
```

### Set Back End Application Up
- You will see the laravel application created according to the `backend` variables started with `BACKEND_` prefix at `.env` file.

The command below will configure the laravel application:
```bash
./lws.sh setup-be
```

### Set Front End Application Up
- You will see the frontend application created according to the `frontend` variables started with `FRONTEND_` prefix at `.env` file.

The command below will configure the javascript application:
```bash
./lws.sh setup-fe
```

### Build Images
To build the docker images, you need to execute the command below:
```bash
./lws.sh build
```
It takes some time to build. I think you can have a coffee now.

### Start
Navigate in your terminal to the directory you cloned this to start all docker containers:
```bash
docker-compose up
docker-compose up -d
docker-compose up --build
```
Or:
```bash
./lws.sh start
./lws.sh start -d
./lws.sh start -d --build
```

### Stop
To stop all docker containers, you must execute the command below:
```bash
docker-compose down
```
Or:
```bash
./lws.sh stop
```

### Laravel App

#### Backend

You can use `docker-compose exec backend <<command>>`, but there is the Laravel Workspace option to go to shell prompt.
```bash
./lws.sh backend # docker-compose exec backend /bin/ash -il
```
#### Composer
You can use the artisan commands using `docker-compose run --rm composer <<command>>` or typing the commands using `lws.sh`.
```bash
./lws.sh composer install
./lws.sh composer update
./lws.sh composer require <<package>>
```

#### Artisan
You can use the artisan commands using `docker-compose run --rm artisan <<command>>` or typing the commands using `lws.sh`.
```bash
./lws.sh artisan
./lws.sh artisan key:generate
./lws.sh artisan migrate
./lws.sh artisan tinker
```

### Javascript App

#### Frontend
As the artisan way, you can use `docker-compose exec frontend <<command>>`, but there is the Laravel Workspace option to go to shell prompt.
```bash
./lws.sh frontend # docker-compose exec frontend /bin/ash -il
```

## Local environment
- Backend application: http://localhost
- Frontend application: http://localhost:3000 `optional`
- Storybook: http://localhost:6006 `optional`
- PHPMyAdmin: http://localhost:8080
- Redis Commander: http://localhost:8081 `optional`
- Mailhog: http://localhost:8025 `optional`
- Minio: http://localhost:9001 `optional`
   - user: MEJHLMRWKAZTYMEFSRJL
   - password: LBybk6EmwNDGLQztdKkU3DMTVruAWdAEeyDYXwQs

**PS:** *As default you are a regular user in docker container. If you want to install or remove any package, you should use `sudo` inside backend/frontend containers.*

And you can check the container logs, if needed:

```bash
./lws.sh logs nginx
./lws.sh logs -f nginx
./lws.sh logs laravel
./lws.sh logs -f laravel
```

## Available commands

Type the command below to see all commands:

```bash
./lws.sh
```

---

<sub>by **CodeHappy ;)**</sub>
