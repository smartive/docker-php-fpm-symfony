FROM php:8.0-fpm

LABEL maintainer="smartive AG <hello@smartive.ch>"

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
        mariadb-client \
        curl \
        git \
        bash \
        openssh-client \
        vim \
        wget

# Install PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions bcmath gd imap opcache pdo_mysql pdo_pgsql soap zip xdebug

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt -y install nodejs

# Install composer
RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

# Setup configuration
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
COPY symfony.ini $PHP_INI_DIR/
COPY run.sh /root/run.sh
COPY ssh-agent.sh /root/ssh-agent.sh

WORKDIR /app

VOLUME /app

EXPOSE 9000

CMD /root/run.sh
