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
