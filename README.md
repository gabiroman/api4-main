# API4 - SEMINARIO DE ACTUALIZACIÓN EN SISTEMAS COLABORATIVOS

## Se requiere 
DB MariaDB  10.4.16 o superior/compatible
Python 3.10.7 o superior.

## Utiliza
Bootstrap 5.2.2
Jquery 3.6.1

## Archivos del proyecto
* /api4.py ----------------- archivo ejecutable del proyecto (fuertemente acoplado, sin implementación de patrones)
* /pip-requisitos.txt ------ requerimientos del proyecto
* /templates
* /templates/layout.html ------ archivo html inicializador (headers)
* /templates/turnos.html ------ archivo html principal (muestra los turnos asignados, los disponibles y las opciones de ABM)
* /templates/turnos_edit.html - archivo html con form para modificar turno
* /templates/turnos_fadd.html - archivo html con formulario para alta de turno
* /extras
* /extras/dumbp.sql ----------- archivo dump sql para creación de base "turnerodb" (tablas "pacientes","turnos" y "turnos_pacientes")

## Modificar archivo api4.py con los valores correspondientes para
* app.config['MYSQL_HOST'] = 'IP/FQDN del server SQL'
* app.config['MYSQL_USER'] = 'usuario De Conexion Que Corresponda'
* app.config['MYSQL_PASSWORD'] = 'password Que Corresponda al Usuario de Conexion'
* app.config['MYSQL_DB'] = 'turnerodb'


## Para iniciar el proyecto
* instalar requerimientos python mediante pip (ejecutar: pip install -r pip-requisitos.txt)
* una vez configurada la conexión a la base de datos e instalados los requerimientos python, ejecutar: python api4.py
* acceder mediante browser http://localhost:5000/turnos





