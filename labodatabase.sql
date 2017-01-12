-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`All_trainings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`All_trainings` (
  `ID` INT NOT NULL,
  `Subject` VARCHAR(45) NULL,
  `Duration` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Members` (
  `member_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Lastname` VARCHAR(45) NULL,
  `Birth_date` DATE NULL,
  `training` VARCHAR(45) NULL,
  PRIMARY KEY (`member_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipment` (
  `equipmentID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Manufacturer` VARCHAR(45) NULL,
  `purchase_date` DATE NULL,
  PRIMARY KEY (`equipmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Experiments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Experiments` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `performed_by` INT NULL,
  `equipment_used` INT NULL,
  `date` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_performed_by_idx` (`performed_by` ASC),
  INDEX `fk_equipment_used_idx` (`equipment_used` ASC),
  CONSTRAINT `fk_performed_by`
    FOREIGN KEY (`performed_by`)
    REFERENCES `mydb`.`Members` (`member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipment_used`
    FOREIGN KEY (`equipment_used`)
    REFERENCES `mydb`.`Equipment` (`equipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`members_in_training`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`members_in_training` (
  `ID` INT NOT NULL,
  `member_ID` INT NULL,
  `training_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_member_ID_idx` (`member_ID` ASC),
  INDEX `fk_training_ID_idx` (`training_ID` ASC),
  CONSTRAINT `fk_member_ID`
    FOREIGN KEY (`member_ID`)
    REFERENCES `mydb`.`Members` (`member_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_training_ID`
    FOREIGN KEY (`training_ID`)
    REFERENCES `mydb`.`All_trainings` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Results` (
  `ID` INT NOT NULL,
  `Directory` VARCHAR(45) NULL,
  `Experiment` INT NULL,
  `status` ENUM('FAILED', 'PROGRESS', 'COMPLETED') NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Experiment_idx` (`Experiment` ASC),
  CONSTRAINT `fk_Experiment`
    FOREIGN KEY (`Experiment`)
    REFERENCES `mydb`.`Experiments` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
