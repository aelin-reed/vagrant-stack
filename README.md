# Vagrant Stack

An all-purpose vagrant stack configuration which aims to minimalize 
the required configuration when creating a new vagrant project.

## Features

- Laravel/WordPress Ready
- LAMP Stack
  - Ubuntu Linux
  - Apache2
    - mod_rewrite
  - MySQL 5
  - PHP 5.5
    - php-mcrypt
    - php-memcache
- Utilities
  - Base
    - Git
    - cURL
  - Composer
  - NodeJS/NPM
    - Bower
    - Grunt
    - Gulp
    - Yeoman

## Structure

`./vagrant`
The contents of this folder will be synchronized to the VM (`/vagrant/`)

`./vagrant/public`
The Apache document root.

## Usage

1. Execute `vagrant up` to install the stack
2. Place your application in `./vagrant/public/` (or in `./vagrant/` if you're using Laravel).
3. Your application is now available at http://localhost:8080/ by default.

**Note**: Default MySQL username/password is `root`.
