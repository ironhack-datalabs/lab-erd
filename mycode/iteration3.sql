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
-- Table `mydb`.`ProductOwners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductOwners` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `address` VARCHAR(400) NULL DEFAULT NULL,
  `stock` INT(11) NULL DEFAULT NULL,
  `free_shipment` TINYINT(4) NULL DEFAULT NULL,
  `phone` INT(11) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `postal_code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `cuantity_available_for_sale` INT NULL DEFAULT NULL,
  `promo` TINYINT(4) NULL DEFAULT NULL,
  `department` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`ProductOwners_sells_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProductOwners_sells_Products` (
  `id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  `ProductOwners_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ProductOwners_has_Products_Products1_idx` (`Products_id` ASC) VISIBLE,
  INDEX `fk_ProductOwners_has_Products_ProductOwners1_idx` (`ProductOwners_id` ASC) VISIBLE,
  CONSTRAINT `fk_ProductOwners_has_Products_ProductOwners1`
    FOREIGN KEY (`ProductOwners_id` , `Products_id`)
    REFERENCES `mydb`.`ProductOwners` (`id` , `id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_ProductOwners_has_Products_Products1`
    FOREIGN KEY (`Products_id`)
    REFERENCES `mydb`.`Products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Countries` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `prefix_phone` VARCHAR(45) NULL,
  `capital` VARCHAR(45) NULL,
  `population` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `address` VARCHAR(400) NULL DEFAULT NULL,
  `birth` DATE NULL DEFAULT NULL,
  `premium` TINYINT(4) NULL DEFAULT NULL,
  `trust_rate` FLOAT NULL DEFAULT NULL,
  `genre` VARCHAR(45) NULL DEFAULT NULL,
  `postal_code` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `phone` INT NULL DEFAULT NULL,
  `Countries_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_Countries1_idx` (`Countries_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Countries1`
    FOREIGN KEY (`Countries_id`)
    REFERENCES `mydb`.`Countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `text` VARCHAR(1000) NULL DEFAULT NULL,
  `date` VARCHAR(45) NULL DEFAULT NULL,
  `stars` INT NULL DEFAULT NULL,
  `Users_id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Reviews_Users1_idx` (`Users_id` ASC) VISIBLE,
  INDEX `fk_Reviews_Products1_idx` (`Products_id` ASC, `Users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Products1`
    FOREIGN KEY (`Products_id` , `Users_id`)
    REFERENCES `mydb`.`Products` (`id` , `id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Reviews_Users1`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Users_buys_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_buys_Products` (
  `id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  `Users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_has_Products_Products1_idx` (`Products_id` ASC, `Users_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Products_Users_idx` (`Users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Products_Products1`
    FOREIGN KEY (`Products_id` , `Users_id`)
    REFERENCES `mydb`.`Products` (`id` , `id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Users_has_Products_Users`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Users_likes_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_likes_Products` (
  `id` INT NOT NULL,
  `Products_id` INT NOT NULL,
  `Users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_has_Products_Products2_idx` (`Products_id` ASC, `Users_id` ASC) VISIBLE,
  INDEX `fk_Users_has_Products_Users1_idx` (`Users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Products_Products2`
    FOREIGN KEY (`Products_id` , `Users_id`)
    REFERENCES `mydb`.`Products` (`id` , `id`),
  CONSTRAINT `fk_Users_has_Products_Users1`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`DeliveryCompanies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DeliveryCompanies` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(400) NULL,
  `phone` INT NULL,
  `country` VARCHAR(45) NULL,
  `Countries_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_DeliveryCompanies_Countries1_idx` (`Countries_id` ASC) VISIBLE,
  CONSTRAINT `fk_DeliveryCompanies_Countries1`
    FOREIGN KEY (`Countries_id`)
    REFERENCES `mydb`.`Countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shipments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shipments` (
  `id` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `init_date` DATE NULL,
  `end_date` DATE NULL,
  `DeliveryCompanies_id` INT NOT NULL,
  `Users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Shipments_DeliveryCompanies1_idx` (`DeliveryCompanies_id` ASC, `Users_id` ASC) VISIBLE,
  INDEX `fk_Shipments_Users1_idx` (`Users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Shipments_DeliveryCompanies1`
    FOREIGN KEY (`DeliveryCompanies_id` , `Users_id`)
    REFERENCES `mydb`.`DeliveryCompanies` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Shipments_Users1`
    FOREIGN KEY (`Users_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shipments_has_Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shipments_has_Products` (
  `id` INT NOT NULL,
  `Products_idProducts` INT NOT NULL,
  `Shipments_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Shipments_has_Products_Products1_idx` (`Products_idProducts` ASC) VISIBLE,
  INDEX `fk_Shipments_has_Products_Shipments1_idx` (`Shipments_id` ASC, `Products_idProducts` ASC) VISIBLE,
  CONSTRAINT `fk_Shipments_has_Products_Shipments1`
    FOREIGN KEY (`Shipments_id` , `Products_idProducts`)
    REFERENCES `mydb`.`Shipments` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Shipments_has_Products_Products1`
    FOREIGN KEY (`Products_idProducts`)
    REFERENCES `mydb`.`Products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

