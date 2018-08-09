FROM node:10-alpine

LABEL maintainer="smartive AG <hello@smartive.ch>"

ENV PHP_VERSION 7.1

RUN apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates

RUN wget -O /etc/apk/keys/php-alpine.rsa.pub http://php.codecasts.rocks/php-alpine.rsa.pub && \
    echo "http://php.codecasts.rocks/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/php-${PHP_VERSION}" >> /etc/apk/repositories

RUN apk add --update \
    libmcrypt-dev \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-imap \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-soap \
    php7-tokenizer \
    php7-xml \
    php7-zip \
    php7-zlib \
    php7-xdebug \
    mysql-client \
    curl \
    git \
    bash \
    openssh-client \
    vim

RUN ln -s /usr/bin/php7 /usr/sbin/php

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

COPY symfony.ini /etc/php7/php-fpm.d/
COPY symfony.ini /etc/php7/conf.d/10-symfony.ini
COPY symfony.pool.conf /etc/php7/php-fpm.d/www.conf
COPY run.sh /root/run.sh
COPY ssh-agent.sh /root/ssh-agent.sh

WORKDIR /app

VOLUME /app

EXPOSE 9000

CMD /root/run.sh
