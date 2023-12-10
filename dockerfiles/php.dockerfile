#Base image
FROM php:8.0-fpm

#Thông tin maintainer
LABEL maintainer="NguyenQuyen <nguyenquyen18011996@gmail.com>"

# Cập nhật, cài đặt các lib, supervisor và các ext php cần thiết cho dự án
RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends supervisor git libzip-dev zip && rm -rf /var/lib/apt/lists/* && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    docker-php-ext-install pdo pdo_mysql zip
RUN docker-php-ext-install gd

# Download composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Update version composer
RUN composer self-update 2.2.7

#Khai báo port lắng nghe
EXPOSE 9000

#Copy file command start vào container
COPY php/start /command/start

# Run file command start được copy ở trên
ENTRYPOINT ["/command/start"]