# Comandos
## Suricata
~~~bash
#instalar usar suricata
apt update && apt upgrade
sudo apt install apache2
sudo apt install suricata

sudo nano /etc/suricata/suricata.yaml
# ctrl+w:
#   -af-packet: ver interfaz
#   -outputs: y buscamos http/https para ver que los mira
#comprobamos que la pagina va con la ip publica

# Ahora cerramos puertos
## Creamos tabla de reglas
sudo nft add table inet filter
sudo nft add chain inet filter input { type filter hook input priority 0 \; }

## Cerrar puerto 80
sudo nft add rule inet filter input tcp dport 80 drop
sudo nft list ruleset # Comprobar que existe la regla

# Despues de comprobar visualmente que la pagina esta caida lo miramos en los logs de suricata, si no aparece mas de http o "timeouts" es que funciona
sudo tail -f /var/log/suricata/eve.json | jq .
~~~
## Criptografia

~~~bash
apt update
apt install gpg gnupg
gpg --version

echo "hola" > archivo.txt
gpg -c archivo.txt ## Encripta el archivo a archivo.txt.gpg
gpg -c -a archivo.txt ## Encripta el archivo a archivo.txt.asc
rm archivo txt

gpg -d -o archivo.txt archivo.txt.gpg ## Desencripta y guarda de vuelta a archivo txt
gpg -d -a archivo.txt archivo.txt.asc ## Desencripta y guarda de vuelta a archivo txt

gpg --gen-key # Genera par de claves
gpg --export -a "<nombreclave>" > archivokey.pub
gpg --import archivokey.pub

gpg -a --encrypt -r "<nombeclave>" archivo.txt ## Encripta bajo clave generada
gpg -a -decrypt archivo_encriptado.txt
~~~