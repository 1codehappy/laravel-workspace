# Laravel Workspace

An unique development experience using [Laravel](https//laravel.com) based on docker-compose lwsflow with the minimal settings to your local environment.

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

#### Bootstrap

To generate the `.env` and the `docker-compose.yml` file for the **Laravel Workspace** type:

```bash
./lws.sh bootstrap
```

#### Env file

__Skip this step if you've already executed the `bootstrap` command.__

Generate the env file:

```bash
./lws.sh copy-env
```

The `.env` file will be created in the root of **Laravel Workspace**.

```ini
USERNAME=laravel
GROUPNAME=laravel

LARAVEL_PATH=./laravel-api
LARAVEL_CMD="git clone git@github.com:vendor/repository.git"

MEMORY_LIMIT=256M
MAX_UPLOAD_FILE=20M

MYSQL_DATABASE=laravel
MYSQL_USERNAME=homestead
MYSQL_PASSWORD=secret
MYSQL_ROOT_PASSWORD=secret
```

These settings will be used to configure the **Laravel Workspace**.

#### Docker compose file

__Skip this step if you've already executed the `bootstrap` command.__

Generate the `docker-compose.yml` file:

```bash
./lws.sh copy-compose
```

The `docker-compose.yml` will be created in the root path.

#### Laravel

The command below will configure the laravel application:

```bash
./lws.sh app
```

You will see the laravel application created according to the `LARAVEL_PATH`.

#### Build Images

To build the docker images, you need to execute the command below:

```bash
./lws.sh build
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
./lws.sh up
./lws.sh up -d
./lws.sh up -d --build
```

#### Stop

To stop all docker containers, you must execute the command below:

```bash
docker-compose down
```
Or:

```bash
./lws.sh down
```

#### Composer

You can use the artisan commands using `docker-compose run --rm composer <<command>>` or typing the commands using `lws.sh`.

**Examples:**

```bash
./lws.sh composer
./lws.sh composer install
./lws.sh composer update
./lws.sh composer require <<package>>
```

#### Artisan

You can use the artisan commands using `docker-compose run --rm artisan <<command>>` or typing the commands using `lws.sh`.

**Examples:**

```bash
./lws.sh artisan
./lws.sh artisan key:generate
./lws.sh artisan migrate
./lws.sh artisan tinker
```

#### Yarn

As the artisan way, you can use `docker-compose run --rm yarn <<command>>`, but there is the Laravel Workspace option. You can uncomment if you are creating a monolith system at `docker-compose.yml`.

**Examples:**

```bash
./lws.sh yarn install
./lws.sh yarn add <<package>>
./lws.sh yarn run watch
./lws.sh yarn build
```

#### Npm

Same then above: `docker-compose run --rm npm <<command>>`. You can uncomment the `docker-compose.yml` to enable this container to develop.

**Examples:**

```bash
./lws.sh npm install
./lws.sh npm install <<package>>
./lws.sh npm run watch
./lws.sh npm build
```

## Local environment

- Laravel application: http://localhost
- PHPMyAdmin: http://localhost:8080
- Mailhog: http://localhost:8025

## Hot Reloading (Monolith)

If you are using `yarn run watch` or `npm run watch`, you need to access the 3000 port:

Add this code at the end of `webpack.mix.js`:

```js
  .browserSync({
    proxy: 'nginx',
    open: false,
    port: 3000,
  })
```

**PS:** *You will need to install browser-sync for hot realoading.*

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
./lws.sh console
./lws.sh console --root # logged as root
```

**PS:** *As default you are a regular user in docker container. If you want access as the root user you must add the prefix `--root` before the container name.*

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
