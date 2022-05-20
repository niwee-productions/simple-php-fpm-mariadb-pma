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
	imagemagick6-libs 	 \
	sudo \
	busybox-suid

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

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html


ENV USER=stagiaire
ENV UID=1000
ENV USER_ID=1000
ENV GID=1000

ADD ./docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ARG USER=stagiaire
ENV HOME /home/$USER

RUN adduser -D $USER \
	&& echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
	&& chmod 0440 /etc/sudoers.d/$USER

RUN adduser $USER www-data

USER $USER

ENTRYPOINT ["docker-entrypoint.sh"]
CMD [ "php-fpm" ]
