
DELIMITER //

CREATE PROCEDURE CheckBooking(IN inBookingDate DATETIME, IN inTableNo INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM Bookings 
        WHERE BookingDate = inBookingDate AND TableNo = inTableNo
    ) THEN
        SELECT CONCAT('TABLE ', inTableNo, ' is already booked') AS BookingStatus;
    ELSE
        SELECT CONCAT('TABLE ', inTableNo, ' is available') AS BookingStatus;
    END IF;
END
//

DELIMITER ;
