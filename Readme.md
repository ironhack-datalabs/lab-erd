#Entity Relationship Diagram (ERD) 
##Iteration 1: Crear ERD en Workbench

**Modelo elegido**: IRONHACK

El modelo simplificado de Ironhack contiene 6 **entidades fuertes** y 3 **débiles** que dependen de las anteriores para existir. 

Las fuertes son:
* Users
* Campus
* LeadingTeachers
* ATs
* MangmStaff
* Cursos

Se podría pensar que los cursos dependen de tener profesores, estudiantes y campus, pero los cursos se consideran un producto en sí mismo, no sólo en el sentido de que existen igual que una marca existe aunque desaparezca la empresa; los cursos además contiene otros atributos que se podrían considerar entidades en sí mismas como el programa, el material de ensenanza, los procedimientos, etc. Así, los cursos se han conceptualizado como producto o paquete de enseñanza (Web, Ux o Data), no como cada una de sus iteraciones. 

Las débiles son:
* StaffRoles
* GradStatus
* SocialNetworksProfile


Los roles (MangStaffRoles) se consideran como entidades débiles en el sentido de que dependen de que tiene que haber una persona de staff que lo tenga para existir. De la misma forma, el estatus de graduado (GradStatus), que puede tomar las formas de "aceptado", "matriculado", "interrumpido" y "alumni", sólo existe cuando hay una persona que lo tiene.

##Iteration 2: Crear relaciones

"SocialNetworksProfile" tiene la peculiaridad de ser una entidad débil que mantiene una **relación** 1:1 con "Users". En principio, como ocurre con muchas relaciones de este tipo, podrían considerarse como parte de los atributos de un alumno. Pero aquí vemos cómo nos es útil separarlos también para reutilizar la misma tabla a modo de plantilla para otras entidades como LeadingTeachers, ATs y el resto del staff de management. 
Además, separarlos, nos sirve para agrupar queries de forma más sencilla, como por ejemplo para hacer un `count` de en cuantas redes sociales participa una persona.

Por supuesto, todo puede sofisticarse mucho más (por ejemplo registrando cuantos seguidores tiene el estudiante en las redes), pero en aras de la simplicidad y eficiencia, restringimos los valores de estos atributos (inicialmente Linkedin, GitHub, Slack, Kaggle y Codewars) a variables binarias, `bin`, que reflejan sí el usuario participa o no participa. 

También tenemos una relación 1:1 más independiente entre leading teachers y cursos en campus (Courses\_has_Campus), asumiendo que cada profesor sólo pudiera estar a cargo de un curso en un campus. 

Las relaciones 1:N del modelo son:
* Ats - Courses\_has_Campus
* MngStaffRoles - MngmStaff
* Campus - MngmStaff
* Campus - Users
* Users - GradStatus

Además existen (antes de la normalización) dos N:N relations que normalizamos con tablas intermedias: 
* Campus - Courses 
* Users - Courses



##Iteration 3

Añadimos Invoice y BillingInfo (facturas e información de la factura que se envía antes al alumno), que mantienen una relación N:N con estudiantes que normalizamos con una tabla intermedia. No es necesario crear una relación 1:N de Courses con Invoice y con BillingInfor pues Usuario ya está asociado a Courses. 


##Iteration 4
Hemos ido normalizando la tabla a medida que la íbamos desarrollando. 


