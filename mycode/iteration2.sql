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
  `iduser` INT(11) NOT NULL,
  `frecuency` VARCHAR(45) NULL DEFAULT NULL,
  `birth_date` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Accounts` (
  `idaccounts` INT(11) NOT NULL,
  `type (free /no free)` VARCHAR(45) NULL DEFAULT NULL,
  `status invoice` VARCHAR(45) NULL DEFAULT NULL,
  `frecuency (paid)` VARCHAR(45) NULL DEFAULT NULL,
  `Users_iduser` INT(11) NOT NULL,
  `total_invoice` VARCHAR(45) NULL,
  PRIMARY KEY (`idaccounts`, `Users_iduser`),
  INDEX `fk_Accounts_Users_idx` (`Users_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_Accounts_Users`
    FOREIGN KEY (`Users_iduser`)
    REFERENCES `mydb`.`Users` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Albums` (
  `idAlbums` INT(11) NOT NULL,
  `genre` VARCHAR(45) NULL DEFAULT NULL,
  `artista` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAlbums`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Artistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Artistas` (
  `idArtistas` INT(11) NOT NULL,
  `genre` VARCHAR(45) NULL DEFAULT NULL,
  `album` VARCHAR(45) NULL DEFAULT NULL,
  `followers` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idArtistas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Playlists` (
  `idplaylist` INT(11) NOT NULL,
  `genre` VARCHAR(45) NULL DEFAULT NULL,
  `followers` VARCHAR(45) NULL DEFAULT NULL,
  `Users_iduser` INT(11) NOT NULL,
  PRIMARY KEY (`idplaylist`, `Users_iduser`),
  INDEX `fk_Playlists_Users1_idx` (`Users_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_Users1`
    FOREIGN KEY (`Users_iduser`)
    REFERENCES `mydb`.`Users` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Songs_play`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Songs_play` (
  `idsongs_play` INT(11) NOT NULL,
  `year` VARCHAR(45) NULL DEFAULT NULL,
  `artist` VARCHAR(45) NULL DEFAULT NULL,
  `album` VARCHAR(45) NULL DEFAULT NULL,
  `Playlists_idplaylist` INT(11) NOT NULL,
  `Artistas_idArtistas` INT(11) NOT NULL,
  PRIMARY KEY (`idsongs_play`, `Playlists_idplaylist`, `Artistas_idArtistas`),
  INDEX `fk_Songs_play_Playlists1_idx` (`Playlists_idplaylist` ASC) VISIBLE,
  INDEX `fk_Songs_play_Artistas1_idx` (`Artistas_idArtistas` ASC) VISIBLE,
  CONSTRAINT `fk_Songs_play_Playlists1`
    FOREIGN KEY (`Playlists_idplaylist`)
    REFERENCES `mydb`.`Playlists` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Songs_play_Artistas1`
    FOREIGN KEY (`Artistas_idArtistas`)
    REFERENCES `mydb`.`Artistas` (`idArtistas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Songs_play_has_Albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Songs_play_has_Albums` (
  `Songs_play_idsongs_play` INT(11) NOT NULL,
  `Albums_idAlbums` INT(11) NOT NULL,
  PRIMARY KEY (`Songs_play_idsongs_play`, `Albums_idAlbums`),
  INDEX `fk_Songs_play_has_Albums_Albums1_idx` (`Albums_idAlbums` ASC) VISIBLE,
  INDEX `fk_Songs_play_has_Albums_Songs_play1_idx` (`Songs_play_idsongs_play` ASC) VISIBLE,
  CONSTRAINT `fk_Songs_play_has_Albums_Songs_play1`
    FOREIGN KEY (`Songs_play_idsongs_play`)
    REFERENCES `mydb`.`Songs_play` (`idsongs_play`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Songs_play_has_Albums_Albums1`
    FOREIGN KEY (`Albums_idAlbums`)
    REFERENCES `mydb`.`Albums` (`idAlbums`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Users_has_Songs_play`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users_has_Songs_play` (
  `Users_iduser` INT(11) NOT NULL,
  `Songs_play_idsongs_play` INT(11) NOT NULL,
  PRIMARY KEY (`Users_iduser`, `Songs_play_idsongs_play`),
  INDEX `fk_Users_has_Songs_play_Songs_play1_idx` (`Songs_play_idsongs_play` ASC) VISIBLE,
  INDEX `fk_Users_has_Songs_play_Users1_idx` (`Users_iduser` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Songs_play_Users1`
    FOREIGN KEY (`Users_iduser`)
    REFERENCES `mydb`.`Users` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Songs_play_Songs_play1`
    FOREIGN KEY (`Songs_play_idsongs_play`)
    REFERENCES `mydb`.`Songs_play` (`idsongs_play`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
