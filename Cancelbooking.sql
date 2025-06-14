
DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN inBookingID INT
)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = inBookingID;

    SELECT CONCAT('booking ', inBookingID, ' cancelled') AS confirmation;
END
//

DELIMITER ;
