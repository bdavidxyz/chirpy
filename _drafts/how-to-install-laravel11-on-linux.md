how-to-install-laravel11-on-linux

# How to install Laravel 11 on linux

## Prerequisite

By default, Laravel v11 tries to connect to a sqlite database, so ensure it is properly installed with

```shell
sudo apt install php-sqlite3
```

## Install PHP8.3

Laravel 11 requires PHP 8.2 or 8.3, so let's install the latest version

It should work the same way if you installed MySql and not PostGre

### 1. Run system updates

```shell
sudo apt update && apt upgrade -y
```

### 2. Add Ondrej repository

The current maintainer of PHP is Ondrej Sury. It sounds odds that the package of such a language doesn't belong to an organisation, but here you can add it safely : 

```shell
sudo add-apt-repository ppa:ondrej/php
```

Update all repositories once again with

```shell
sudo apt update
```

Check PHP version with 

```shell
php --version
# PHP 8.3.3-1+ubuntu22.04.1+deb.sury.org+1 (cli)
```

### 3. Add dependencies

Laravel will be buggy if you don't install PHP base modules

```shell
sudo apt-get install -y php8.3-cli php8.3-common php8.3-fpm php8.3-zip php8.3-gd php8.3-mbstring php8.3-curl php8.3-xml php8.3-bcmath
```

## Install composer

`composer` is a tool to build new laravel application.

Follow first paragraph of [getcomposer](https://getcomposer.org/download/)

Ensure it is properly working on your machine by typing

```shell
composer  --version
# Composer version 2.7.2 2024-03-11 17:12:18
```

## Create a default Laravel 11 application

```shell
composer create-project laravel/laravel=11 MyApp
```

Installation will last a few second, it should end up with migrations, like this

```shell
# long previous logs...

   INFO  Running migrations.  

  0001_01_01_000000_create_users_table .......................... 31.91ms DONE
  0001_01_01_000001_create_cache_table .......................... 18.81ms DONE
  0001_01_01_000002_create_jobs_table ........................... 24.48ms DONE
```

## Run the application

```shell
cd MyApp
php artisan serve
```

Open browser at [http://127.0.0.1:8000](http://127.0.0.1:8000), and ta-da!

