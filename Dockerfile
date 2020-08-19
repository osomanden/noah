FROM php:7.4-apache AS webserver
#RUN docker-php-ext-install mysqli
RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
COPY install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync
RUN /usr/local/bin/install-php-extensions mysqli soap openssl gd pdo_mysql bcmath curl exif gettext gmp iconv imap json ldap mbstring mysqli session
COPY conf/custom_php.ini /usr/local/etc/php/conf.d/custom.ini
# Copy Data
#COPY dump/db_init.sql /docker-entrypoint-initdb.d/
COPY dump/gnf_noah.sql /docker-entrypoint-initdb.d/
COPY dump/gnf_noah_default_data.sql /docker-entrypoint-initdb.d/
COPY --chown=www-data:www-data www /var/www/html/
RUN chmod -R 0775 /var/www/html/ && chown -R www-data:www-data /var/www/html/

#for develop only
RUN apt-get update && apt-get install vim -y && apt-get install locate && updatedb

# below set in .env file and propagated via docker-compose.yaml
#ENV MYSQL_HOST=db
# db As defined in docker-compose.yaml
#ENV MYSQL_ROOT_PASSWORD=rootpassword!
#ENV MYSQL_USER=gnf_user
#ENV MYSQL_PASSWORD=gnf_userpassword!
#ENV MYSQL_DATABASE=gnf_noah
