FROM centos:8

ENV REPO 'https://repo.zabbix.com/zabbix/5.5/rhel/8/x86_64/zabbix-release-5.5-1.el7.noarch.rpm'

RUN yum -y install $REPO
RUN yum -y install mysql zabbix-get zabbix-server-mysql zabbix-web-mysql zabbix-agent

EXPOSE 80 443

COPY ./bin/start.sh /start.sh
COPY ./sql/schema.sql /etc/zabbix/schema.sql
COPY ./sql/images.sql /etc/zabbix/images.sql
COPY ./sql/data.sql /etc/zabbix/data.sql
COPY ./config/zabbix.conf /etc/httpd/conf.d/zabbix.conf
COPY ./config/zabbix_server.conf /etc/zabbix/zabbix_server.conf
COPY ./config/zabbix.conf.php /etc/zabbix/web/zabbix.conf.php

RUN chmod +x /start.sh

CMD /start.sh
