# Instalacion PhpLdapAdmin
~~~bash
apt install apache2
apt update
apt install mariadb-server mariadb-common mariadb-client -y

apt install phpldapadmin
mysql -u root -p
~~~
~~~sql
use mysql
select user,hosst,password, fromn user;
~~~
~~~bash
apt install php -y
php --version
apt install php-xml
apt-get install php-ldap
apt upgrade
nano +329 /etc/phpldapadmin/config.php ## añadimos dominio a la linea en vez de example
nano +356 /etc/phpldapadmin/config.php ## igual
~~~

Ahora puedes entrar desde el navegador con la ip