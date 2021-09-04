# docker-php

A PHP + Apache docker image with useful extensions preinstalled

The following versions of the image are available:
  - PHP 5.6
  - PHP 7.2
  - PHP 7.3
  - PHP 7.4
  - PHP 8.0

Apache `mod_rewrite` has been activated.

They all have the following extensions added:
  - gd
  - gettext
  - mysqli
  - pdo_mysql
  - xsl
  - zip

## Configuration :

By default the Apache `DocumentRoot` is set to `/var/www/html`.

You can also use the `APACHE_DOCUMENT_ROOT` environment variable
to change it (eg. `/var/www/html/public` for Symfony/Laravel).

By default the maximum upload size and maximum post size are set to 5 MB.

You can use the `PHP_UPLOAD_MAX_FILESIZE` and `PHP_POST_MAX_SIZE` to change them.
