FROM node:12-alpine

LABEL maintainer="smartive AG <hello@smartive.ch>"

ENV PHP_VERSION 7.4

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
RUN echo "@php https://php.codecasts.rocks/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/php-${PHP_VERSION}" >> /etc/apk/repositories

RUN apk add --update \
    libmcrypt-dev \
    mysql-client \
    curl \
    git \
    bash \
    openssh-client \
    vim \
    wget \
    php@php \
    php-bcmath@php \
    php-dom@php \
    php-ctype@php \
    php-curl@php \
    php-fpm@php \
    php-gd@php \
    php-iconv@php \
    php-intl@php \
    php-imap@php \
    php-json@php \
    php-mbstring@php \
    php-mysqlnd@php \
    php-opcache@php \
    php-openssl@php \
    php-pdo@php \
    php-pdo_mysql@php \
    php-pdo_pgsql@php \
    php-pdo_sqlite@php \
    php-phar@php \
    php-posix@php \
    php-session@php \
    php-soap@php \
    php-xml@php \
    php-xmlreader@php \
    php-zip@php \
    php-zlib@php \
    php-xdebug@php

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
