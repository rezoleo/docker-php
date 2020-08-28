ARG VERSION

FROM php:${VERSION}-apache

ARG APACHE_PUBLIC_FOLDER
ARG PHP_UPLOAD_MAX=5M

LABEL maintainer="Rezoleo <contact@rezoleo.fr>"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        gettext \
        unzip \
        zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install -j$(nproc) \
      gd \
      gettext \
      mysqli \
      pdo_mysql \
      zip \
    && a2enmod rewrite

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i 's/upload_max_filesize = .*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/' "$PHP_INI_DIR/php.ini" \
    && sed -i 's/post_max_size = .*/post_max_size = ${PHP_POST_MAX_SIZE}/' "$PHP_INI_DIR/php.ini"

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
    && sed -i 's/80/8080/' /etc/apache2/sites-enabled/000-default.conf \
    && sed -i 's/^Listen.*/Listen 8080/' /etc/apache2/ports.conf

USER www-data

EXPOSE 8080

ENV APACHE_DOCUMENT_ROOT=${APACHE_PUBLIC_FOLDER} \
    PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX} \
    PHP_POST_MAX_SIZE=${PHP_UPLOAD_MAX}