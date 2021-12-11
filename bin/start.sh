#!/bin/bash

if test ! -e /.firstrun ; then
  echo "Executing initial setup..."
  sleep 30
  echo create database zabbix character set utf8 collate utf8_bin | mysql -h zabbix-sql -u root -p123456789
  echo grant all privileges on zabbix.* to zabbix identified by \'zabbix\' | mysql -h zabbix-sql -uroot -p123456789
  echo flush privileges | mysql -h zabbix-sql -u root -p123456789
  sleep 1
  mysql -h zabbix-sql -uzabbix -pzabbix zabbix < /etc/zabbix/schema.sql
  mysql -h zabbix-sql -uzabbix -pzabbix zabbix < /etc/zabbix/images.sql
  mysql -h zabbix-sql -uzabbix -pzabbix zabbix < /etc/zabbix/data.sql
  touch /.firstrun
  echo "...done initial setup"
fi

# Start zabbix-server

/usr/sbin/zabbix_server -c /etc/zabbix/zabbix_server.conf

# Start zabbix-agentd

/usr/sbin/zabbix_agentd

# Start php-fpm

/usr/sbin/php-fpm

# Start httpd

/usr/sbin/httpd -DFOREGROUND

