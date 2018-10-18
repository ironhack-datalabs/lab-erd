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
-- Table `mydb`.`Campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Campus` (
  `Id` INT NOT NULL,
  `City` VARCHAR(45) NULL,
  `CampusName` VARCHAR(45) NULL,
  `Capacidad` VARCHAR(45) NULL,
  `Cursos enseñados` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courses` (
  `id` INT NOT NULL,
  `CourseName` VARCHAR(45) NOT NULL,
  `FirstStarted` DATE NOT NULL,
  `Coursescol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'No introducimos fecha en que empezaron a darse. Meteremos las fechas de inicio por campus. \nAsí luego lo podemos ver al ver la fecha en que empiezan a darse en un campus. ';


-- -----------------------------------------------------
-- Table `mydb`.`Ats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ats` (
  `id` INT NOT NULL,
  `AtName` VARCHAR(45) NULL,
  `Salary` INT NULL,
  `ProfessionalLevel` VARCHAR(45) NULL,
  `SocialNetworksProfile_Id` INT NOT NULL,
  `SocialNetworksProfile_Leading teachers_id` INT NOT NULL,
  `SocialNetworksProfile_ATs_id` INT NOT NULL,
  PRIMARY KEY (`id`, `SocialNetworksProfile_Id`, `SocialNetworksProfile_Leading teachers_id`, `SocialNetworksProfile_ATs_id`),
  INDEX `fk_Ats_SocialNetworksProfile1_idx` (`SocialNetworksProfile_Id` ASC, `SocialNetworksProfile_Leading teachers_id` ASC, `SocialNetworksProfile_ATs_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ats_SocialNetworksProfile1`
    FOREIGN KEY (`SocialNetworksProfile_Id` , `SocialNetworksProfile_Leading teachers_id` , `SocialNetworksProfile_ATs_id`)
    REFERENCES `mydb`.`SocialNetworksProfile` (`Id` , `Leading teachers_id` , `ATs_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Courses_has_Campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courses_has_Campus` (
  `Courses_id` INT NOT NULL,
  `Campus_Id` INT NOT NULL,
  `Ats_id` INT NOT NULL,
  PRIMARY KEY (`Courses_id`, `Campus_Id`),
  INDEX `fk_Courses_has_Campus_Campus1_idx` (`Campus_Id` ASC) VISIBLE,
  INDEX `fk_Courses_has_Campus_Courses1_idx` (`Courses_id` ASC) VISIBLE,
  INDEX `fk_Courses_has_Campus_Ats1_idx` (`Ats_id` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_has_Campus_Courses1`
    FOREIGN KEY (`Courses_id`)
    REFERENCES `mydb`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_has_Campus_Campus1`
    FOREIGN KEY (`Campus_Id`)
    REFERENCES `mydb`.`Campus` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_has_Campus_Ats1`
    FOREIGN KEY (`Ats_id`)
    REFERENCES `mydb`.`Ats` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LeadingTeachers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LeadingTeachers` (
  `id` INT NOT NULL,
  `TeacherName` VARCHAR(45) NULL,
  `Salary` INT NULL,
  `ProfessionalLevel` VARCHAR(55) NULL,
  `Courses_has_Campus_Courses_id` INT NOT NULL,
  `Courses_has_Campus_Campus_Id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Leading teachers_Courses_has_Campus1_idx` (`Courses_has_Campus_Courses_id` ASC, `Courses_has_Campus_Campus_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Leading teachers_Courses_has_Campus1`
    FOREIGN KEY (`Courses_has_Campus_Courses_id` , `Courses_has_Campus_Campus_Id`)
    REFERENCES `mydb`.`Courses_has_Campus` (`Courses_id` , `Campus_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SocialNetworksProfile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SocialNetworksProfile` (
  `Id` INT NOT NULL,
  `Linkedin` VARCHAR(45) BINARY NULL,
  `GitHub` VARCHAR(45) BINARY NULL,
  `Slack` VARCHAR(45) BINARY NULL,
  `Kaggle` VARCHAR(45) BINARY NULL,
  `CodeWars` VARCHAR(45) BINARY NULL,
  `Leading teachers_id` INT NOT NULL,
  `ATs_id` INT NOT NULL,
  PRIMARY KEY (`Id`, `Leading teachers_id`, `ATs_id`),
  INDEX `fk_SocialNetworksProfile_Leading teachers1_idx` (`Leading teachers_id` ASC) VISIBLE,
  CONSTRAINT `fk_SocialNetworksProfile_Leading teachers1`
    FOREIGN KEY (`Leading teachers_id`)
    REFERENCES `mydb`.`LeadingTeachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `id` INT(10) NOT NULL,
  `Name` VARCHAR(32) NOT NULL,
  `LastName(s)` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(16) NOT NULL,
  `Address` VARCHAR(255) NULL,
  `BirthDate` DATE NULL,
  `Phone` INT(9) NULL,
  `GraduateStatus` VARCHAR(45) NULL,
  `Campus_Id` INT NOT NULL,
  `UserProfile_Id` INT NOT NULL,
  PRIMARY KEY (`id`, `UserProfile_Id`),
  INDEX `fk_User_Campus1_idx` (`Campus_Id` ASC) VISIBLE,
  INDEX `fk_User_UserProfile1_idx` (`UserProfile_Id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Campus1`
    FOREIGN KEY (`Campus_Id`)
    REFERENCES `mydb`.`Campus` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_UserProfile1`
    FOREIGN KEY (`UserProfile_Id`)
    REFERENCES `mydb`.`SocialNetworksProfile` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`MngmStaff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MngmStaff` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `LastName(s)` VARCHAR(45) NULL,
  `IdRole` VARCHAR(45) NULL,
  `Campus_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_EdStaff_Campus1_idx` (`Campus_Id` ASC) VISIBLE,
  CONSTRAINT `fk_EdStaff_Campus1`
    FOREIGN KEY (`Campus_Id`)
    REFERENCES `mydb`.`Campus` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Education Staff';


-- -----------------------------------------------------
-- Table `mydb`.`GradStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`GradStatus` (
  `id` INT NOT NULL,
  `Accepted` VARCHAR(45) NULL,
  `Studying` VARCHAR(45) NULL,
  `Alumni` VARCHAR(45) NULL,
  `User_id` INT(10) NOT NULL,
  PRIMARY KEY (`id`, `User_id`),
  INDEX `fk_GradStatus_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_GradStatus_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MngmStaffRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MngmStaffRoles` (
  `Id` INT NOT NULL,
  `RolName` VARCHAR(45) NULL,
  `DecisionLevel` INT(10) NULL,
  `StandardSalary` VARCHAR(45) NULL,
  `EdStaff_Id` INT NOT NULL,
  PRIMARY KEY (`Id`, `EdStaff_Id`),
  INDEX `fk_StaffRoles_EdStaff1_idx` (`EdStaff_Id` ASC) VISIBLE,
  CONSTRAINT `fk_StaffRoles_EdStaff1`
    FOREIGN KEY (`EdStaff_Id`)
    REFERENCES `mydb`.`MngmStaff` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Managemente Staff Roles';


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Courses` (
  `User_id` INT(10) NOT NULL,
  `Courses_id` INT NOT NULL,
  PRIMARY KEY (`User_id`, `Courses_id`),
  INDEX `fk_User_has_Courses_Courses1_idx` (`Courses_id` ASC) VISIBLE,
  INDEX `fk_User_has_Courses_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_has_Courses_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `mydb`.`Users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Courses_Courses1`
    FOREIGN KEY (`Courses_id`)
    REFERENCES `mydb`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoice` (
  `id` INT NOT NULL,
  `InvoiceDateIssued` DATE NULL,
  `DateOfPayment` DATE NULL,
  `Amount` INT NULL,
  `Users_id` INT(10) NOT NULL,
  `Users_UserProfile_Id` INT NOT NULL,
  `Courses_id` INT NOT NULL,
  `Courses_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Invoice_Users1_idx` (`Users_id` ASC, `Users_UserProfile_Id` ASC) VISIBLE,
  INDEX `fk_Invoice_Courses1_idx` (`Courses_id` ASC) VISIBLE,
  INDEX `fk_Invoice_Courses2_idx` (`Courses_id1` ASC) VISIBLE,
  CONSTRAINT `fk_Invoice_Users1`
    FOREIGN KEY (`Users_id` , `Users_UserProfile_Id`)
    REFERENCES `mydb`.`Users` (`id` , `UserProfile_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_Courses1`
    FOREIGN KEY (`Courses_id`)
    REFERENCES `mydb`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_Courses2`
    FOREIGN KEY (`Courses_id1`)
    REFERENCES `mydb`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
