#ARG USER_PHP_EXTRA_CONFIGURE_ARGS=" --enable-opcache --enable-opcache-file"
#ARG PHP_EXTRA_CONFIGURE_ARGS="--enable-embed  --enable-opcache --enable-opcache-file"
FROM php:7.1-cli-stretch

ARG BUILD_PACKAGE="libfreetype6-dev libxml2  libxml2-dev libicu-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev libxml2-dev libzip-dev libxslt1-dev imagemagick libpng-dev libmagickwand-dev libmagickcore-dev"
ARG PHP_EXTRA_CONFIGURE_ARGS="--enable-embed --enable-opcache --enable-opcache-file"


RUN echo "deb [trusted=yes] http://archive.debian.org/debian stretch main non-free contrib" > /etc/apt/sources.list \
    && echo "deb-src [trusted=yes] http://archive.debian.org/debian stretch main non-free contrib" >> /etc/apt/sources.list \
    && echo "deb [trusted=yes] http://archive.debian.org/debian-security stretch/updates main non-free contrib" >> /etc/apt/sources.list

#
RUN apt-get update \
    && apt-get install --no-install-recommends -y ${BUILD_PACKAGE}

RUN set -eux; \
    docker-php-source extract \
    && cd /usr/src/php \
#	&& ./configure ${USER_PHP_EXTRA_CONFIGURE_ARGS:-} \
#&& ./phpize \
&& ./configure --enable-embed --enable-opcache --enable-opcache-file \
&& make -j "$(nproc)" \
&& make install


#RUN apt-get update \
#    && apt-get install --no-install-recommends -y $BUILD_PACKAGE \
#    && pecl install imagick \
#    && docker-php-ext-enable imagick \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --enable-embed \
#    && docker-php-ext-install \
#    dom \
#    gd \
#    intl \
#    mbstring \
#    pdo_mysql \
#    xsl \
#    zip \
#    soap \
#    bcmath \
#    sockets \
#    mcrypt \
#    && rm -rf /var/lib/apt/lists/*

#ENV TINI_VERSION v0.18.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
#RUN chmod +x /tini
#ENTRYPOINT ["/tini", "--", "docker-php-entrypoint"]
#
## Run your program under Tini
#CMD ["php", "-A"]
