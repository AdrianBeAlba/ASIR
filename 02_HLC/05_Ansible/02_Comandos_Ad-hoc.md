# Comandos ad-hoc
**(colecciones)[https://docs.ansible.com/ansible/latest/collections/index.html]**

### 1. Crear inventario

`nano maquinas`

Añadimos esto:
~~~nano
172.26.7.2 ansible_user=usuario
172.26.8.2 ansible_user=usuario
~~~

### 2. Prueba de Módulos
### Módulos
~~~bash
## Comprobación:
ansible -i maquinas all -m ping

## Ejecutar comandos: 
ansible -i maquinas all -m [command|shell] -a "<comando>"

## Info de maquinas: 
ansible -i maquinas 172.26.7.2 -m setup # Devuelve información sobre la maquina en formato .json
ansible -i maquinas 172.26.7.2 -m setup -a filter=ansible_distribution # Filtros según el campo que queremos referenciar.
~~~

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
