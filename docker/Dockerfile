FROM php:8.1-fpm

# Install system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libicu-dev libonig-dev libxml2-dev \
    libpq-dev libjpeg-dev libpng-dev libfreetype6-dev gnupg \
    libmagickwand-dev imagemagick \
    && pecl install apcu imagick \
    && docker-php-ext-enable apcu imagick \
    && docker-php-ext-install pdo pdo_mysql intl zip opcache gd xml bcmath exif pcntl \
    && apt-get clean

# Increase PHP memory limit to 1 GB
RUN echo "memory_limit=1G" > /usr/local/etc/php/conf.d/memory-limit.ini

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html
