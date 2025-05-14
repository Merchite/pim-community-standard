FROM php:8.1-apache

# Install required system packages
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libicu-dev libonig-dev libxml2-dev \
    libpq-dev libjpeg-dev libpng-dev libfreetype6-dev gnupg \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-install pdo pdo_mysql intl zip opcache gd xml bcmath \
    && apt-get clean


# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . /var/www/html

# Set Apache document root to Akeneo's public directory
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Override Apache config to use the new document root
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html
