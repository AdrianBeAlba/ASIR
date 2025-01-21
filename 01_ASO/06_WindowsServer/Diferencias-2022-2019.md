# Novedades de Windows Server 2019/2022 y Comparativa de Ediciones

## 1. Introducción
Windows Server es el sistema operativo para servidores de Microsoft que permite gestionar y respaldar la infraestructura de TI de organizaciones de distintos tamaños. Con cada nueva versión se introducen mejoras en seguridad, virtualización, contenedores, administración y conectividad con la nube.

Este documento resume las novedades más relevantes de Windows Server 2019 y Windows Server 2022, junto con una tabla comparativa de las ediciones Essentials, Standard y Datacenter.

---

## 2. Novedades de Windows Server 2019
- **Integración híbrida con Azure**  
  - Facilita el uso de Azure Backup, Azure Monitor y otros servicios en la nube.
- **Windows Admin Center**  
  - Consola basada en navegador para administrar servidores y clústeres de manera centralizada.
- **Mejoras de seguridad**  
  - Shielded Virtual Machines (protección de VMs, incluso Linux).
  - Integración con Windows Defender ATP.
- **Optimización de contenedores**  
  - Reducción del tamaño de las imágenes base y mayor compatibilidad con contenedores Linux.
- **Storage Spaces Direct (S2D) y Storage Migration Service**  
  - Solución de almacenamiento hiperconvergente y herramienta para migrar servidores de archivos.

---

## 3. Novedades de Windows Server 2022
- **Seguridad avanzada (“Secured-core Server”)**  
  - Protección de firmware, VBS (Virtualization-based Security) y HVCI (Hypervisor-based Code Integrity).
- **Conectividad híbrida con Azure mejorada**  
  - Integración con Azure Arc para administración centralizada de servidores.
- **Mejoras en contenedores y Kubernetes**  
  - Imágenes de contenedor más ligeras y orquestación más eficiente.
- **SMB (Server Message Block) over QUIC**  
  - Acceso seguro a archivos sin necesidad de VPN (en ediciones y escenarios compatibles).
- **Mejoras de almacenamiento**  
  - Optimizaciones en Storage Migration Service, Storage Spaces Direct y replicación de datos.
- **Hot patching en Azure**  
  - Aplicación de parches en servidores en la nube sin reinicios inmediatos.

---

## 4. Tabla Comparativa de Ediciones

| Característica / Edición                 | Essentials              | Standard               | Datacenter             |
|:----------------------------------------:|:-----------------------:|:----------------------:|:----------------------:|
| **Orientación**                          | Pequeñas empresas (hasta 25 usuarios / 50 dispositivos) | Empresas de tamaño mediano y grande | Grandes organizaciones con virtualización intensiva |
| **Licenciamiento**                       | Incluye usuario/dispositivo; no requiere CALs | Requiere CALs (por usuario/dispositivo) | Requiere CALs (por usuario/dispositivo) |
| **Máx. de RAM**                          | 32-64 GB*              | Hasta 24 TB           | Hasta 24 TB           |
| **Virtualización**                       | 1 instancia (física o virtual) | 2 VMs por licencia base (mín. 16 núcleos) | VMs ilimitadas (licenciamiento por núcleo) |
| **Storage Spaces Direct**                | No disponible o muy limitado | Disponible, con ciertas restricciones en el número de nodos | Funcionalidad completa, hasta 64 nodos |
| **SMB over QUIC (2022)**                 | No disponible          | Disponible (con configuración) | Disponible (con configuración) |
| **Shielded VMs**                         | No disponible          | Soportado con limitaciones | Soportado totalmente |
| **Secured-core server (2022)**           | No disponible          | Disponible (hardware compatible) | Disponible (hardware compatible) |

> *El límite de RAM para Windows Server 2022 Essentials se redujo a 32 GB, mientras que en Windows Server 2019 Essentials se permitían hasta 64 GB. Es importante revisar la documentación oficial para detalles específicos.

---

## 5. Conclusiones
- **Windows Server 2019** es ideal para organizaciones que buscan un sistema robusto y con buenas capacidades híbridas, contenedores y herramientas de administración como Windows Admin Center.
- **Windows Server 2022** ofrece seguridad reforzada (Secured-core), mejoras de rendimiento y una integración aún más fluida con Azure, especialmente útil para entornos de alta seguridad y escenarios híbridos avanzados.
- **Essentials** continúa como la opción más económica para organizaciones pequeñas, pero tiene limitaciones de hardware y funcionalidades.
- **Standard** es el punto intermedio que permite virtualizar con límites razonables y soporta la mayoría de características de Windows Server.
- **Datacenter** está diseñado para quienes necesitan gran capacidad de virtualización, almacenamiento hiperconvergente y servicios de alta disponibilidad a gran escala.

---
