-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `birthDate` DATE NULL,
  `address` VARCHAR(45) NULL,
  `telephone` INT NULL,
  `passportid` INT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sellers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sellers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `telephone` INT NULL,
  `email` VARCHAR(45) NULL,
  `BusinessType` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `price` DOUBLE NULL,
  `weight` DOUBLE NULL,
  `dimensions` VARCHAR(45) NULL,
  `Reviews_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Reviews_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sellers_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sellers_has_Product` (
  `id` INT NOT NULL,
  `Product_id` INT NOT NULL,
  `Sellers_id` INT NOT NULL,
  INDEX `fk_Sellers_has_Product_Product1_idx` (`Product_id` ASC) VISIBLE,
  INDEX `fk_Sellers_has_Product_Sellers_idx` (`Sellers_id` ASC) VISIBLE,
  PRIMARY KEY (`id`, `Product_id`, `Sellers_id`),
  CONSTRAINT `idSellers`
    FOREIGN KEY (`Sellers_id`)
    REFERENCES `mydb`.`Sellers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`Product_id`)
    REFERENCES `mydb`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `id` INT NOT NULL,
  `date` DATE NULL,
  `Users_id` INT NOT NULL,
  `amount` DOUBLE NULL,
  `vat` DOUBLE NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `Users_id`),
  INDEX `fk_Orders_Users1_idx` (`Users_id` ASC) VISIBLE,
  CONSTRAINT `idUsers`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Deliveries` (
  `id` INT NOT NULL,
  `carrier` VARCHAR(45) NULL,
  `estimatedDeliveryDate` DATE NULL,
  `weight` DOUBLE NULL,
  `dimensions` VARCHAR(45) NULL,
  `originWarehouse` VARCHAR(45) NULL,
  `Orders_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Orders_id`),
  INDEX `fk_Deliveries_Orders1_idx` (`Orders_id` ASC) VISIBLE,
  CONSTRAINT `idOrders`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `id` INT NOT NULL,
  `content` VARCHAR(45) NULL,
  `rating` INT NULL,
  `date` DATE NULL,
  `Orders_id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Orders_id`, `Products_id`),
  INDEX `fk_Reviews_Orders1_idx` (`Orders_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Products1_idx` (`Products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Orders1`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reviews_Products1`
    FOREIGN KEY (`Products_id`)
    REFERENCES `mydb`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CreditCards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CreditCards` (
  `id` INT NOT NULL,
  `creditCardNumber` INT NULL,
  `expiryDate` DATE NULL,
  `emisionDate` DATE NULL,
  `securityCode` INT NULL,
  `name` VARCHAR(45) NULL,
  `Users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Users_id`),
  INDEX `fk_BankingProfile_Users1_idx` (`Users_id` ASC) VISIBLE,
  CONSTRAINT `fk_BankingProfile_Users1`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders_has_Products` (
  `id` INT NOT NULL,
  `Orders_id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  INDEX `fk_Orders_has_Products_Products1_idx` (`Products_id` ASC) VISIBLE,
  INDEX `fk_Orders_has_Products_Orders1_idx` (`Orders_id` ASC) VISIBLE,
  PRIMARY KEY (`id`, `Orders_id`, `Products_id`),
  CONSTRAINT `idOrders`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProducts`
    FOREIGN KEY (`Products_id`)
    REFERENCES `mydb`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoices` (
  `id` INT NOT NULL,
  `amount` DOUBLE NULL,
  `date` DATE NULL,
  `billingAddress` VARCHAR(45) NULL,
  `issuingCompany` VARCHAR(45) NULL,
  `totalTax` VARCHAR(45) NULL,
  `Orders_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Orders_id`),
  INDEX `fk_Invoices_Orders1_idx` (`Orders_id` ASC) VISIBLE,
  CONSTRAINT `fk_Invoices_Orders1`
    FOREIGN KEY (`Orders_id`)
    REFERENCES `mydb`.`Orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
