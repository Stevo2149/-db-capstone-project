-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Starter` VARCHAR(100),
  `MainCourse` VARCHAR(100),
  `Dessert` VARCHAR(100),
  PRIMARY KEY (`MenuItemID`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `TableNo` INT NOT NULL,
  PRIMARY KEY (`BookingID`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(10) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `OrderDeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `OrderDeliveryStatusID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATETIME NOT NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  PRIMARY KEY (`OrderDeliveryStatusID`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Item` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menuitem_id_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menuitem_id_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL,
  `BookingID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `OrderDeliveryStatusID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `orderdeliverystatus_id_fk_idx` (`OrderDeliveryStatusID` ASC) VISIBLE,
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `booking_id_fk_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orderdeliverystatus_id_fk`
    FOREIGN KEY (`OrderDeliveryStatusID`)
    REFERENCES `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `booking_id_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` DECIMAL(10,2) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`StaffID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `staff_customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Placeholder table for view `OrderView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderView` (`OrderID` INT, `Quantity` INT, `TotalCost` DECIMAL(10,2));

-- -----------------------------------------------------
-- View `OrderView`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderView`;
CREATE OR REPLACE VIEW `OrderView` AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

-- -----------------------------------------------------
-- Example INSERT statements
-- -----------------------------------------------------
INSERT INTO `MenuItems` (`Name`, `Starter`, `MainCourse`, `Dessert`) VALUES
  ('Italian Combo', 'Bruschetta', 'Lasagna', 'Tiramisu'),
  ('Greek Feast', 'Dolmades', 'Moussaka', 'Baklava');

INSERT INTO `Bookings` (`Date`, `TableNo`) VALUES
  ('2024-06-01 19:00:00', 5),
  ('2024-06-02 20:00:00', 3);

INSERT INTO `Customers` (`FullName`, `ContactNumber`, `Email`) VALUES
  ('Alice Smith', '1234567890', 'alice@example.com'),
  ('Bob Jones', '0987654321', 'bob@example.com');

INSERT INTO `OrderDeliveryStatus` (`DeliveryDate`, `DeliveryStatus`) VALUES
  ('2024-06-01 20:00:00', 'Delivered'),
  ('2024-06-02 21:00:00', 'Pending');

INSERT INTO `Menus` (`Item`, `Description`, `MenuItemID`) VALUES
  ('Italian Night', 'A classic Italian dinner', 1),
  ('Greek Night', 'Traditional Greek dishes', 2);

INSERT INTO `Orders` (`Date`, `Quantity`, `TotalCost`, `BookingID`, `CustomerID`, `OrderDeliveryStatusID`, `MenuID`) VALUES
  ('2024-06-01 19:15:00', 3, 120.00, 1, 1, 1, 1),
  ('2024-06-02 20:30:00', 2, 80.00, 2, 2, 2, 2);

INSERT INTO `Staff` (`FullName`, `ContactNumber`, `Role`, `Salary`, `CustomerID`) VALUES
  ('Chef Mario', '1112223333', 'Chef', 50000.00, 1),
  ('Server Anna', '4445556666', 'Server', 35000.00, 2);

-- -----------------------------------------------------
-- Example Queries (adjusted for new structure)
-- -----------------------------------------------------
SELECT c.CustomerID, c.FullName, o.OrderID, o.TotalCost,
       m.Item, n.Name AS MenuItemName, n.Starter
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Menus m ON m.MenuID = o.MenuID 
JOIN MenuItems n ON m.MenuItemID = n.MenuItemID
WHERE o.TotalCost < 150
ORDER BY o.TotalCost ASC;

SELECT m.Item
FROM Menus m
JOIN Orders o ON m.MenuID = o.MenuID
WHERE o.Quantity > 2;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
