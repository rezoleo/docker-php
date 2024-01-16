ARG VERSION

FROM php:${VERSION}-apache

LABEL maintainer="Rezoleo <contact@rezoleo.fr>"

# We will use the php installer from mlocati
# https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt-get update \
     # Let's update the base layer for security fixes, see
    # https://pythonspeed.com/articles/security-updates-in-docker/
    && apt-get upgrade -y \
    && apt-get install -y \
      gettext \
      unzip \
      zip \
    && rm -rf /var/lib/apt/lists/* \
    && install-php-extensions \
      gd \
      gettext \
      imap \
      mailparse \
      mysqli \
      pdo_mysql \
      xsl \
      zip \
    # Yes the file is still in the previous layers, but at least it cannot be used
    # to install new extensions from this point on
    && rm /usr/local/bin/install-php-extensions \
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

ENV APACHE_DOCUMENT_ROOT=/var/www/html \
    PHP_UPLOAD_MAX_FILESIZE=5M \
    PHP_POST_MAX_SIZE=5M
