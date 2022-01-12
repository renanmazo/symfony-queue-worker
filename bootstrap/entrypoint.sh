#!/bin/ash
composer install

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf
