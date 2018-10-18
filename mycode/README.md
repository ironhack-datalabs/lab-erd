# Process to create a workbench diagram to define the business operation model

## Amazon

1. A first sketch of the model was created in a piece of paper

2. Once the different entities and the relationships between them made sense, the sketch was translated into a diagram in MySQL Workbench, for this:

* From MySQL Workbench's file menu, select new model and once the model is created select "Add Diagram"

* Place tables, define entities (tables) and their attributes (columns)

* Link the different entities using relationships laces that define one to one, one to many or many to many relatioships as necessary.

3. The logic of the Amazon diagram in this example lies on the relationship that the entity order has with the rest of entities. At the end, Amazon is a marketplace which aims to generate as many orders as possible.

* A user(entity) could generate several orders, however each of the orders will be associated with just one user(one to many). Such order could contain several products and at the same time the products in one order can also exist in a different order(many to many). Such products are sold by a seller who could have several products on sale. Moreover, products could be sold by several sellers (many to many). Once a user complete an order, this order will generate a unique delivery, and such delivery is associated just with one order(one to one). Once the order is received by the user, amazon will request the user to leave a review in the web, an order could generate as many reviews as product contains, however a specific review is associated with just one order (one to many). At the same time, a specific product can be reviewed several times as a consequence of its presence in several orders, however a review is specific to one product (one to many). 

4. The inclusion of the invoice entity was made after the whole logic in point 3 was developed. Such entity is again in a relationship with the orders entity. An order will generate one invoice and an invoice can be associated with just one order. Therefore we have a one to one relationship.

5. From Github, the las-erd was forked. This generates a copy in the user's global repository.

6. From the user's lab-erd repository, clicking in clone and making sure the option SSH is chosen, a link is prompted. Such link is copied.

7. From the console, navigate to the directory where the the local repository will be cloned. Once in there:

"""git clone git@github.com:AlbertoCastellanos/lab-erd.git"""




