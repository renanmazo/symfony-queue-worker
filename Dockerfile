FROM php:7.4-fpm-alpine

RUN apk add nginx supervisor rabbitmq-c-dev --no-cache --update

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Extensions
RUN echo "Extensions install - start" \
    # Sockets
    && docker-php-ext-install sockets \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f amqp \
    && docker-php-ext-enable amqp \
    && apk del .phpize-deps \
    #
    && echo "Extensions install - finish"

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.4-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*


RUN mkdir -p /run/php && \
    mkdir -p /etc/php/7.4/fpm/ && \
    touch /run/php/php7.4-fpm.pid && \
    mkdir -p /etc/nginx \
    chmod 755 /run/php/php7.4-fpm.sock

COPY bootstrap/nginx.conf /etc/nginx/nginx.conf
COPY bootstrap/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

COPY bootstrap/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 80

COPY bootstrap/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

CMD ["/entrypoint.sh"]
