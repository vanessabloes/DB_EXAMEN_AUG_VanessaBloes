-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Medische_genetica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Medische_genetica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Medische_genetica` DEFAULT CHARACTER SET utf8 ;
USE `Medische_genetica` ;

-- -----------------------------------------------------
-- Table `Medische_genetica`.`Mutaties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Medische_genetica`.`Mutaties` (
  `idMutaties` INT NOT NULL AUTO_INCREMENT,
  `Gen_naam` VARCHAR(45) NULL,
  `Startpositie` INT NULL,
  `Eindpositie` INT NULL,
  `Chromosoom` INT(2) NULL,
  `Beschrijving` VARCHAR(45) NULL,
  PRIMARY KEY (`idMutaties`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medische_genetica`.`Syndroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Medische_genetica`.`Syndroom` (
  `idSyndroom` INT NOT NULL,
  `Syndroom_naam` VARCHAR(45) NULL,
  `Syndroom_beschrijving` VARCHAR(45) NULL,
  PRIMARY KEY (`idSyndroom`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medische_genetica`.`Mutatie_in_syndroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Medische_genetica`.`Mutatie_in_syndroom` (
  `idMutatie_in_syndroom` INT NOT NULL,
  `Syndroom_idSyndroom` INT NOT NULL,
  `Mutaties_idMutaties` INT NOT NULL,
  PRIMARY KEY (`idMutatie_in_syndroom`, `Syndroom_idSyndroom`, `Mutaties_idMutaties`),
  INDEX `fk_Mutatie_in_syndroom_Syndroom_idx` (`Syndroom_idSyndroom` ASC),
  INDEX `fk_Mutatie_in_syndroom_Mutaties1_idx` (`Mutaties_idMutaties` ASC),
  CONSTRAINT `fk_Mutatie_in_syndroom_Syndroom`
    FOREIGN KEY (`Syndroom_idSyndroom`)
    REFERENCES `Medische_genetica`.`Syndroom` (`idSyndroom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutatie_in_syndroom_Mutaties1`
    FOREIGN KEY (`Mutaties_idMutaties`)
    REFERENCES `Medische_genetica`.`Mutaties` (`idMutaties`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Medische_genetica`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Medische_genetica`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `Patient_naam` VARCHAR(45) NOT NULL,
  `Patient_geslacht` ENUM('M', 'F') NULL,
  `Patient_geboortedatum` DATE NULL,
  `Syndroom_idSyndroom` INT NOT NULL,
  PRIMARY KEY (`idPatient`, `Syndroom_idSyndroom`),
  INDEX `fk_Patient_Syndroom1_idx` (`Syndroom_idSyndroom` ASC),
  CONSTRAINT `fk_Patient_Syndroom1`
    FOREIGN KEY (`Syndroom_idSyndroom`)
    REFERENCES `Medische_genetica`.`Syndroom` (`idSyndroom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
