FROM quay.io/centos/centos:stream8

ENV REPO 'https://repo.zabbix.com/zabbix/5.5/rhel/8/x86_64/zabbix-release-5.5-1.el8.noarch.rpm'

RUN dnf -y install $REPO && \
    dnf -y install nc mysql zabbix-get zabbix-server-mysql zabbix-web-mysql zabbix-agent httpd glibc-locale-source glibc-langpack-en && \
    mkdir /run/php-fpm && \
    dnf clean all

EXPOSE 80 10050 10051

COPY ./bin/start.sh /start.sh
COPY ./sql/schema.sql /etc/zabbix/schema.sql
COPY ./sql/images.sql /etc/zabbix/images.sql
COPY ./sql/data.sql /etc/zabbix/data.sql
COPY ./config/zabbix.conf /etc/httpd/conf.d/zabbix.conf
COPY ./config/zabbix_server.conf /etc/zabbix/zabbix_server.conf
COPY ./config/zabbix.conf.php /etc/zabbix/web/zabbix.conf.php
COPY ./config/zabbixredir.conf /etc/httpd/conf.d/

CMD /start.sh
