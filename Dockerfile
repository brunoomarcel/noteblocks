FROM php:8.0-apache

# Instalar extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Definir o diretório raiz do documento como o diretório public via variável de ambiente
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy the application files to the container
COPY . /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80


