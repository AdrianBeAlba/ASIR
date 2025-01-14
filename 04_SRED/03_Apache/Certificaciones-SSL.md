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
