# Situarse en el directorio dónde se hayan descargado los ficheros de este proyecto y ejecutar en este orden: 

docker-compose build

docker-compose up -d

# Acceder al contenedor "zabbix-server" con una terminal bash:

docker exec -ti zabbix-server bash

# Crear la base de datos para zabbix:

mysql -h db -u root -p

NOTA: la contraseña está definida en el fichero docker-compose.yml (123456789)

mysql> create database zabbix character set utf8 collate utf8_bin;

mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';

mysql> grant all privileges on zabbix.* to zabbix@x.x.x.x identified by 'zabbix';

mysql> flush privileges;

mysql> quit;

NOTA: sustituir "x.x.x.x" por la dirección IP del contenedor zabbix-server (p.ej: 172.23.0.3)

# Importar los esquemas de Zabbix a la nueva base de datos:

mysql -h db -uzabbix -pzabbix zabbix < /etc/zabbix/schema.sql

mysql -h db -uzabbix -pzabbix zabbix < /etc/zabbix/images.sql

mysql -h db -uzabbix -pzabbix zabbix < /etc/zabbix/data.sql

# Abrir un navegador y poner en la URL la IP / Nombre DNS de la máquina anfitrión y acceder a zabbix con las credenciales por defecto:

P.ej: http://192.168.0.24/zabbix

User --> Admin
Passwd --> zabbix

