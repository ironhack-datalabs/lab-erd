Elijo Amazon como empresa. Mi idea es generar una base de datos que cubra el ciclo desde que el cliente adquiere un producto hasta que le llega a casa. Elijo como entidades:

        Cliente
        Pedido Cliente
        Producto
        Proveedor
        Transportista

Comienzo creando las relaciones uno a uno ya que parecen las más sencillas, pero para eso tengo que crear una nueva tabla que contega sólo datos relacionado con el cliente, por lo que creo una nueva tabla que recoja unicamente el último pedido del cliente.

Comienzo a crear las relaciones:

    Uno a uno: Cliente-último pedido cliente
    Uno a varias: 
        Cliente-Pedido (un mismo cliente puede tener varios pedidos)
        Proveedor-Transportista(un proveedor puede tener varios transportistas)
    Muchas  a muchas: Aquí radica la dificultad, ya que al establecer las relaciones se crea una tabla intermedia que es la que permite unir las otras dos tablas, hay que modificar las llaves foráneas ya que las asigna de una manera que no es acorde con el modelo.
        Producto-Proveedor-Producto_por_proveedor
        Pedido-Transportista-Pedido_por_transportista
    Modificamos las claves foráneas y creamos un Id para cada una de las tablas nuevas, ya que en este caso no se generan automáticamente

Por otro lado creo el repositorio en mi carpeta Ironhack/projecto sql, para eso hacemos un fork en github del repositorio original, lo clonamos y lo añadimos a nuestro repositorio tecleando git remote add origin y la ruta que hemos descargado.

Abrimos Visual Code y modificamos los 4 ficheros que se incluyen en mycode (dentro de la ruta descargada)

Guardamos cambios haciendo git commit y git push origin master.
Comprobamos con Git status que hemos guardado los cambios
Hacemos Pull request


