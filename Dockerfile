FROM php:8.3-fpm

# Install necessary system dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \ 
        librdkafka-dev \ 
        libsodium-dev \
        git \
        unzip \
    && docker-php-ext-install pdo pdo_mysql sodium \
    && rm -rf /var/lib/apt/lists/*

# Install RdKafka PHP extension
RUN pecl install rdkafka \
    && docker-php-ext-enable rdkafka

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy application code
WORKDIR /var/www/html
COPY . .

# Install PHP dependencies
RUN composer install

# Set environment variables (optional)
ENV KAFKA_BROKERS "localhost:9092"
