CREATE VIEW `OrderView` AS SELECT OrderID, Quantity, TotalCost
 FROM Orders
 WHERE Quantity > 2;
 
 SELECT c.CustomerID, c.FullName, o.OrderID, o.TotalCost,
 m.MenuName, n.Item, n.Starter
 FROM Customers c
 INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
 JOIN Menus m ON m.MenuID = o.MenuID 
 JOIN MenuItems n ON m.MenuItemID = n.MenuItemID
 WHERE TotalCost < 150 ORDER BY TotalCost ASC;
 
 SELECT  m.Item 
 FROM Menus m
 JOIN Orders o ON m.MenuID = o.MenuID
 WHERE ANY (SELECT * FROM Orders WHERE Quantity > 2);