# docker-php

[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=rezoleo/docker-php)](https://dependabot.com)

A PHP + Apache docker image with useful extensions preinstalled

The following versions of the image are available:
  - [PHP 7.2](./7.2-apache)
  - [PHP 7.3](./7.3-apache)

They all come in two flavors:
  - Apache `DocumentRoot` set to `/var/www/html/public` (eg. for Symfony/Laravel)
  - Apache `DocumentRoot` set to `/var/www/html` (for other cases)

They all have the following extensions added:
  - gd
  - gettext
  - pdo_mysql
  - zip
