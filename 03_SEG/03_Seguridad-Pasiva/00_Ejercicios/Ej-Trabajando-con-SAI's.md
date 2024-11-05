## EJERCICIO 1.

### Busca en Internet información sobre 3 dispositivos SAIs concretos y disponibles en el mercado. Cada uno debe ser de un tipo diferente (Offline, Inline, Online).
### Crea una tabla con ellos indicando algunas características de cada uno (la potencia, el tiempo de trabajo extra que ofrecen, el número de equipos que pueden conectarse a ellos, si disponen de reguladores de tensión, el precio, etc.).

#### Algunos de los fabricantes más importantes que puedes consultar son Salicru, Emerson, APC, Eaton, Socomec.

| Tipo de SAI          | Modelo                   | Potencia (VA/W)    | Tiempo de Respaldo | Equipos Conectables | Regulador de Tensión | Precio Aproximado |
|----------------------|--------------------------|--------------------|--------------------|----------------------|----------------------|-------------------|
| **Offline**          | Salicru SPS 500          | 500 VA / 300 W     | 10-15 minutos      | 1-2 dispositivos     | No                   | 60 €              |
| **Line-Interactive** | APC Back-UPS Pro BR1500G | 1500 VA / 865 W    | 5-10 minutos       | 3-4 dispositivos     | Sí                   | 250 €             |
| **Online**           | Eaton 9PX 3000i          | 3000 VA / 2700 W   | 8-10 minutos       | 5-6 dispositivos     | Sí                   | 1.500 €           |
---
---
## EJERCICIO 2.

### Disponemos de los siguientes equipos:

* ### 2 PC's que consumen cada uno 160W, con sus monitores de 28W cada uno.
* ### 1 servidor que consume 200W y su monitor que consume 17W.

### Si queremos conectarlo todo a un SAI, ¿Qué potencia necesitaremos?

### Importante: a menos que se mencione explícitamente:
* ### Siempre hay que usar un factor para prevenir picos de tensión. Aplicar 1,4, salvo indicación distinta.

* ### Siempre hay que sobredimensionar el SAI. Es decir, no ajustar al consumo teórico previsto por las especificaciones de consumo de los equipos conectados. Aplicar x 100/70.


## Cálculo de Potencia para el SAI

### Equipos y consumo
- **2 PCs**: 2 x 160 W = 320 W
- **Monitores de PCs**: 2 x 28 W = 56 W
- **Servidor**: 200 W
- **Monitor del servidor**: 17 W

**Consumo total**: 320 + 56 + 200 + 17 = 59W

### Aplicación de factores
1. **Factor de prevención de picos (1.4)**:

   593×1.4=830.2

2. **Sobredimensionamiento (100/70)**:
    
    830.2×(100/70)​=1186

### Potencia mínima recomendada para el SAI = **1186 W**

[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
