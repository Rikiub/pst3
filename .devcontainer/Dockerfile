# Install PHP Apache
FROM docker.io/library/php:8.4-apache

# Install PDO extensions
RUN docker-php-ext-install pdo_mysql

# Enable Apache mod_rewrite (Essential for pretty URLs/Frameworks)
RUN a2enmod rewrite
