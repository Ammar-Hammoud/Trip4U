FROM php:8.2.11
RUN apt-get update -y && apt-get install -y openssl zip unzip git libzip-dev libpq-dev libonig-dev libxml2-dev libsodium-dev && docker-php-ext-install pdo pdo_pgsql pgsql mbstring intl sodium zip exif
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql mbstring
WORKDIR /app
COPY . /app
RUN composer install

CMD php artisan migrate && php artisan serve --host=0.0.0.0 --port=8181
EXPOSE 8181
