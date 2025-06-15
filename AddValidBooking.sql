
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN inBookingDate DATETIME,
    IN inTableNo INT,
    IN inCustomerID INT
)
BEGIN
    DECLARE bookingExists INT DEFAULT 0;

    START TRANSACTION;

    -- Check if the table is already booked for the given date
    SELECT COUNT(*) INTO bookingExists
    FROM Bookings
    WHERE BookingDate = inBookingDate AND TableNo = inTableNo;

    IF bookingExists > 0 THEN
        -- Table is already booked, rollback and return message
        ROLLBACK;
        SELECT CONCAT( 'Table ', inTableNo, ' is already booked', inBookingDate) AS BookingStatus;
    ELSE
        -- Table is available, insert booking and commit
        INSERT INTO Bookings (BookingDate, TableNo, CustomerID)
        VALUES (inBookingDate, inTableNo, inCustomerID);
        COMMIT;
        SELECT CONCAT(' Table ', inTableNo, ' booked for ', inBookingDate) AS BookingStatus;
    END IF;
END
//

DELIMITER ;
