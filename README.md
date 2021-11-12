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

## Default services

- nginx (:80)
- mysql (:3306)
- redis (:6379)
- phpmyadmin (:8080)
- mailhog (:1025, :8025)

## Usage

#### Env file

Generate the env file:

```bash
./work.sh copy-env
```

The `.env` file will be created in the root of **Laravel Workspace**.

```ini
USERNAME=laravel
GROUPNAME=laravel

LARAVEL_PATH=./laravel-api
LARAVEL_CMD="git clone git@github.com:vendor/repository.git"

MEMORY_LIMIT=256M
MAX_UPLOAD_FILE=20M
```

These settings will be used to configure the **Laravel Workspace**.

#### Docker compose file

Generate the docker-compose file:

```bash
./work.sh copy-compose
```

The `docker-compose.yml` will be created in the root path as the `.env` file.

#### Laravel

The command below will configure the laravel application:

```bash
./work.sh app
```

You will see the laravel application created according to the `LARAVEL_PATH`.

#### Build Images

To build the docker images, you need to execute the command below:

```bash
./work.sh build
```

It takes some time to build. I think you can have a coffee now.

#### Start

Navigate in your terminal to the directory you cloned this to start all docker containers:

```bash
docker-compose up
docker-compose up -d
docker-compose up --build
```

Or:

```bash
./work.sh up
./work.sh up -d
./work.sh up -d --build
```

#### Stop

To stop all docker containers, you must execute the command below:

```bash
docker-compose down
```
Or:

```bash
./work.sh down
```

#### Composer

You can use the artisan commands using `docker-compose run --rm composer <<command>>` or typing the commands using `work.sh`.

**Examples:**

```bash
./work.sh composer
./work.sh composer install
./work.sh composer update
./work.sh composer require <<package>>
```

#### Artisan

You can use the artisan commands using `docker-compose run --rm artisan <<command>>` or typing the commands using `work.sh`.

**Examples:**

```bash
./work.sh artisan
./work.sh artisan key:generate
./work.sh artisan migrate
./work.sh artisan tinker
```

#### Yarn

As the artisan way, you can use `docker-compose run --rm yarn <<command>>`, but there is the Laravel Workspace option. This is the default container for javascript stuff.

**Examples:**

```bash
./work.sh yarn install
./work.sh yarn add <<package>>
./work.sh yarn run watch
./work.sh yarn build
```

#### Npm

Same then above: `docker-compose run --rm npm <<command>>`. You can uncomment the `docker-compose.yml` to enable this container to develop.

**Examples:**

```bash
./work.sh npm install
./work.sh npm install <<package>>
./work.sh npm run watch
./work.sh npm build
```

## Local environment

- Laravel application: http://localhost
- PHPMyAdmin: http://localhost:8080
- Mailhog: http://localhost:8025

## Hot Reloading

If you are using `yarn run watch` or `npm run watch`, you need to access the 3000 port:

- http://localhost:3000

## Plus

If you need access inside the container or to install any package, you can do it.

**Available Containers:**

- nginx (Alpine OS)
- php (Alpine OS)
- mysql (Debian OS)
- phpmyadmin (Alpine OS)
- redis (Alpine OS)
- mailhog (Alpine OS)

**Examples:**

```bash
./work.sh shell php
./work.sh shell --user=root php apk add --no-cache curl
```

**PS:** *As default you are a regular user in docker container. If you want access as the root user you must add the prefix `--user=root` before the container name.*

And you can check the container logs, if needed:

```bash
./work.sh logs nginx
./work.sh logs -f nginx
```

## Available commands

Type the command below to see all commands:

```bash
./work.sh
```

---

<sub>by **CodeHappy ;)**</sub>
