FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git zip unzip curl libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    libicu-dev libxml2-dev libonig-dev libpq-dev libxslt-dev libssl-dev \
    && docker-php-ext-install pdo pdo_mysql zip intl xsl gd opcache

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Set permissions
RUN chown -R www-data:www-data /var/www/html
