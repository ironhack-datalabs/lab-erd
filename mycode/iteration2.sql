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
  `idUsers` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `premium` BINARY(1) NOT NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productowners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productowners` (
  `idProductowners` INT NOT NULL,
  `shipments` VARCHAR(45) NULL,
  `numofproducts` VARCHAR(45) NULL,
  `avgshpcost` VARCHAR(45) NULL,
  `totalcost` VARCHAR(45) NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idProductowners`, `idUsers`),
  INDEX `fk_Productowners_Users_idx` (`idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Productowners_Users`
    FOREIGN KEY (`idUsers`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `idProducts` INT NOT NULL,
  `avrate` VARCHAR(45) NULL,
  `description` LONGTEXT NULL,
  `popularity` VARCHAR(45) NULL,
  `price` VARCHAR(45) NULL,
  `availability` VARCHAR(45) NULL,
  `idProductowners` INT NOT NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idProducts`, `idProductowners`, `idUsers`),
  INDEX `fk_Products_Productowners1_idx` (`idProductowners` ASC, `idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Productowners1`
    FOREIGN KEY (`idProductowners` , `idUsers`)
    REFERENCES `mydb`.`Productowners` (`idProductowners` , `idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `idReviews` INT NOT NULL,
  `rating` VARCHAR(45) NULL,
  `votes` VARCHAR(45) NULL,
  `text` TEXT(240) NULL,
  `idProducts` INT NOT NULL,
  `idProductowners` INT NOT NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idReviews`, `idProducts`, `idProductowners`, `idUsers`),
  INDEX `fk_Reviews_Products1_idx` (`idProducts` ASC, `idProductowners` ASC, `idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Reviews_Products1`
    FOREIGN KEY (`idProducts` , `idProductowners` , `idUsers`)
    REFERENCES `mydb`.`Products` (`idProducts` , `idProductowners` , `idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Productsdelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Productsdelivery` (
  `idProductsdelivery` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `userreception` BINARY(1) NOT NULL,
  `shipmentdate` VARCHAR(45) NULL,
  `totalcost` VARCHAR(45) NULL,
  `numberofproducts` VARCHAR(45) NULL,
  `idProductowners` INT NOT NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idProductsdelivery`, `idProductowners`, `idUsers`),
  INDEX `fk_Productsdelivery_Productowners1_idx` (`idProductowners` ASC, `idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Productsdelivery_Productowners1`
    FOREIGN KEY (`idProductowners` , `idUsers`)
    REFERENCES `mydb`.`Productowners` (`idProductowners` , `idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users_has_Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_has_Reviews` (
  `idUsers` INT NOT NULL,
  `idReviews` INT NOT NULL,
  PRIMARY KEY (`idUsers`, `idReviews`),
  INDEX `fk_Users_has_Reviews_Reviews1_idx` (`idReviews` ASC) VISIBLE,
  INDEX `fk_Users_has_Reviews_Users1_idx` (`idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Reviews_Users1`
    FOREIGN KEY (`idUsers`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Reviews_Reviews1`
    FOREIGN KEY (`idReviews`)
    REFERENCES `mydb`.`Reviews` (`idReviews`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Products_has_Productsdelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Products_has_Productsdelivery` (
  `idProducts` INT NOT NULL,
  `idProductsdelivery` INT NOT NULL,
  PRIMARY KEY (`idProducts`, `idProductsdelivery`),
  INDEX `fk_Products_has_Productsdelivery_Productsdelivery1_idx` (`idProductsdelivery` ASC) VISIBLE,
  INDEX `fk_Products_has_Productsdelivery_Products1_idx` (`idProducts` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Productsdelivery_Products1`
    FOREIGN KEY (`idProducts`)
    REFERENCES `mydb`.`Products` (`idProducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_has_Productsdelivery_Productsdelivery1`
    FOREIGN KEY (`idProductsdelivery`)
    REFERENCES `mydb`.`Productsdelivery` (`idProductsdelivery`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
