# Intro
## Recursos
* Debian 12: Debian1;172.26.7.2
* Debian 12: Debian2;172.26.8.2
* SSH en ambas maquinas, maquina principal tiene que pasar las claves publicas
* Sudo y usuario en sudo que no sea root
* Ambas maquinas han de tener python3

(Referencia)[https://docs.ansible.com/ansible/latest/installation_guide/]

## Instalación
Cambiamos a root
~~~bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
sudo apt install whois
~~~
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
