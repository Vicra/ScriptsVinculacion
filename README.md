# ScriptsVinculacion
Scripts de Migracion para el proyecto de Vinculacion
Los jobs principales estan en la carpeta de process

Aplicación de Migración para la Aplicación de Horas de Vinculación

Antes de la Migración
* Se necesita tener el esquema de la base de datos, si lo quieres correr local podes copiar el esquema en el query que esta en la carpeta ScriptsVinculacion -> CreacionEsquemaTablas.sql

Pasos para correr una migración
1. Seleccionar las conexiones a las bases de datos, Access y MySQL(o a la base de datos).

2. Correr el job que borra toda la data de las tablas.

3. Correr el script que resetea las secuencias de los Id’s de las tablas.

4. Correr el job de la migracionA que corresponde a las tablas basicas.

5. Ejecutar sql para insertar los periodos InsertData -> Inserts_Periods.sql

6. Correr el job de la migracionB que corresponde a las tablas intermedias.

7. Correr el job de la migracion de horas, “New_Migrations_Hours”

Link de Youtube
https://www.youtube.com/watch?v=zgz-WSVYjHM
