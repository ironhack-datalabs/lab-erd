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
-- Table `mydb`.`Usuarios_Adic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios_Adic` (
  `Adic_ID` VARCHAR(16) NOT NULL,
  `Tipo de documento` VARCHAR(255) NULL,
  `Numero de documento` VARCHAR(32) NOT NULL,
  `Zona de residencia` VARCHAR(32) NULL DEFAULT CURRENT_TIMESTAMP,
  `Codigo postal` VARCHAR(45) NULL,
  `Estado civil` VARCHAR(45) NULL,
  `Cantidad de hijos` VARCHAR(45) NULL,
  PRIMARY KEY (`Adic_ID`));


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `User_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(32) NULL,
  `Apellido` VARCHAR(32) NULL,
  `Genero` VARCHAR(45) NULL,
  `Fecha nacimiento` DATE NULL DEFAULT CURRENT_TIMESTAMP,
  `Pais residencia` VARCHAR(45) NULL,
  `Usuarios_Adic_Adic_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`User_ID`, `Usuarios_Adic_Adic_ID`),
  INDEX `fk_Usuario_Usuarios_Adic1_idx` (`Usuarios_Adic_Adic_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Usuarios_Adic1`
    FOREIGN KEY (`Usuarios_Adic_Adic_ID`)
    REFERENCES `mydb`.`Usuarios_Adic` (`Adic_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Artistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Artistas` (
  `Artistas_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(255) NULL,
  `Apellido` VARCHAR(32) NOT NULL,
  `Nacionalidad` VARCHAR(32) NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha de nacimiento` DATE NULL,
  `Premios ganados` VARCHAR(45) NULL,
  PRIMARY KEY (`Artistas_ID`));


-- -----------------------------------------------------
-- Table `mydb`.`Albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Albums` (
  `Album_ID` VARCHAR(32) NOT NULL,
  `Nombre` VARCHAR(32) NOT NULL,
  `Fecha de lanzamiento` VARCHAR(45) NULL DEFAULT CURRENT_TIMESTAMP,
  `Numero de canciones` VARCHAR(45) NOT NULL,
  `Duracion` VARCHAR(45) NULL,
  `Artistas_Artistas_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Album_ID`, `Artistas_Artistas_ID`),
  INDEX `fk_Albums_Artistas1_idx` (`Artistas_Artistas_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Albums_Artistas1`
    FOREIGN KEY (`Artistas_Artistas_ID`)
    REFERENCES `mydb`.`Artistas` (`Artistas_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Canciones` (
  `Canciones_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(32) NULL,
  `Genero` VARCHAR(32) NOT NULL,
  `Duracion` VARCHAR(16) NULL DEFAULT CURRENT_TIMESTAMP,
  `Artistas_Artistas_ID` VARCHAR(16) NOT NULL,
  `Albums_Album_ID` VARCHAR(32) NOT NULL,
  `Albums_Artistas_Artistas_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Canciones_ID`, `Artistas_Artistas_ID`, `Albums_Album_ID`, `Albums_Artistas_Artistas_ID`),
  INDEX `fk_Canciones_Artistas1_idx` (`Artistas_Artistas_ID` ASC) VISIBLE,
  INDEX `fk_Canciones_Albums1_idx` (`Albums_Album_ID` ASC, `Albums_Artistas_Artistas_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Canciones_Artistas1`
    FOREIGN KEY (`Artistas_Artistas_ID`)
    REFERENCES `mydb`.`Artistas` (`Artistas_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canciones_Albums1`
    FOREIGN KEY (`Albums_Album_ID` , `Albums_Artistas_Artistas_ID`)
    REFERENCES `mydb`.`Albums` (`Album_ID` , `Artistas_Artistas_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_has_Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_has_Canciones` (
  `Usuario_ID` VARCHAR(16) NOT NULL,
  `Canciones_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Usuario_ID`, `Canciones_ID`),
  INDEX `fk_Usuario_has_Canciones_Canciones1_idx` (`Canciones_ID` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Canciones_Usuario_idx` (`Usuario_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Canciones_Usuario`
    FOREIGN KEY (`Usuario_ID`)
    REFERENCES `mydb`.`Usuario` (`User_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Canciones_Canciones1`
    FOREIGN KEY (`Canciones_ID`)
    REFERENCES `mydb`.`Canciones` (`Canciones_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Playlist` (
  `Playlist_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(255) NULL,
  `Genero` VARCHAR(32) NOT NULL,
  `Cantidad de canciones` VARCHAR(32) NULL DEFAULT CURRENT_TIMESTAMP,
  `Duracion` VARCHAR(45) NULL,
  PRIMARY KEY (`Playlist_ID`));


-- -----------------------------------------------------
-- Table `mydb`.`Canciones_has_Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Canciones_has_Playlist` (
  `Canciones_Canciones_ID` VARCHAR(16) NOT NULL,
  `Playlist_Playlist_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Canciones_Canciones_ID`, `Playlist_Playlist_ID`),
  INDEX `fk_Canciones_has_Playlist_Playlist1_idx` (`Playlist_Playlist_ID` ASC) VISIBLE,
  INDEX `fk_Canciones_has_Playlist_Canciones1_idx` (`Canciones_Canciones_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Canciones_has_Playlist_Canciones1`
    FOREIGN KEY (`Canciones_Canciones_ID`)
    REFERENCES `mydb`.`Canciones` (`Canciones_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canciones_has_Playlist_Playlist1`
    FOREIGN KEY (`Playlist_Playlist_ID`)
    REFERENCES `mydb`.`Playlist` (`Playlist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_has_Playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_has_Playlist` (
  `Usuario_User_ID` VARCHAR(16) NOT NULL,
  `Usuario_Usuarios_Adic_Adic_ID` VARCHAR(16) NOT NULL,
  `Playlist_Playlist_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Usuario_User_ID`, `Usuario_Usuarios_Adic_Adic_ID`, `Playlist_Playlist_ID`),
  INDEX `fk_Usuario_has_Playlist_Playlist1_idx` (`Playlist_Playlist_ID` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Playlist_Usuario1_idx` (`Usuario_User_ID` ASC, `Usuario_Usuarios_Adic_Adic_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Playlist_Usuario1`
    FOREIGN KEY (`Usuario_User_ID` , `Usuario_Usuarios_Adic_Adic_ID`)
    REFERENCES `mydb`.`Usuario` (`User_ID` , `Usuarios_Adic_Adic_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Playlist_Playlist1`
    FOREIGN KEY (`Playlist_Playlist_ID`)
    REFERENCES `mydb`.`Playlist` (`Playlist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Canciones_has_Playlist1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Canciones_has_Playlist1` (
  `Canciones_Canciones_ID` VARCHAR(16) NOT NULL,
  `Canciones_Artistas_Artistas_ID` VARCHAR(16) NOT NULL,
  `Playlist_Playlist_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Canciones_Canciones_ID`, `Canciones_Artistas_Artistas_ID`, `Playlist_Playlist_ID`),
  INDEX `fk_Canciones_has_Playlist1_Playlist1_idx` (`Playlist_Playlist_ID` ASC) VISIBLE,
  INDEX `fk_Canciones_has_Playlist1_Canciones1_idx` (`Canciones_Canciones_ID` ASC, `Canciones_Artistas_Artistas_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Canciones_has_Playlist1_Canciones1`
    FOREIGN KEY (`Canciones_Canciones_ID` , `Canciones_Artistas_Artistas_ID`)
    REFERENCES `mydb`.`Canciones` (`Canciones_ID` , `Artistas_Artistas_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Canciones_has_Playlist1_Playlist1`
    FOREIGN KEY (`Playlist_Playlist_ID`)
    REFERENCES `mydb`.`Playlist` (`Playlist_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Podcasts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Podcasts` (
  `Podcast_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(255) NULL,
  `Nombre narrador` VARCHAR(32) NOT NULL,
  `Descripcion` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `Genero` VARCHAR(45) NULL,
  PRIMARY KEY (`Podcast_ID`));


-- -----------------------------------------------------
-- Table `mydb`.`Episode_Podcast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Episode_Podcast` (
  `Episode_ID` VARCHAR(16) NOT NULL,
  `Nombre` VARCHAR(32) NULL,
  `Descripcion` VARCHAR(120) NOT NULL,
  `Duracion` VARCHAR(32) NULL DEFAULT CURRENT_TIMESTAMP,
  `# de episodio` VARCHAR(45) NULL,
  `Podcasts_Podcast_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Episode_ID`, `Podcasts_Podcast_ID`),
  INDEX `fk_Episode_Podcast_Podcasts1_idx` (`Podcasts_Podcast_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Episode_Podcast_Podcasts1`
    FOREIGN KEY (`Podcasts_Podcast_ID`)
    REFERENCES `mydb`.`Podcasts` (`Podcast_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Podcasts_has_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Podcasts_has_Usuario` (
  `Podcasts_Podcast_ID` VARCHAR(16) NOT NULL,
  `Usuario_User_ID` VARCHAR(16) NOT NULL,
  `Usuario_Usuarios_Adic_Adic_ID` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`Podcasts_Podcast_ID`, `Usuario_User_ID`, `Usuario_Usuarios_Adic_Adic_ID`),
  INDEX `fk_Podcasts_has_Usuario_Usuario1_idx` (`Usuario_User_ID` ASC, `Usuario_Usuarios_Adic_Adic_ID` ASC) VISIBLE,
  INDEX `fk_Podcasts_has_Usuario_Podcasts1_idx` (`Podcasts_Podcast_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Podcasts_has_Usuario_Podcasts1`
    FOREIGN KEY (`Podcasts_Podcast_ID`)
    REFERENCES `mydb`.`Podcasts` (`Podcast_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Podcasts_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_User_ID` , `Usuario_Usuarios_Adic_Adic_ID`)
    REFERENCES `mydb`.`Usuario` (`User_ID` , `Usuarios_Adic_Adic_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
