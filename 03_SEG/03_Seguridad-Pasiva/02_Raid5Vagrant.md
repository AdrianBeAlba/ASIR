### Configuración de RAID 5 y Volumen Lógico en Linux

#### **1. Crear un RAID 5 llamado `md5`**

**Cantidad de discos necesarios:** 
Para un RAID 5, se necesitan al menos **3 discos**. La capacidad total del RAID 5 será igual a la suma de las capacidades de todos los discos menos uno (utilizado para paridad).

**Diferencias entre RAID 5 y RAID 1:**
- **RAID 1 (Mirroring):** Duplica los datos en dos discos para redundancia, proporcionando tolerancia a fallos. Capacidad efectiva es la mitad del total.
- **RAID 5 (Striping with Parity):** Los datos se distribuyen entre varios discos junto con información de paridad. Permite tolerancia a fallos de un disco, con mejor utilización del espacio que RAID 1.

**Comandos para crear el RAID 5:**
```bash
# Crear el RAID 5 con tres discos (ejemplo: /dev/sdb, /dev/sdc, /dev/sdd)
sudo mdadm --create /dev/md5 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd

# Guardar la configuración del RAID
sudo mdadm --detail --scan >> /etc/mdadm/mdadm.conf
```

---

#### **2. Comprobar las características y el estado del RAID**

**Comprobar características del RAID:**
```bash
sudo mdadm --detail /dev/md5
```

**Comprobar el estado del RAID:**
```bash
cat /proc/mdstat
```

**Capacidad del RAID:** 
La capacidad efectiva será:
```bash
(número de discos - 1) * capacidad de cada disco
```

---

#### **3. Crear un volumen lógico (LVM) de 500 MB en el RAID 5**

**Crear volumen físico (PV):**
```bash
sudo pvcreate /dev/md5
```

**Crear un grupo de volúmenes (VG):**
```bash
sudo vgcreate raid5_vg /dev/md5
```

**Crear el volumen lógico (LV):**
```bash
sudo lvcreate -L 500M -n raid5_lv raid5_vg
```

---

#### **4. Formatear el volumen con el sistema de archivos XFS**
```bash
sudo mkfs.xfs /dev/raid5_vg/raid5_lv
```

---

#### **5. Montar el volumen en /mnt/raid5 y crear un fichero**

**Montar el volumen:**
```bash
sudo mkdir -p /mnt/raid5
sudo mount /dev/raid5_vg/raid5_lv /mnt/raid5
```

**Crear un archivo de prueba:**
```bash
echo "Archivo de prueba en RAID 5" | sudo tee /mnt/raid5/prueba.txt
```

**Hacer el punto de montaje permanente:**
Edita el archivo `/etc/fstab`:
```bash
sudo nano /etc/fstab
```
Agrega esta línea:
```bash
/dev/raid5_vg/raid5_lv /mnt/raid5 xfs defaults 0 0
```

---

#### **6. Marcar un disco como estropeado y comprobar el estado**

**Marcar el disco como fallado:**
```bash
sudo mdadm --fail /dev/md5 /dev/sdb
```

**Comprobar el estado del RAID:**
```bash
sudo mdadm --detail /dev/md5
cat /proc/mdstat
```

**Acceder al archivo:**
El archivo en el RAID seguirá accesible ya que RAID 5 puede tolerar la pérdida de un disco.

---

#### **7. Retirar el disco estropeado del RAID**

**Eliminar el disco fallado:**
```bash
sudo mdadm --remove /dev/md5 /dev/sdb
```

---

#### **8. Sustituir el disco por uno nuevo y sincronizar**

**Agregar el nuevo disco al RAID:**
```bash
sudo mdadm --add /dev/md5 /dev/sdb
```

**Comprobar la sincronización:**
```bash
cat /proc/mdstat
```

---

#### **9. Agregar un disco de reserva**

**Agregar disco como repuesto:**
```bash
sudo mdadm --add /dev/md5 /dev/sde
```

**Simular otro fallo y comprobar sincronización:**
```bash
sudo mdadm --fail /dev/md5 /dev/sdc
cat /proc/mdstat
```
El disco de reserva se usará automáticamente para sincronizar el RAID.

---

#### **10. Redimensionar el volumen y el sistema de archivos**

**Redimensionar el volumen lógico:**
```bash
sudo lvextend -l +100%FREE /dev/raid5_vg/raid5_lv
```

**Redimensionar el sistema de archivos XFS:**
```bash
sudo xfs_growfs /mnt/raid5
```

---

Ahora tienes un RAID 5 completamente funcional con volumen lógico, soportando fallos de disco y configurado para el crecimiento. Si necesitas documentar más detalles o personalizarlo, házmelo saber.
[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
