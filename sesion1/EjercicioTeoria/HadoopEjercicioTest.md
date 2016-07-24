***
# Hadoop: Ejercicios.
***
- Autor: Juan A. García Cuevas
- Fecha: 10/07/2016

***

## 1. Devolver el resultado de ejecutar el siguiente comando
$HADOOP_HOME/bin/hdfs dfs ‐cat /outHDFS/*

```
    bigdata@bigdata:~/ejemploHadoop/ejercicio1$ hdfs dfs -cat /outHDFS/*
    16/07/10 11:48:32 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    Esta	2
    de	    1
    ejemplo	1
    es	    2
    línea	2
    otra	1
    una  	1
    bigdata@bigdata:~/ejemploHadoop/ejercicio1/inlocal$
```

![Test](images/test1.png)

## 2. ¿Cuál de los siguientes funcionalidades pertenecen a un NameNode de HDFS?
- a. Transferir bloques de datos de los datanodes a los clientes.
- **b. Mantener el árbol del sistema de archivos y los metadatos de todos los ficheros y directorios**
- c. Controlar los procesos de Map Reduce.
- d. Almacenar bloques de datos.
- e. Ninguna de las opciones es correcta.

#### Respuesta: B

- NOTAS:
    - _La arquitectura básica de HDFS es la de maestro/esclavos, donde al maestro se le conoce como Namenode y es un nodo de nuestro cluster que se encarga del espacio de nombres de ficheros y de dar acceso a los ficheros a los clientes ([Introducción a HDFS](https://hop2croft.wordpress.com/2013/08/24/introduccion-a-hdfs/))._

## 3. ¿Cuál de los siguientes funcionalidades pertenece a un DataNode de HDFS?
- a. Mantener el árbol del sistema de archivos y los metadatos de todos los ficheros y directorios.
- b. Controlar la ejecución de una tarea de mapeo o de reduce individual.
- c. Gestionar el sistema de espacios de nombres de los archivos.
- **d. Almacenar y recuperar bloques cuando los clientes o el NameNode lo solicita.**
- e. Ninguna de las opciones es correcta.

#### Respuesta: D

- NOTAS:
    - _... los ... Namenodes ... se encarguen del almacenamiento de los datos y de leer o escribir los bloques en datos en función de las peticiones del cliente ([Introducción a HDFS](https://hop2croft.wordpress.com/2013/08/24/introduccion-a-hdfs/))._

## 4. ¿Cuál de las siguientes frases es cierta con respecto a YARN?
- a. **Implementa un gestor de recursos externos para todos los frameworks de Hadoop.**
- b. Permitir acceso a los datos de HDFS a programas que no estén desarrollados en Hadoop.
- c. Permitir a múltiples Namenodes con sus propios namespaces, compartir el pool de Datanodes.
- _d. Usar el JournalNode para decidir el NameNode activo._
- e. Ninguna de las anteriores es correcta.

#### Respuesta: A

- NOTAS: 
    - _Yarn  combina  un  gestor  de  recursos  central  que  gestiona  la  forma  en  que  las 
aplicaciones  utilizan  los  recursos  del  sistema...([nstalación y configuración de herramientas 
software para Big Data](https://riunet.upv.es/bitstream/handle/10251/64098/-DAV%C3%93%20-%20Instalaci%C3%B3n%20y%20configuraci%C3%B3n%20de%20herramientas%20software%20para%20Big%20Data.pdf?sequence=2))._

## 5. HDFS está diseñado para
- a. Ficheros grandes, acceso continuo a los datos y hardware de grandes prestaciones.
- b. Ficheros pequeños, acceso continuo a los datos y hardware básico.
- c. Ficheros grandes, baja latencia de acceso y hardware básico.
- **d. Ficheros grandes, acceso continuo a los datos y hardware básico.**
- e. Ninguna de las anteriores es correcta.

#### Respuesta: D

- NOTAS: 
    - _HDFS fue diseñado para gestionar archivos muy grandes ([Hadoop](https://es.wikipedia.org/wiki/Hadoop))._
    - _Está diseñado para ejecutarse en equipos de bajo coste formando clústeres ([Un poco de Hadoop](https://unpocodejava.wordpress.com/2012/08/29/un-poco-de-hadoop/))._

## 6. ¿Qué es común a Pig y Hive?
- a. Permiten múltiples y aleatorias escrituras y lecturas.
- b. **Traducen lenguajes de alto nivel a trabajos de Map Reduce.**
- c. Todas operan con estructura de datos JSON.
- d. Todas son lenguajes de flujos de datos.
- e. Ninguna de las anteriores es correcta.

#### Respuesta: B

- NOTAS: _([Hive, Sqoop y Pig](http://blogs.solidq.com/es/big-data/hive-sqoop-y-pig/))._

## 7. ¿Qué es Flume?
- a. Un sistema de archivos distribuido.
- b. Una plataforma de ejecución de tareas de MapReduce.
- c. Un lenguaje de programación que traduce queries de alto nivel en tareas de map reduce.
- **d. Un servicio para mover grandes cantidades de datos en un cluster una vez los datos se han generado.**
- e. Ninguna de las anteriores.

#### Respuesta: D

- NOTAS: _Apache Flume es un producto que forma parte del ecosistema Hadoop, y conforma una solución Java distribuida y de alta disponibilidad para recolectar, agregar y mover grandes cantidades de datos desde diferentes fuentes a un data store centralizado. ([¿Qué es Apache Flume?](https://unpocodejava.wordpress.com/2012/10/25/que-es-apache-flume/))._

## 8. ¿En cuál de los siguientes escenarios usarías Hadoop?
- a. Analizar los signos vitales de un bebé en tiempo real.
- b. Obtener las tendencias de acciones bursátiles cada minuto.
- c. Procesar un sensor meteorológico para predecir la trayectoria de un huracán.
- **d. Procesar billones de mensajes de email para ejecutar análisis de texto.**
- e. Ninguna de las anteriores.

#### Respuesta: D

- NOTAS:
    - _Los sistemas Hadoop, diseñados para el procesamiento por lotes, no se prestan para la rápida actuación que requiere el análisis de datos en tiempo real ([¿Es Hadoop todavía muy lento para aplicaciones de análisis en tiempo real?](http://searchdatacenter.techtarget.com/es/cronica/Es-Hadoop-todavia-muy-lento-para-aplicaciones-de-analisis-en-tiempo-real))._


    - _Hadoop está pensado para consumir un alto volumen de datos. ... estamos hablando de un proceso batch y no de uno en tiempo real ([Introducción a HDFS](https://hop2croft.wordpress.com/2013/08/24/introduccion-a-hdfs/))._


## 9. ¿Cuál de las siguientes frases es cierta?
- a. Hadoop es una nueva tecnología diseñada para reemplazar las bases de datos relacionales.
- b. Hadoop incluye componentes open source y closed source.
- c. Hadoop se puede usar para bigdata, DSS y OLTP.
- d. Todas las anteriores son correctas.
- **e. Ninguna de las anteriores es correcta.**

#### Respuesta: E

- NOTAS: 
    - _Hadoop no está diseñado para OLTP, OLAP o DSS. Sí está diseñado para Bigdata y complementar OLTP y OLAP ([Big Data y Supercómputo](https://ccc.inaoep.mx/~jagonzalez/MLII/BigData.pdf))._
    - _No reemplaza una BD relacional ([Big Data y Supercómputo](https://ccc.inaoep.mx/~jagonzalez/MLII/BigData.pdf))._

***

### Referencias:
- [Big Data y Supercómputo](https://ccc.inaoep.mx/~jagonzalez/MLII/BigData.pdf)
- [Hadoop](https://es.wikipedia.org/wiki/Hadoop)
- [Un poco de Hadoop](https://unpocodejava.wordpress.com/2012/08/29/un-poco-de-hadoop/)
- [¿Es Hadoop todavía muy lento para aplicaciones de análisis en tiempo real?](http://searchdatacenter.techtarget.com/es/cronica/Es-Hadoop-todavia-muy-lento-para-aplicaciones-de-analisis-en-tiempo-real)
- [Introducción a HDFS](https://hop2croft.wordpress.com/2013/08/24/introduccion-a-hdfs/)
- [instalación y configuración de herramientas software para Big Data](https://riunet.upv.es/bitstream/handle/10251/64098/-DAV%C3%93%20-%20Instalaci%C3%B3n%20y%20configuraci%C3%B3n%20de%20herramientas%20software%20para%20Big%20Data.pdf?sequence=2)
- [Hive, Sqoop y Pig](http://blogs.solidq.com/es/big-data/hive-sqoop-y-pig/)
- [¿Qué es Apache Flume?](https://unpocodejava.wordpress.com/2012/10/25/que-es-apache-flume/)

### Glosario:
- DSS: Sistemas de soporte a decisiones
- OLTP: Procesamiento de transacciones en linea


***
