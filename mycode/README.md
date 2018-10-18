# Caso Amazon
**Autor**: garcia.cobo.alberto@gmail.com
**tags**: Workbench, SQL, git, github, EER, Amazon

### Previo
Me me he decido por el caso de Amazon porque quería trabajar en este ejercicio con un sistema que gestione envíos además de recomendaciones como Spotify. 

### Iteración 1 y 2
En esta primera iteración mi principal objetivo es que el sistema de recomendaciones de Amazon pueda ser gestionado fácilmente. Para ello sobre la base de las entidades básicas que son: Users, Products y ProductOwners, me he centrado en definir los Likes y las Reviews. 

Ambos son consecuencia de una relación n-m pero en el caso de **Likes** la simple relación proporciona el LIKE, pero en el caso de **Reviews**, eśtas deben tener texto, tags, título, imágenes (esta parte la he obviado para no añadir complejidad) y en nuestro caso stars, que define lo buena o mala que sea la review entre 0-5. 

Sobre **Users** me parece importante mencionar los siguientes parámetros: 
* **address** para almacenar el código postal para mejoras posteriores implementar el sistema de envío. 
* **genre, trust_rate, birth** sirven para que el usuario sea objetivo de recomendaciones que le sean deseables. 
* **country** para aplicar el IVA correspondiente en cada caso, ya sea sobre Users o sobre DeliveryCompanies. 

Sobre **Products**: 
* **quantity_available_for_sale** no es necesariamente la suma de los stock de ProductOwners. 
* **promo** será un booleano que definirá si el producto se vende sin IVA o no (black friday), aunque en hay que pensar que mejor un FLOAT para definir el % de descuento sobre el precio. 
* **department** es la sección en la que se podrá englobar el producto: electrónica, música, libros, etc. para que las búsquedas por parte de los usuarios no vayan sobre toda la base de datos. 

### Iteración 3 y 4. Incorporamos Facturación y Entrega
En esta continuación del trabajo procedo a añadir el sistema de envíos a través de las entidades **Shipment** y **DeliveryCompanies**. 

He incluido una entidad Countries para aplicar el IVA correspondiente en cada caso, ya sea sobre Users o sobre DeliveryCompanies . 

Para mejor coherencia (ya que Workbench automáticamente toma decisiones que no comparto), en las tablas creadas tras una relación n-m sólo habrá una Primary Key (id INT) y dos Foreing Key (cada uno correspondiente a cada PK de los extremos) además de los demás parámetros necesarios como por ejemplo Reviews.

Como mejoras futuras quiero añadir en Users un **email secundario**, además de una entidad que gestione el sistema de pagos. 


