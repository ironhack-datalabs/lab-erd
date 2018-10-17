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
-- Table `mydb`.`Albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Albums` (
  `idAlbums` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATE NULL,
  `length` FLOAT NULL,
  `source` VARCHAR(45) NULL,
  PRIMARY KEY (`idAlbums`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Songs` (
  `idSongs` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATE NULL,
  `length` FLOAT NULL,
  `idAlbums` INT NOT NULL,
  PRIMARY KEY (`idSongs`, `idAlbums`),
  INDEX `fk_Songs_Albums1_idx` (`idAlbums` ASC) VISIBLE,
  CONSTRAINT `fk_Songs_Albums1`
    FOREIGN KEY (`idAlbums`)
    REFERENCES `mydb`.`Albums` (`idAlbums`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Artists` (
  `idArtists` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `about` VARCHAR(45) NULL,
  `tour` VARCHAR(45) NULL,
  `monthlylisteners` INT(20) NULL,
  PRIMARY KEY (`idArtists`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Additional`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Additional` (
  `idAdditional` INT NOT NULL,
  `premium` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `number` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`idAdditional`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `idUsers` INT NOT NULL,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `country` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `idAdditional` INT NOT NULL,
  PRIMARY KEY (`idUsers`, `idAdditional`),
  INDEX `fk_Users_Additional1_idx` (`idAdditional` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Additional1`
    FOREIGN KEY (`idAdditional`)
    REFERENCES `mydb`.`Additional` (`idAdditional`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Playlists` (
  `idPlaylists` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `date` DATE NULL,
  `length` FLOAT NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idPlaylists`, `idUsers`),
  INDEX `fk_Playlists_Users1_idx` (`idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_Users1`
    FOREIGN KEY (`idUsers`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Albums_has_Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Albums_has_Artists` (
  `idAlbums` INT NOT NULL,
  `idArtists` INT NOT NULL,
  PRIMARY KEY (`idAlbums`, `idArtists`),
  INDEX `fk_Albums_has_Artists_Artists1_idx` (`idArtists` ASC) VISIBLE,
  INDEX `fk_Albums_has_Artists_Albums1_idx` (`idAlbums` ASC) VISIBLE,
  CONSTRAINT `fk_Albums_has_Artists_Albums1`
    FOREIGN KEY (`idAlbums`)
    REFERENCES `mydb`.`Albums` (`idAlbums`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Albums_has_Artists_Artists1`
    FOREIGN KEY (`idArtists`)
    REFERENCES `mydb`.`Artists` (`idArtists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Playlists_has_Songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Playlists_has_Songs` (
  `Playlists_idPlaylists` INT NOT NULL,
  `Playlists_Users_idUsers` INT NOT NULL,
  `Songs_idSongs` INT NOT NULL,
  `Songs_Artists_idArtists` INT NOT NULL,
  PRIMARY KEY (`Playlists_idPlaylists`, `Playlists_Users_idUsers`, `Songs_idSongs`, `Songs_Artists_idArtists`),
  INDEX `fk_Playlists_has_Songs_Songs1_idx` (`Songs_idSongs` ASC, `Songs_Artists_idArtists` ASC) VISIBLE,
  INDEX `fk_Playlists_has_Songs_Playlists1_idx` (`Playlists_idPlaylists` ASC, `Playlists_Users_idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_has_Songs_Playlists1`
    FOREIGN KEY (`Playlists_idPlaylists` , `Playlists_Users_idUsers`)
    REFERENCES `mydb`.`Playlists` (`idPlaylists` , `idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlists_has_Songs_Songs1`
    FOREIGN KEY (`Songs_idSongs`)
    REFERENCES `mydb`.`Songs` (`idSongs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Songs_has_Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Songs_has_Playlists` (
  `idSongs` INT NOT NULL,
  `idPlaylists` INT NOT NULL,
  PRIMARY KEY (`idSongs`, `idPlaylists`),
  INDEX `fk_Songs_has_Playlists_Playlists1_idx` (`idPlaylists` ASC) VISIBLE,
  INDEX `fk_Songs_has_Playlists_Songs1_idx` (`idSongs` ASC) VISIBLE,
  CONSTRAINT `fk_Songs_has_Playlists_Songs1`
    FOREIGN KEY (`idSongs`)
    REFERENCES `mydb`.`Songs` (`idSongs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Songs_has_Playlists_Playlists1`
    FOREIGN KEY (`idPlaylists`)
    REFERENCES `mydb`.`Playlists` (`idPlaylists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Songs_has_Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Songs_has_Artists` (
  `idSongs` INT NOT NULL,
  `idArtists` INT NOT NULL,
  PRIMARY KEY (`idSongs`, `idArtists`),
  INDEX `fk_Songs_has_Artists_Artists1_idx` (`idArtists` ASC) VISIBLE,
  INDEX `fk_Songs_has_Artists_Songs1_idx` (`idSongs` ASC) VISIBLE,
  CONSTRAINT `fk_Songs_has_Artists_Songs1`
    FOREIGN KEY (`idSongs`)
    REFERENCES `mydb`.`Songs` (`idSongs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Songs_has_Artists_Artists1`
    FOREIGN KEY (`idArtists`)
    REFERENCES `mydb`.`Artists` (`idArtists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `currency` VARCHAR(45) NULL,
  `amount` FLOAT NULL,
  `date` DATE NULL,
  `cycle` VARCHAR(45) NULL,
  `idUsers` INT NOT NULL,
  PRIMARY KEY (`idBill`, `idUsers`),
  INDEX `fk_Bill_Users1_idx` (`idUsers` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_Users1`
    FOREIGN KEY (`idUsers`)
    REFERENCES `mydb`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
