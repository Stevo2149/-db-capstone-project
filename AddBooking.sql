
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN inBookingID INT,
    IN inCustomerID INT,
    IN inBookingDate DATETIME,
    IN inTableNo INT
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNo)
    VALUES (inBookingID, inCustomerID, inBookingDate, inTableNo);
END
//

DELIMITER ;
