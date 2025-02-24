# Rol
Estructura de directorios que funciona como libreria para automatizaciones.

* Defaults: variables por defecto
* Tasks: tareas
* Vars: variables
* Meta: Metadatos
* File: ficheros a desplegar
* Handlesr: tareas que se ejecutan al haber un cambio en el server
* Templates: Plantillas

# Instalacion
## Paso 1
~~~bash
#Creas proyecto
mkdir proyecto
# Creas carpeta de roles
mkdir proyecto/roles

## Creas ficheros
cd proyecto
touch inventory ansible.cfg playbook.yaml
~~~
### Inventory
~~~yaml
[hanoi]
debian1
#172.26.7.2 ansible_user=usuario

[santorini]
debian2
#172.26.8.2 ansible_user=usuario
~~~
### Ansible.cfg
~~~
[defaults]
inventory=./inventory
remote_user=usuario
interpreter_pyton=auto_silent
~~~
### Playbook
~~~yaml

~~~
## Paso 2
~~~bash
# Comprueba configuraciones, hace pings a las maquinas
ansible all -m ping
~~~

## Paso 3: Crear rol
~~~bash
## Crea todas la estructura de directorios
ansible-galaxy init roles/mariadb
~~~

# Estructura
## tasks
Añadimos esto a main:
~~~yml
---
# tasks file for roles/mariadb
- name: Instalar MariaDB
  ansible.builtin.apt:
    name: mariadb-server
    state: present
  become: yes

- name: Habilitar y arrancar MariaDB
  ansible.builtin.service:
    name: mariadb
    state: started
    enabled: yes
  become: yes
~~~

#### Yaml con tarea:
~~~yaml
- name: Configurar servidores Mariadb
  hosts: all
  roles:
    - mariabd
~~~
Referenciar el rol ejecuta main, instalando mariadb.

## ROL mas complejo
Tenemos que desplegar apache
