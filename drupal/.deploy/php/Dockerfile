# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM php:7.2-fpm-alpine
# https://www.drupal.org/node/3060/release
WORKDIR /var/www/html

# docker-entrypoint.sh dependencies
RUN apk add --no-cache \
# in theory, docker-entrypoint.sh is POSIX-compliant, but priority is a working, consistent image
		bash \
# BusyBox sed is not sufficient for some of our sed expressions
		sed

# install the PHP extensions we need
# postgresql-dev is needed for https://bugs.alpinelinux.org/issues/3642
RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		coreutils \
		freetype-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		postgresql-dev \
	&& docker-php-ext-configure gd \
		--with-freetype-dir=/usr/include/ \
		--with-jpeg-dir=/usr/include/ \
		--with-png-dir=/usr/include/ \
	&& docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .drupal-phpexts-rundeps $runDeps \
	&& apk del .build-deps

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /var/www/html

RUN mkdir /usr/src/drupal

ENV DRUPAL_VERSION={{DRUPAL_VERSION}}

RUN set -ex; \
  curl -o drupal.tar.gz -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz"; \
	tar -xz --strip-components=1 -f drupal.tar.gz -C /usr/src/drupal; \
	rm drupal.tar.gz; \
	chown -R www-data:www-data /usr/src/drupal

COPY docker-entrypoint.sh /usr/local/bin/

ENV PHP_UPLOAD_MAX_SIZE={{PHP_UPLOAD_MAX_SIZE}}
ENV PHP_POST_MAX_SIZE={{PHP_POST_MAX_SIZE}}

RUN printf "upload_max_filesize = %s\n" "${PHP_UPLOAD_MAX_SIZE}" > /usr/local/etc/php/conf.d/upload_max_size.ini
RUN printf "post_max_size = %s\n" "${PHP_POST_MAX_SIZE}" > /usr/local/etc/php/conf.d/post_max_size.ini

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
