# Aprovisionamiento de infraestructura con Ansible
## Introducción
### Fases de DevOps
---
1. Planificación: se deciden funcionalidades y requisitos de la app
2. Desarrollo: se construye la app
3. Integración continua: Automatizar los mecanismos de revisión, validación prueba y alertas
4. Despliegue continuo: Despliegue de la app
5. Operaciones: Soporte de la app
6. Monitorización: Controlar el estado de salud de la app

## Que es Ansible
* Herramienta DevOps Open Source
* Permite questionar configuración, implementacion, aprovisionamiento y automatización de nuestra infraestructura.

### Caracteristicas
* Fiabilidad, consistencia y escalabilidad
* Facil de configurar y utilizar
* Trabaja directamente sobre SSH
* IAC: Infraestructura como codigo
    * No nos requiere de procesos manuales para configurar gestionar y provisionar nuestra infraestructura.
* Preparacion:
    * Permite instalar y configurar infraestructura TI.
    * Servidores, redes usuarios, servicios, etc...
    * Prepara sistema y componentes
* Configuracion
    * Configuracion rapida
    * Permite mantener los sitemas en un estado deseado
* ¿Por que es un lider de la automatización?
    * Despliega apps en varios sistemas de manera coordinada
    * Permite la organizacion correcta de compoonentes
    * Establece politicas de seguridad para equipos y entornos con los que trabajaremos

### Competidores
* Red Hat Ansible: Mas opciones y caracteristicas pero de pago
* Terraform: Orientado a AWS y google cloud
* Chef: Basado en ruby, hece uso de mecanismos llamados recetas
* Puppet: Open source Basado en ruby, gestiona la configuración a traves de ficheros manifest
* Saltstac
* Basado en python y yaml, promovido por vmware

## Arquitectura y componentes
* **Control Nodes**: servidores desde los que se ejecuta Ansible y lanan comandos contra los servidores gestionados (los automatizados)
    * Funcionan sobre entornos Linux por lo que se puedes usar desde WSL

* **Manage Nodes**: Servidores gestionados desde el Nodo de control
* **Inventario**: Ficheros con los nodos gestionados, agrupaciones y otras caracteristicas. Es estatico (escrito a mano) o dinamico (por scripts)
* **Playbooks/Plays**: Un play ejecuta una serie de tareas en los nodos gestionados.
    * Son ficheros yaml
    * Declarativos, facil uso y mantenimiento
    * Se pueden agrupar varios plays en un PlayBook
* **Modulos**:
    * Scripts independientes ejecutables en un playbook
    * Librerias con acciones
    * Se copien/ejecutan en cada nodo gestionado para ejecutar la acción
    * Varios modulos para cada necesidad
* **Colecciones**:
    * Formato de distribucion compuesto de Playbooks, Modulos, Roles o Plugin
    * Se cargan a medida que se necesiten
    * Algunos son del propio ansible, otros los mantiene la comunidad.
    * **Ansible-Galaxy** es un repositorio centralizado, desde el que se cargan otros componentes.
    * **Ansible-core**: Componentes y modulos basicos
    * **Ansible Proyect**: Core + Modulos