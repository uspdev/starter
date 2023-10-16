FROM php:8.2

ARG PORT
ENV PORT 8000

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

WORKDIR /var/www
COPY . .
# workaround uspdev/replicado
RUN cp .env.example .env
RUN composer install --no-interaction --no-dev
ENTRYPOINT ./serve.sh

# fonte:
# [1] https://www.digitalocean.com/community/tutorials/how-to-install-and-set-up-laravel-with-docker-compose-on-ubuntu-22-04
