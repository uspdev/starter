FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    freetds-bin \
    freetds-dev \
    libzip-dev \
    git \
    zip \
    unzip

# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# php libs
RUN docker-php-ext-install \
    pdo_dblib \
    pdo_mysql \
    zip

# laravel
COPY . .
RUN chown -R www-data: /var/www
RUN a2enmod rewrite
RUN sed -i 's|/var/www/html|/var/www/html/public|' /etc/apache2/sites-available/000-default.conf

USER www-data
RUN composer install --no-interaction --no-dev

CMD ["./serve.sh"]

# fonte:
# [1] https://www.digitalocean.com/community/tutorials/how-to-install-and-set-up-laravel-with-docker-compose-on-ubuntu-22-04
# [2] https://github.com/docker-library/php
