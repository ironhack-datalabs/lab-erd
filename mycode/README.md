# Day 3, Proyecto SQL - base de datos para AMAZON
## Paso 1
Creo la base de datos para AMAZON. Las entidades son: <br>
Users, Reviews, Products, Productsdelivery y Productowners <br>
En la imagen se incluyen las relaciones entre los diferentes diagramas. <br>
![grafo](iteration1.png)
## Paso 2
Configuro las relaciones.<br>
Relaciones One to One:<br>
    Users con Productowners <br>
Relaciones One to Many: <br>
    Productsowners con Productsdelivery<br>
    Productsowners con Products<br>
    Products con Reviews<br>
Relaciones Many to Many:<br>
    Users con Reviews<br>
    Products con Productsdelivery<br>
Exportamos como SQL script as iteration2.sql
## Paso 3
Añado la entidad Billinginfo con los siguientes attributos:<br>
    name, lastname, adress, city, country, zip, contactphone, bankaccount<br>
Esta entidad se relaciona con Users con una conexion One to One<br>
Exportamos como SQL script as iteration3.sql
## Paso 4
Creo que el resultado final está normalizado<br>
Adjunto figura final de la base de datos:<br>
![grafo2](iteration4.png)