# Proyecto SQL - base de datos Ironhack
## Paso 1 - Planificacion las entidades
* Leads <br>
* Alumnos <br>
* Cursos <br>
* Campus <br>
* Profesores <br>
* Eventos <br>
## Paso 2 - Planificacion los atributos por entidad
* Leads: nombre y correo <br>
* Alumnos: nombre, nacimiento, correo, telefono, linkedin, dni y cuenta_bancaria <br>
* Cursos: fecha, alumnos y tema <br>
* Campus: ciudad, lat, lng y trabajadores <br>
* Profesores: nombre, nacimiento, localidad, sector y expreiencia <br>
* Eventos: nombre, ponente, fecha, lat y lng <br>
## Paso 3 - Planificacion las relaciones
* One-to-One: Leads-Alumnos <br>
* One-to-Many: Campus-Eventos, Cursos-Campus <br>
* Many-to-Many: Leads-Eventos, Alumnos-Cursos, Cursos-Profesores y Campus-Empresa <br>
![grafo](iteration1.png)