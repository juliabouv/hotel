1. What classes does each implementation include? Are the lists the same?
Each implementation includes the CartEntry, ShoppingCart, and Order classes. The classes in both have the same attributes including the @entries list within ShoppingCart. Order also initializes a new ShoppingCart class for the @cart attribute in both implementations.

2. Write down a sentence to describe each class.
CartEntry holds the individual information for each item including unit price and quantity of item.
Shopping cart holds the information for all items in the cart.
Order holds the information for everything in the cart including the sales tax.

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
CartEntry to ShoppingCart is a many to one relationship, with one ShoppingCart containing many CartEntry's.
ShoppingCart to Order is a one to one relationship, with one Order containing one ShoppingCart.
Order and CartEntry are not directly related, Order gets the information about the individual entries from ShoppingCart instead.

4. What data does each class store? How (if at all) does this differ between the two implementations?
The CartEntry class stores the price and quantity information for each item, the ShoppingCart class stores an array of all CartEntry's, the Order class stores an instance of ShoppingCart. The attributes do not change between the implementations.

5. What methods does each class have? How (if at all) does this differ between the two implementations?
The CartEntry and ShoppingCart do not have methods in the first implementation, but calculate the price in the second implementation.
The Order class has a total_price method in both implementations.

6. Consider the Order#total_price method. In each implementation: Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In the first implementation, the logic to compute the price is retained in Order, in the second implementation, the logic is delegated to the lower level classes.

7. Does total_price directly manipulate the instance variables of other classes?
In the first implementation, the instance variables of other classes are manipulated, in the second the total_price method does not manipulate the instance variables directly, instead accessing the methods of the other classes.

8. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
You could modify the code to reduce the @unit_price based on @quantity in CartEntry. This would be easier to add in the second implementation because the price is actually being calculated directly in that class.

9. Which implementation better adheres to the single responsibility principle?
The second implementation better represents SRP because each class is responsible for tracking its own state and behavior including calculating the price. Whereas the first implementation has Order calculating and tracking the behavior of the other classes' price. 

10. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B is more loosely coupled.
