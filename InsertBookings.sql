

INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID) 
VALUES  
    (3, '2022-11-12', 2, 2), 
    (4, '2022-10-13', 2, 1);

UPDATE bookings 
SET BookingDate = '2022-10-10', TableNo = 5, CustomerID = 1
WHERE BookingID = 1;

UPDATE Bookings 
SET BookingDate = '2022-11-12', TableNo = 3, CustomerID = 3
WHERE BookingID = 2;

UPDATE Bookings 
SET BookingDate = '2022-11-12', TableNo = 2, CustomerID = 2
WHERE BookingID = 3;

UPDATE Bookings 
SET BookingDate = '2022-10-13', TableNo = 2, CustomerID = 1
WHERE BookingID = 4;

SELECT * FROM Bookings


UPDATE Bookings
SET BookingDate = '2022-10-10', TableNo = 5, CustomerID = 1
WHERE BookingID = 1;






