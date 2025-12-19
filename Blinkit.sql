-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';




-- -----------------------------------------------------
-- Schema blinkit_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blinkit_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blinkit_db` ;

-- -----------------------------------------------------
-- Table `blinkit_db`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(10) NOT NULL,
  `full_name` VARCHAR(80) NOT NULL,
  `email` VARCHAR(120) NULL DEFAULT NULL,
  `address_line` VARCHAR(200) NOT NULL,
  `city` VARCHAR(40) NOT NULL,
  `pincode` CHAR(6) NOT NULL,
  `registered_on` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`dark_stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`dark_stores` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(100) NOT NULL,
  `locality` VARCHAR(120) NOT NULL,
  `city` VARCHAR(40) NOT NULL,
  `pincode` CHAR(6) NOT NULL,
  `contact_number` VARCHAR(10) NULL DEFAULT NULL,
  `status` VARCHAR(20) NULL DEFAULT 'Operational',
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `order_timestamp` DATETIME NOT NULL,
  `delivery_address` VARCHAR(255) NOT NULL,
  `payable_amount` DECIMAL(10,2) NOT NULL,
  `delivery_fee` DECIMAL(6,2) NULL DEFAULT '0.00',
  `order_status` VARCHAR(20) NULL DEFAULT 'PLACED',
  `delivered_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `store_id` (`store_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `blinkit_db`.`customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`store_id`)
    REFERENCES `blinkit_db`.`dark_stores` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`delivery_partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`delivery_partners` (
  `partner_id` INT NOT NULL AUTO_INCREMENT,
  `partner_name` VARCHAR(80) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `vehicle_type` VARCHAR(20) NULL DEFAULT NULL,
  `assigned_store` INT NULL DEFAULT NULL,
  `status` VARCHAR(20) NULL DEFAULT 'Available',
  `joined_on` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`partner_id`),
  UNIQUE INDEX `phone_number` (`phone_number` ASC) VISIBLE,
  INDEX `assigned_store` (`assigned_store` ASC) VISIBLE,
  CONSTRAINT `delivery_partners_ibfk_1`
    FOREIGN KEY (`assigned_store`)
    REFERENCES `blinkit_db`.`dark_stores` (`store_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`deliveries` (
  `delivery_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `pickup_time` DATETIME NULL DEFAULT NULL,
  `drop_time` DATETIME NULL DEFAULT NULL,
  `rating` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`delivery_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `partner_id` (`partner_id` ASC) VISIBLE,
  CONSTRAINT `deliveries_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `blinkit_db`.`orders` (`order_id`),
  CONSTRAINT `deliveries_ibfk_2`
    FOREIGN KEY (`partner_id`)
    REFERENCES `blinkit_db`.`delivery_partners` (`partner_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(120) NOT NULL,
  `category` VARCHAR(40) NOT NULL,
  `brand` VARCHAR(40) NULL DEFAULT NULL,
  `base_price` DECIMAL(8,2) NOT NULL,
  `unit` VARCHAR(20) NULL DEFAULT NULL,
  `short_description` VARCHAR(255) NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`inventory` (
  `inventory_id` INT NOT NULL AUTO_INCREMENT,
  `store_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `available_qty` SMALLINT NOT NULL DEFAULT '0',
  `last_updated` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  UNIQUE INDEX `store_id` (`store_id` ASC, `product_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `inventory_ibfk_1`
    FOREIGN KEY (`store_id`)
    REFERENCES `blinkit_db`.`dark_stores` (`store_id`),
  CONSTRAINT `inventory_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `blinkit_db`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`order_items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` SMALLINT NOT NULL,
  `price_at_time` DECIMAL(8,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_items_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `blinkit_db`.`orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `blinkit_db`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blinkit_db`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blinkit_db`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `payment_method` VARCHAR(20) NOT NULL,
  `payment_status` VARCHAR(20) NULL DEFAULT 'PENDING',
  `amount` DECIMAL(10,2) NOT NULL,
  `transaction_ref` VARCHAR(80) NULL DEFAULT NULL,
  `paid_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `blinkit_db`.`orders` (`order_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
