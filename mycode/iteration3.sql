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
-- Table `mydb`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumno` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `nacimiento` DATE NULL,
  `correo` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `linkedin` VARCHAR(45) NULL,
  `dni` INT NULL,
  `cuenta_bancaria` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cursos` (
  `id` INT NOT NULL,
  `fecha` DATE NULL,
  `alumnos` INT NULL,
  `tema` VARCHAR(45) NULL,
  `temas_id` INT NOT NULL,
  PRIMARY KEY (`id`, `temas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`campus` (
  `id` INT NOT NULL,
  `ciudad` VARCHAR(45) NULL,
  `lat` DECIMAL(10,8) NULL,
  `lng` DECIMAL(11,8) NULL,
  `trabajadores` VARCHAR(45) NULL,
  `cursos_id` INT NOT NULL,
  `cursos_temas_id` INT NOT NULL,
  PRIMARY KEY (`id`, `cursos_id`, `cursos_temas_id`),
  INDEX `fk_campus_cursos1_idx` (`cursos_id` ASC, `cursos_temas_id` ASC) VISIBLE,
  CONSTRAINT `fk_campus_cursos1`
    FOREIGN KEY (`cursos_id` , `cursos_temas_id`)
    REFERENCES `mydb`.`cursos` (`id` , `temas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`leads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`leads` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `correo` VARCHAR(45) NULL,
  `alumno_id` INT NOT NULL,
  PRIMARY KEY (`id`, `alumno_id`),
  INDEX `fk_leads_alumno_idx` (`alumno_id` ASC) VISIBLE,
  CONSTRAINT `fk_leads_alumno`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profesores` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `nacimiento` DATE NULL,
  `localidad` INT NULL,
  `sector` VARCHAR(45) NULL,
  `experiencia` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `ponente` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `lat` DECIMAL(10,8) NULL,
  `lng` DECIMAL(11,8) NULL,
  `campus_id` INT NOT NULL,
  PRIMARY KEY (`id`, `campus_id`),
  INDEX `fk_eventos_campus1_idx` (`campus_id` ASC) VISIBLE,
  CONSTRAINT `fk_eventos_campus1`
    FOREIGN KEY (`campus_id`)
    REFERENCES `mydb`.`campus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`empresas` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NULL,
  `trabajadores` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`leads_has_eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`leads_has_eventos` (
  `leads_id` INT NOT NULL,
  `leads_alumno_id` INT NOT NULL,
  `eventos_id` INT NOT NULL,
  PRIMARY KEY (`leads_id`, `leads_alumno_id`, `eventos_id`),
  INDEX `fk_leads_has_eventos_eventos1_idx` (`eventos_id` ASC) VISIBLE,
  INDEX `fk_leads_has_eventos_leads1_idx` (`leads_id` ASC, `leads_alumno_id` ASC) VISIBLE,
  CONSTRAINT `fk_leads_has_eventos_leads1`
    FOREIGN KEY (`leads_id` , `leads_alumno_id`)
    REFERENCES `mydb`.`leads` (`id` , `alumno_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_leads_has_eventos_eventos1`
    FOREIGN KEY (`eventos_id`)
    REFERENCES `mydb`.`eventos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alumno_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumno_has_cursos` (
  `alumno_id` INT NOT NULL,
  `cursos_id` INT NOT NULL,
  `cursos_temas_id` INT NOT NULL,
  PRIMARY KEY (`alumno_id`, `cursos_id`, `cursos_temas_id`),
  INDEX `fk_alumno_has_cursos_cursos1_idx` (`cursos_id` ASC, `cursos_temas_id` ASC) VISIBLE,
  INDEX `fk_alumno_has_cursos_alumno1_idx` (`alumno_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_has_cursos_alumno1`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`alumno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id` , `cursos_temas_id`)
    REFERENCES `mydb`.`cursos` (`id` , `temas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cursos_has_profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cursos_has_profesores` (
  `cursos_id` INT NOT NULL,
  `cursos_temas_id` INT NOT NULL,
  `profesores_id` INT NOT NULL,
  PRIMARY KEY (`cursos_id`, `cursos_temas_id`, `profesores_id`),
  INDEX `fk_cursos_has_profesores_profesores1_idx` (`profesores_id` ASC) VISIBLE,
  INDEX `fk_cursos_has_profesores_cursos1_idx` (`cursos_id` ASC, `cursos_temas_id` ASC) VISIBLE,
  CONSTRAINT `fk_cursos_has_profesores_cursos1`
    FOREIGN KEY (`cursos_id` , `cursos_temas_id`)
    REFERENCES `mydb`.`cursos` (`id` , `temas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cursos_has_profesores_profesores1`
    FOREIGN KEY (`profesores_id`)
    REFERENCES `mydb`.`profesores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`campus_has_empresas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`campus_has_empresas` (
  `campus_id` INT NOT NULL,
  `campus_cursos_id` INT NOT NULL,
  `campus_cursos_temas_id` INT NOT NULL,
  `empresas_id` INT NOT NULL,
  PRIMARY KEY (`campus_id`, `campus_cursos_id`, `campus_cursos_temas_id`, `empresas_id`),
  INDEX `fk_campus_has_empresas_empresas1_idx` (`empresas_id` ASC) VISIBLE,
  INDEX `fk_campus_has_empresas_campus1_idx` (`campus_id` ASC, `campus_cursos_id` ASC, `campus_cursos_temas_id` ASC) VISIBLE,
  CONSTRAINT `fk_campus_has_empresas_campus1`
    FOREIGN KEY (`campus_id` , `campus_cursos_id` , `campus_cursos_temas_id`)
    REFERENCES `mydb`.`campus` (`id` , `cursos_id` , `cursos_temas_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campus_has_empresas_empresas1`
    FOREIGN KEY (`empresas_id`)
    REFERENCES `mydb`.`empresas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
