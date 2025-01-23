# CA y SSL

Seguridad y confianza

Seguridad: El protocolo SSL nos garantiza el cifrado de la información durante la transmisión de la misma. 

Confianza: Esta se consigue a traves de organizaciones externas (CA) que confirman la legitimidad del servidor, lo hacen a través de certificados de autenticidad, ficheros que validan que el servicio es legitimo

## Protocolo HTTPS

* Usa ssl para el cifrado de datos
* Se usa el puerto 443
* El formato dde los certificados es el X.509, emitido por una Autoridad Certificadora (CA)
* La Ca muestra al naegador que la pagina https es segura
* El certificado cifra los datos trasmitidos entre la pagina y el cliente.

## Certificados

**Autoridades certificaddoras**:
* Let's Encrypt: Tiene un cliente Certbot que automatiza todo el proceso.
* CAcert: Es gratuito pero con limitaciones

## Instalar certificado
* Iniciar modulo: `sudo a2enmod ssl`
* `sudo systemctl restart apache2`
* Genera clave: `openssl genrsa -out www.pagina1.org.key 2048`
* Crear una solicitud de firma de certificado (CSR): `openssl req -new -key www.pagina1.org.key -out www.pagina1.org.csr` y rellenar info necesaria
* Generar el certificado autofirmado: `openssl x509 -req -days 365 -in www.pagina1.org.csr -signkey www.pagina1.org.key -out www.pagina1.org.crt`
* Mover a directorio seguro key y crt
* Permisos de archivo:
    ~~~bash
        sudo chmod 600 /etc/apache2/ssl/www.pagina1.org.key
        sudo chmod 644 /etc/apache2/ssl/www.pagina1.org.crt
    ~~~
* `sudo nano /etc/apache2/sites-available/www.pagina1.org-ssl.conf`
    ~~~
    <VirtualHost *:443>
    ServerName www.pagina1.org
    DocumentRoot /var/www/pagina1

    SSLEngine on
    SSLCertificateFile /etc/apache2/ssl/www.pagina1.org.crt
    SSLCertificateKeyFile /etc/apache2/ssl/www.pagina1.org.key

    <Directory /var/www/pagina1>
        AllowOverride All
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/pagina1-error.log
    CustomLog ${APACHE_LOG_DIR}/pagina1-access.log combined
    </VirtualHost>
    ~~~

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
