# SQL
Autor: garcia.cobo.alberto@gmail.com

### Iteración 1 y 2

Mi principal interés es que el sistema de recomendaciones de Amazon pueda ser gestionado fácilmente. Para ello sobre la base de las entidades básicas que son: Users, Products y ProductOwners, me he centrado en definir los Likes y las Reviews. 

Sobre Users me parece importante mencionar los siguientes parámetros: 
* **address** para almacenar el código postal para mejoras posteriores implementar el sistema de envío. 
* **country** para aplicar el IVA correspondiente

Sobre Products: 
* **quantity_available_for_sale** no es necesariamente la suma de los stock de ProductOwners. 
* **promo** será un booleano que definirá si el producto se vende sin IVA o no (black friday), aunque en hay que pensar que mejor un FLOAT para definir el % de descuento sobre el precio. 

### Iteración 3. Incorporamos Facturación y Entrega

Como mejoras he añadido en usuario un **email secundario** (opcional). 
También para mejor coherencia (ya que Workbench automáticamente toma decisiones que no comparto), en las tablas creadas tras una relación n-n sólo habrá una Primary Key y dos Foreing Key (cada uno correspondiente a cada PK de los extremos) además de los demás parámetros necesarios.




