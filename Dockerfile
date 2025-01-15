# ベースイメージとしてPHP 8.2 Apache版を使用
FROM php:8.2-apache

# ホストのUIDとGIDを受け取る
ARG USER_ID=1000
ARG GROUP_ID=1000

# 必要なパッケージのインストールとPHPモジュールの有効化
RUN apt-get update && apt-get install -y \
  wget \
  curl \
  vim \
  net-tools \
  iputils-ping \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  libzip-dev \
  libxml2-dev \
  libicu-dev \
  libcurl4-openssl-dev \
  libonig-dev \
  libxslt1-dev \
  libexif-dev \
  unzip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install \
  gd \
  mysqli \
  curl \
  mbstring \
  zip \
  xml \
  opcache \
  intl \
  bcmath \
  soap \
  exif \
  && docker-php-ext-enable \
  gd \
  mysqli \
  curl \
  mbstring \
  zip \
  xml \
  opcache \
  intl \
  bcmath \
  soap \
  exif \
  && a2enmod rewrite

# UIDとGIDを変更してwww-dataユーザーをホストのユーザーに一致させる
RUN groupmod -g ${GROUP_ID} www-data && \
  usermod -u ${USER_ID} -g www-data www-data && \
  mkdir -p /var/www/html && \
  chown -R www-data:www-data /var/www/html

# クリーンアップ
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
