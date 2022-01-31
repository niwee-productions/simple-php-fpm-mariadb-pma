FROM php:8.0.0-fpm-alpine

RUN set -xe && apk add --no-cache --update \ 
	bash \ 
	nano \
	wget \
	zip \
	unzip \
	mariadb-client \
	ca-certificates \
	curl \
	git \
	openssh \
	make \
	coreutils \
	shadow \
	libwebp \
    libwebp-tools \
	nodejs \
	npm \
	openssl-dev \
	grep \
    sed \
	autoconf \
	gcc \
	g++ \
	zlib-dev \
	inotify-tools \
	rsync \
	pkgconf \
    re2c \
	libzip-dev \
	libpng-dev \
	imagemagick-dev \
	ssmtp \
	gmp-dev \
	imagemagick6-libs 	

RUN docker-php-ext-install opcache mysqli pdo pdo_mysql zip gd bcmath

RUN set -xe \
    && apk add --update \
        icu \
    && apk add --no-cache --virtual .php-deps \
        make \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        zlib-dev \
        icu-dev \
        g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        intl \
    && docker-php-ext-enable intl \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

RUN pecl install -o -f redis \
	&&  rm -rf /tmp/pear \
	&&  docker-php-ext-enable redis

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

COPY opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY php.ini /usr/local/etc/php/conf.d/php.ini

RUN set -xe \
	&& git clone https://github.com/Imagick/imagick \
	&& cd imagick \
	&& git checkout master && git pull \
	&& phpize && ./configure && make && make install \
	&& cd .. && rm -Rf imagick \
	&& docker-php-ext-enable imagick 
	
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

CMD [ "php-fpm" ]