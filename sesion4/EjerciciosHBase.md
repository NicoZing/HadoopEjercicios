***
# Ejercicios de HBase
### Discografía de Pink Floid y Green Day.
***
- Autor: Juan A. García Cuevas
- Fecha: 25/09/2016

***
# ENUNCIADO:

Partiendo de los datos de la discografía de álbumes de estudio de Pink Floyd: [Discografía de Pink Floid](http://es.wikipedia.org/wiki/Anexo:Discograf%C3%ADa_de_Pink_Floyd):

```
Año Album Ranking Certificación EEUU Ranking Certificación UK
1967 The Piper at the Gates of Dawn 131 6
1968 A Saucerful of Secrets — 9
1969 Music from the Film More 153 9
1969 Ummagumma (Disco 2) 74 5
1970 Atom Heart Mother 55 1
1971 Meddle 70 3
1972 Obscured by Clouds 46 6
1973 The Dark Side of the Moon 1 1
1975 Wish You Were Here 1 1
1977 Animals 3 2
1979 The Wall 1 3
1983 The Final Cut 6 1
1987 A Momentary Lapse of Reason 3 3
1994 The Division Bell 1 1
2014 The Endless River 3 1
```

Resolver las siguientes preguntas:

1. Crear un namespace llamado discografía
2. Crear una tabla llamada discos que contenga sólo las columnas: grupo, nombre_disco, anio,
ranking (a su vez tendrá identificadores para EEUU y UK)
3. Cargar los datos en HBase (se pueden emplear los comandos put o una importación desde PIG).
Nota: algunos años hay más de un disco por lo que la clave será el año y un secuencial, y no se
disponen de todos los datos de rankings por lo que esos datos nulos no será necesario cargarlos
4. Escribir la instrucción y el resultado de consultar el álbum del año 1968
5. Añadir la información de los álbumes de estudio de GreenDay
https://en.wikipedia.org/wiki/Green_Day_discography
6. Ejecuta varias instrucciones (describiéndolas) para analizar datos anteriores

***
# RESULTADO:


## Accedemos al directorio de hadoop y arrancamos y comprobamos los demonios del sistema
Desde la línea de comandos del S.O.:
```bash
cd $HADOOP_HOME
jps
./sbin/start-dfs.sh
./sbin/start-yarn.sh
./sbin/mr-jobhistory-daemon.sh start historyserver
jps
```
![DemoniosHadoop](images/DemoniosHadoop.png)


***
## Accdemos al directorio de HBase, lo arrancamos, accedemos a la consola y comprobamos el estado
Desde la línea de comandos del S.O.:
```bash
cd /home/bigdata/hbase
bin/start-hbase.sh
bin/hbase shell
```
- Desde la línea de comandos del cliente hbase:
```hbase
status
```
![InicioHBaseShell](images/InicioHBaseShell.png)


***
## Creamos el namespace 'discografia'
- Desde la línea de comandos del cliente hbase:
```hbase
create_namespace 'discografia'
```
![CrearNamespace](images/CrearNamespace.png)


***
## Creamos la tabla 'discos'
- Desde la línea de comandos del cliente hbase:
```
create 'discografia:discos', 'info', 'ranking'
scan 'discografia:discos'
describe 'discografia:discos'
```
![CrearTabla](images/CrearTabla.png)


***
## Cargamos los datos en HBase mediante una importación desde PIG.
Los datos pueden cargarse directamente dede la shell de HBase mediante comandos put de la siguiente manera:
- Desde la línea de comandos del cliente hbase:
```hbase
put 'discografia:discos', '1967#1', 'info:anio', 1967
put 'discografia:discos', '1967#1', 'info:grupo', 'Pink Floyd'
put 'discografia:discos', '1967#1', 'info:nombre_disco', 'The Piper at the Gates of Dawn'
put 'discografia:discos', '1967#1', 'ranking:eeuu', 131
put 'discografia:discos', '1967#1', 'ranking:uk', 6
...
scan 'discografia:discos'
```
![CrearTabla](images/PutTabla.png)

Pero vamos a hacerlo usando PIG para leer un fichero CSV y cargarlo en HBase.

Antes de nada eliminaremos los datos insertados:
```
deleteall 'discografia:discos', '1967#1'
scan 'discografia:discos'
```

#### Creamos un fichero CSV con los datos de la discografía de Pink Floid:
Los datos de la discografía de Pink Floid se encuentran en el enlace: [PinkFloid.csv](data/PinkFloid.csv.txt)
- Desde la línea de comandos del S.O.:
```bash
sudo nano /home/bigdata/ejemplosHBase/PinkFloid.csv
```
```csv
1967#1, 1967, Pink Floid, The Piper at the Gates of Dawn, 131, 6
1968#2, 1968, Pink Floid, A Saucerful of Secrets, , 9
1969#3, 1969, Pink Floid, Music from the Film More, 153, 9
1969#4, 1969, Pink Floid, Ummagumma (Disco 2), 74, 5
1970#5, 1970, Pink Floid, Atom Heart Mother, 55, 1
1971#6, 1971, Pink Floid, Meddle, 70, 3
1972#7, 1972, Pink Floid, Obscured by Clouds, 46, 6
1973#8, 1973, Pink Floid, The Dark Side of the Moon, 1, 1
1975#9, 1975, Pink Floid, Wish You Were Here, 1, 1
1977#10, 1977, Pink Floid, Animals, 3, 2
1979#11, 1979, Pink Floid, The Wall, 1, 3
1983#12, 1983, Pink Floid, The Final Cut, 6, 1
1987#13, 1987, Pink Floid, A Momentary Lapse of Reason, 3, 3
1994#14, 1994, Pink Floid, The Division Bell, 1, 1
2014#15, 2014, Pink Floid, The Endless River, 3, 1
```

#### Creamos el fichero PIG para cargar el fichero CSV:
El script fr PIG para cargar los datos de la discografía de Pink Floid se encuentran en el enlace: [carga_PinkFloid.pig](bin/carga_PinkFloid.pig.txt)
- Desde la línea de comandos del S.O.:
```bash
sudo nano /home/bigdata/ejemplosHBase/carga_PinkFloid.pig
```
```pig
-- Cargamos las librerías Java
register '/home/bigdata/hbase/lib/hbase-common-1.2.1.jar';
register '/home/bigdata/hbase/lib/hbase-client-1.2.1.jar';
register '/home/bigdata/hbase/lib/protobuf-java-2.5.0.jar';

-- Cargamos el fichero csv empleando el separador , en los campos id, anio, grupo, nombre_disco, eeuu y uk
datos = LOAD '/home/bigdata/ejemplosHBase/PinkFloid.csv' USING PigStorage( ',' ) AS (
id: chararray,
anio: int,
grupo: chararray,
nombre_disco: chararray,
eeuu: int,
uk: int );

-- Cargamos los datos en la tabla discos del namespace discografia de HBase
STORE datos INTO 'hbase://discografia:discos'
USING org.apache.pig.backend.hadoop.hbase.HBaseStorage ('info:anio info:grupo info:nombre_disco ranking:eeuu ranking:uk');
```

#### Ejecutamos el comando de carga de datos de la discografía de Pink Floid
Abrimos un segundo terminal y ejecutamos:
```
pig -x local /home/bigdata/ejemplosHBase/carga_PinkFloid.pig
```
![InsertPinkFloid](images/InsertPinkFloid.png)

#### Comprobamos el contenido de la tabla 'discografia:discos'
En el primer terminal:
```
scan 'discografia:discos'
describe 'discografia:discos'
```
![ScanPinkFloid](images/ScanPinkFloid.png)


***
# 4. Escribir la instrucción y el resultado de consultar el álbum del año 1968
```
get 'discografia:discos','1968#2'
```
![Discografia1968-2](images/Discografia19682.png)


***
# 5. Añadir la información de los álbumes de estudio de GreenDay

[Discografía de Grren Day](https://en.wikipedia.org/wiki/Green_Day_discography)

### 5.1 Creamos un fichero CSV con los datos de la discografía de Green Day:
[GreenDay.csv](data/GreenDay.csv.txt)

```bash
sudo nano /home/bigdata/ejemplosHBase/GreenDay.csv
```
```csv
1990#20, 1990, Green Day, 39/Smooth, ,
1992#21, 1992, Green Day, Kerplunk, ,
1994#22, 1994, Green Day, Dookie, 2, 13
1995#23, 1995, Green Day, Insomniac, 2, 8
1997#24, 1997, Green Day, Nimrod, 10, 11
2000#25, 2000, Green Day, Warning, 4, 4
2004#26, 2004, Green Day, American Idiot, 1, 1
2009#27, 2009, Green Day, 21st Century Breakdown, 1, 1
2012#28, 2012, Green Day, ¡Uno!, 2, 2
2012#29, 2012, Green Day, ¡Dos!, 9, 10
2012#30, 2012, Green Day, ¡Tré!, 13, 31
```

### 5.2 Creamos el fichero PIG para cargar el fichero CSV:
[carga_GreenDay.pig](bin/carga_GreenDay.pig.txt)

```bash
sudo nano /home/bigdata/ejemplosHBase/carga_GreenDay.pig
```
```pig
-- Cargamos las librerías Java
register '/home/bigdata/hbase/lib/hbase-common-1.2.1.jar';
register '/home/bigdata/hbase/lib/hbase-client-1.2.1.jar';
register '/home/bigdata/hbase/lib/protobuf-java-2.5.0.jar';

-- Cargamos el fichero csv empleando el separador , en los campos id, anio, grupo, nombre_disco, eeuu y uk
datos = LOAD '/home/bigdata/ejemplosHBase/GreenDay.csv' USING PigStorage( ',' ) AS (
id: chararray,
anio: int,
grupo: chararray,
nombre_disco: chararray,
eeuu: int,
uk: int );

-- Cargamos los datos en la tabla discos del namespace discografia de HBase
STORE datos INTO 'hbase://discografia:discos'
USING org.apache.pig.backend.hadoop.hbase.HBaseStorage ('info:anio info:grupo info:nombre_disco ranking:eeuu ranking:uk');
```

### 5.3 Ejecutamos el comando de carga de datos de la discografía de Green Day
Abrimos un segundo terminal y ejecutamos:
```
pig -x local /home/bigdata/ejemplosHBase/carga_GreenDay.pig
```
![InsertGreenDay](images/InsertGreenDay.png)

### 5.4 Comprobamos el contenido de la tabla 'discografia:discos'
```
scan 'discografia:discos'
describe 'discografia:discos'
```
![ScanGreenDay](images/ScanGreenDay.png)

***
# 6. Ejecuta varias instrucciones (describiéndolas) para analizar datos anteriores

### 6.1 Obtener la lista de tablas de la base de datos
```
list
```
![LeerListaTablas](images/LeerListaTablas.png)

### 6.2 Obtener el número de filas de una tabla
```
count 'discografia:discos'
```
![LeerCountTabla](images/LeerCountTabla.png)

### 6.3 Leer una fila de una tabla
```
get 'discografia:discos', '2014#15'
```
![LeerFila](images/LeerFila.png)

### 6.4 Leer una columna de una fila determinada (una celda)
```
get 'discografia:discos', '2014#15', 'info:nombre_disco'
```
![LeerColumna](images/LeerColumna.png)

### 6.5 Otra forma de leer una columna de una fila determinada (una celda)
```
get 'discografia:discos', '2014#15', {COLUMN=>'info:nombre_disco'}
```
![LeerColumna2](images/LeerColumna2.png)

### 6.6 Leer una columna de las filas de una tabla
```
scan 'discografia:discos', { COLUMN => 'info:nombre_disco' }
```
![LeerColumnaFilas](images/LeerColumnaFilas.png)

### 6.7 Leer una columna en las primeras 5 filas de una tabla
```
scan 'discografia:discos', { COLUMN => 'info:nombre_disco', LIMIT => 5 }
```
![LeerColumnaFilas5](images/LeerColumnaFilas5.png)

### 6.8 Leer varias columnas en las primeras 5 filas de una tabla
```
scan 'discografia:discos', { COLUMN => ['info.anio', 'info:nombre_disco'], LIMIT => 5 }
```
![Leer2ColumnaFilas5](images/Leer2ColumnaFilas5.png)

### 6.9 Leer varias columnas de 3 filas de una tabla, empezando a partir de una fila con clave determinada
```
scan 'discografia:discos', { COLUMN => ['info.anio', 'info:nombre_disco'], LIMIT => 5, STARTROW => '1983#12' }
```
![Leer2ColumnaFilas3ini](images/Leer2ColumnaFilas3ini.png)

### 6.10 Leer valores de ranking en EEUU mayor que 10
```
scan 'discografia:discos', { COLUMN => 'ranking:eeuu', FILTER => "ValueFilter( >, 'binary:10' )" }
```
![LeerFiltro](images/LeerFiltro.png)

### 6.11 Obtener la fecha de inserción de un dato
```
Time.at(1475096306895/1000)
```
![ObtenerFechaInsercion](images/ObtenerFechaInsercion.png)

***
