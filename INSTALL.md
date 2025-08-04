Свои сборки под Kohana World

```shell
DOCKER_BUILDKIT=1 make -j10 build-php5.6 VERSIONS_php=5.6 VARIANT=stretch
DOCKER_BUILDKIT=1 make -j10 build-php7.3 VERSIONS_php=7.3 VARIANT=buster
DOCKER_BUILDKIT=1 make -j10 build-php8.0 VERSIONS_php=8.0 VARIANT=buster
DOCKER_BUILDKIT=1 make -j10 build-php8.1 VERSIONS_php=8.1 VARIANT=bookworm
DOCKER_BUILDKIT=1 make -j10 build-php8.2 VERSIONS_php=8.2 VARIANT=bookworm
DOCKER_BUILDKIT=1 make -j10 build-php8.3 VERSIONS_php=8.3 VARIANT=bookworm
````
```shell
docker scout cves --only-severity critical,high,medium unit:1.33.0-php5.6
docker scout cves --only-severity critical,high,medium unit:1.33.0-php7.3
docker scout cves --only-severity critical,high,medium unit:1.33.0-php8.2
```

```shell
cd /srv/www/github/kohana-world/kohana/
cd /srv/www/github/phpclub/koseven

docker run --name unit -d -p 80:80 -v $(pwd):/app unit:1.32.1-php7.3
docker exec -it unit bash
```

```shell

# Debian bullseye  unit:1.32.1-php8.2
docker run --name unit -d -p 80:80 -v $(pwd):/app unit:1.32.1-php8.2
docker exec -it unit bash

apt-get update
apt-get upgrade
apt-get install procps locales apt-utils sudo  nano
```

На дебиан и убунту можно сделать так сначала 
  ```
  # Uncomment en_US.UTF-8 for inclusion in generation  
  apt install locales
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(fr_FR.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(de_DE.UTF-8\)/\1/' /etc/locale.gen \
    && sed -i 's/^# *\(ru_RU.UTF-8\)/\1/' /etc/locale.gen \
    # Generate locale
    locale-gen && update-locale LANG=en_US.utf8 LC_ALL=en_US.utf8 LANGUAGE=en_US.utf8
```

```php
<?php
if (false !== setlocale(LC_ALL, 'ru_RU.UTF-8')) {
  $locale_info = localeconv();
  print_r($locale_info);
}

var_dump(localeconv());
var_dump(setlocale(LC_ALL, 'ru_RU.UTF-8'));
var_dump(setlocale(LC_ALL, 'en_US.UTF-8'));
```

docker run --name unit -d -p 80:80 -v $(pwd):/app unit:1.32.1-php7.3


curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
vendor/bin/phpunit --bootstrap=modules/unittest/bootstrap.php modules/unittest/tests.php
```
Source
https://hub.docker.com/_/php
php:7.3-cli-bullseye
COPY welcome.* /usr/share/unit/welcome/

```shell
cd /srv/unit/unit/pkg/docker
make build-php7.3 VERSIONS_php=7.3
```

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


apt-get install procps locales apt-utils sudo  nano

apt-get install dialog apt-utils -y
dpkg-reconfigure locales


Доставить dialog sudo locales nano 


# noninteractive to prevent user input forms
ARG DEBIAN_FRONTEND=noninteractive

apt-get install --no-install-recommends --no-install-suggests -y procps locales git unzip apt-utils sudo locales nano memcached redis-server

echo 'alias ll="ls -la"' >> ~/.bashrc && echo 'EDITOR=/usr/bin/nano' >> ~/.bashrc
ARG TZ=Etc/UTC
ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU.UTF-8
ENV LC_ALL=ru_RU.UTF-8
ENV EDITOR=/usr/bin/nano
RUN curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

rm /usr/local/etc/php/conf.d/docker-php-ext-sodium.ini

php-gd or php-imagick apcu redis memecache 

    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && echo 'apc.enabled=1' >> /usr/local/etc/php/php.ini && echo 'apc.enable_cli=1' >> /usr/local/etc/php/php.ini

docker run --name=redis -d -p 6379:6379 redis
docker run --name memcached -d -p 11211:11211 bitnami/memcached:latest