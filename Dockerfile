FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libicu-dev libonig-dev libxml2-dev \
    libpq-dev libjpeg-dev libpng-dev libfreetype6-dev gnupg \
    && docker-php-ext-install pdo pdo_mysql intl zip opcache gd xml \
    && apt-get clean

RUN a2enmod rewrite

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html
