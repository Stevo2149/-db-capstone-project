 
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN inBookingID INT,
    IN inBookingDate DATETIME
)
BEGIN
    UPDATE Bookings
    SET BookingDate = inBookingDate
    WHERE BookingID = inBookingID;
END
//

DELIMITER ;
