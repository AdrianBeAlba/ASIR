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

**Consumo total**: 320 + 56 + 200 + 17 = 593W

### Aplicación de factores
1. **Factor de prevención de picos (1.4)**:

   593×1.4=830.2

2. **Sobredimensionamiento (100/70)**:
    
    830.2×(100/70)​=1186

### Potencia mínima recomendada para el SAI = **1186 W**

---

## Ejercicio 3

Si contamos con un SAI de 1400VA, ¿Qué dispositivos de los siguientes podremos conectar para que funcione de forma adecuada?

- **3 PC** (120W cada uno).
- **3 Monitores de 17"** (20W cada uno).
- **2 Monitores de 21"** (68W cada uno).
- **10 Portátiles** (12W cada uno).
- **2 Servidores** (250W cada uno).


---
### Paso 1: Convertir VA a Vatios (W)

Para convertir la capacidad del SAI de **VA** a **W**, necesitamos conocer el factor de potencia del SAI. En caso de no tener este dato, podemos asumir un factor de potencia estándar de **1.4**.

**Watts(W)=Voltiamperios(VA)×factor de potencia**

Entonces:

**Potencia en W=1400VA×1.4=1960W**

El SAI tiene una capacidad de **1960 W**.

### Paso 2: Calcular el consumo de cada dispositivo

#### Dispositivos y sus consumos totales:

- **PCs**: 3 unidades × 120 W = 360 W
- **Monitores de 17"**: 3 unidades × 20 W = 60 W
- **Monitores de 21"**: 2 unidades × 68 W = 136 W
- **Portátiles**: 10 unidades × 12 W = 120 W
- **Servidores**: 2 unidades × 250 W = 500 W

### Paso 3: Sumar el consumo total
**Sumamos los consumos totales extraidos con anterioridad:**

Consumo total = 360W+60W+136W+120W+500W     = **1176W**

Luego debemos de tener en cuenta el sobredimensionamiento y factor de picos.

Factor de picos: 1176W * 1.4 = 1646,4W
Sobredimensionamieno: 1646,4 * (100/70) = 2352W

### Paso 4: Comparar con la capacidad del SAI

La capacidad necesaria para poder alimentar todos los dispositivos mencionados es de **2352W** lo que supera la capacidad actualmentee otorgada por el SAI (**1960W**), lo que nos obliga a reducir la cantidad de dispositivos conectados.


### Paso 5: Determinar qué dispositivos pueden conectarse

Para que el consumo total no exceda los **1960 W**, debemos seleccionar dispositivos para eliminar de la ecuacion para poder adaptarnos a la capcidad del sai.

Para tratar de seguir una logica, debido a que tenemos mas pantallas que pcs podemos eliminar alguna, en este caso quitare dos de las de mas consumo y por ultimo podremos eliminar la diferencia en portatiles, ya que estos en si tienen baterias por lo que no tienen que estar conectados en todo momento.

### Combinación posible:

- **PCs**: 3 unidades × 120 W = 360 W
- **Monitores de 17"**: 3 unidades × 20 W = 60 W
- **Portátiles**: 5 unidades × 12 W = 60 W
- **Servidores**: 2 unidades × 250 W = 500 W

### Consumo total de la combinación seleccionada

Consumo total = 360W+60W+60W+500W  = **1960W**


## Ejercicio 4
Una empresa nos contrata para dimensionar en su oficina un sistema que nos permita salvaguardar los datos y los equipos en el caso de un fallo en el suministro eléctrico:
Disponemos de :

- 2 PCs de escritorio con sus monitores
- 2 portátiles
- 1 impresora láser
- 1 escáner
- 1 servidor de backup con un monitor
- 1 panel de parcheo
- 1 dispositivo multifunción router inalámbrico

Tanto el servidor como el router y el panel de parcheo están en un armario rack. Las instalaciones no sufren demasiadas subidas, bajadas ni cortes de electricidad, pero quieren prevenir posibles eventualidades.

#### Responde a las siguientes cuestiones:

1. Consumo en W de cada uno de los equipos mencionados. En este enlace de [EU ENERGY STAR](https://ec.europa.eu/energy/topics/energy-efficiency/energy-efficient-products/energy-star_en) y en [este otro enlace](https://www.energystar.gov/products) puedes conocer el consumo estimado de distintos equipos. También existen otras páginas que, a modo de calculadoras, muestran el consumo de distintos equipos.

2. Si necesitamos conectar los dos PCs (con sus monitores) y el servidor (con su monitor) a un SAI, ¿Qué potencia necesitará el mismo?

3. ¿Qué tipo de SAI seleccionarías (on-line, in-line, off-line)?. Justifica la respuesta.

4. Si disponemos de un SAI de 1000VA, ¿Qué dispositivos podemos conectar al mismo?.

----
### 1. Consumo en W de cada uno de los equipos mencionados

Calculamos el consumo aproximado de cada equipo, haciendo uso de los enlaces:

| Equipo                          | Consumo Aproximado |
|---------------------------------|--------------------|
| PC de escritorio                | 120 W             |
| Monitor de PC                   | 20 W              |
| Portátil                        | 50 W              |
| Impresora láser                 | 300 W (en impresión) |
| Escáner                         | 10 W              |
| Servidor de backup              | 250 W             |
| Monitor de servidor             | 20 W              |
| Panel de parcheo                | 10 W              |
| Router inalámbrico multifunción | 15 W              |

### 2. Potencia necesaria del SAI para conectar los PCs (con monitores) y el servidor (con monitor)

Vamos a calcular el consumo total de los equipos que se conectarán al SAI:

- **2 PCs de escritorio**: 2 × 120 W = 240 W
- **2 Monitores de PC**: 2 × 20 W = 40 W
- **1 Servidor de backup**: 1 × 250 W = 250 W
- **1 Monitor de servidor**: 1 × 20 W = 20 W

240W+40W+250W+20W=550W

Factor de picos: 550W * 1.4 = **770 W**

Sobredimensionamiento: 770W * (100/70) = **1100W**

**Consumo total requerido: 1100W**

### 3. Tipo de SAI recomendado (on-line, in-line, off-line)

Dado que las instalaciones no suelen experimentar muchas fluctuaciones de energía, pero queremos proteger los equipos críticos (servidor y PCs), recomendaría un **SAI in-line (interactivo)**.

- **Justificación**:
  - Los **SAIs in-line** son una buena opción intermedia que protege contra cortes de energía y estabiliza la tensión cuando hay pequeñas variaciones.
  - Son más económicos que los SAIs on-line y ofrecen protección suficiente para una oficina con necesidades moderadas de protección.
  - Este tipo de SAI puede conmutar rápidamente en caso de caída de tensión, proporcionando un nivel de protección adecuado para los equipos de oficina sin el costo elevado de un SAI on-line.

### 4. Dispositivos que podemos conectar a un SAI de 1000 VA

Para calcular la potencia real en **vatios (W)** que soporta el SAI, asumimos un **factor de potencia** de **1.4**. Entonces:

Potencia real en W=1000VA×1.4=**1400W**

Esto significa que el SAI de **1000 VA** puede proporcionar hasta **1400 W** de potencia real.

#### Selección de Dispositivos para Conectar al SAI

Podriamos concetar todos los dispositivos sin problemas en el SAI.





[⬅️ Volver al índice](./Index.md)
[⬆️ Volver al README](/README.md)
