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
-- Table `mydb`.`DOCTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DOCTOR` (
  `idDOCTOR` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `adress` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `salary` VARCHAR(45) NULL,
  PRIMARY KEY (`idDOCTOR`),
  UNIQUE INDEX `idDOCTOR_UNIQUE` (`idDOCTOR` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEDICAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEDICAL` (
  `idMEDICAL` INT NOT NULL,
  `overtime_rate` VARCHAR(45) NULL,
  `idDOCTOR` INT NOT NULL,
  PRIMARY KEY (`idMEDICAL`),
  UNIQUE INDEX `idMEDICAL_UNIQUE` (`idMEDICAL` ASC) VISIBLE,
  INDEX `fk_MEDICAL_1_idx` (`idDOCTOR` ASC) VISIBLE,
  CONSTRAINT `fk_MEDICAL_1`
    FOREIGN KEY (`idDOCTOR`)
    REFERENCES `mydb`.`DOCTOR` (`idDOCTOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SPECIALIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SPECIALIST` (
  `idSPECIALIST` INT NOT NULL,
  `field_area` VARCHAR(45) NULL,
  `idDOCTOR` INT NOT NULL,
  PRIMARY KEY (`idSPECIALIST`),
  UNIQUE INDEX `idSPECIALIST_UNIQUE` (`idSPECIALIST` ASC) VISIBLE,
  INDEX `fk_SPECIALIST_1_idx` (`idDOCTOR` ASC) VISIBLE,
  CONSTRAINT `fk_SPECIALIST_1`
    FOREIGN KEY (`idDOCTOR`)
    REFERENCES `mydb`.`DOCTOR` (`idDOCTOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PATIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PATIENT` (
  `idPATIENT` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `adress` VARCHAR(45) NULL,
  `phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`idPATIENT`),
  UNIQUE INDEX `idPATIENT_UNIQUE` (`idPATIENT` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`APPOINTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`APPOINTMENT` (
  `idAPPOINTMENT` INT NOT NULL,
  `date` DATE NULL,
  `time` INT NULL,
  `idPATIENT` INT NOT NULL,
  `idDOCTOR` INT NOT NULL,
  PRIMARY KEY (`idAPPOINTMENT`),
  UNIQUE INDEX `idAPPOINTMENT_UNIQUE` (`idAPPOINTMENT` ASC) VISIBLE,
  INDEX `fk_APPOINTMENT_1_idx` (`idPATIENT` ASC) VISIBLE,
  INDEX `fk_APPOINTMENT_2_idx` (`idDOCTOR` ASC) VISIBLE,
  CONSTRAINT `fk_APPOINTMENT_1`
    FOREIGN KEY (`idPATIENT`)
    REFERENCES `mydb`.`PATIENT` (`idPATIENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_APPOINTMENT_2`
    FOREIGN KEY (`idDOCTOR`)
    REFERENCES `mydb`.`DOCTOR` (`idDOCTOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAYMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAYMENT` (
  `idPAYMENT` INT NOT NULL,
  `Details` VARCHAR(45) NULL,
  `method` VARCHAR(45) NULL,
  `idPATIENT` INT NOT NULL,
  PRIMARY KEY (`idPAYMENT`),
  UNIQUE INDEX `idPAYMENT_UNIQUE` (`idPAYMENT` ASC) VISIBLE,
  INDEX `fk_PAYMENT_1_idx` (`idPATIENT` ASC) VISIBLE,
  CONSTRAINT `fk_PAYMENT_1`
    FOREIGN KEY (`idPATIENT`)
    REFERENCES `mydb`.`PATIENT` (`idPATIENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BILL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BILL` (
  `idBILL` INT NOT NULL,
  `total` INT NULL,
  `idDOCTOR` INT NOT NULL,
  PRIMARY KEY (`idBILL`),
  UNIQUE INDEX `idBILL_UNIQUE` (`idBILL` ASC) VISIBLE,
  INDEX `fk_BILL_1_idx` (`idDOCTOR` ASC) VISIBLE,
  CONSTRAINT `fk_BILL_1`
    FOREIGN KEY (`idDOCTOR`)
    REFERENCES `mydb`.`DOCTOR` (`idDOCTOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAYMENTOFBILL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAYMENTOFBILL` (
  `idCROSSREF BILL/PAYMENT` INT NOT NULL,
  `idBILL` INT NOT NULL,
  `idPAYMENT` INT NOT NULL,
  PRIMARY KEY (`idCROSSREF BILL/PAYMENT`),
  UNIQUE INDEX `idCROSSREF BILL/PAYMENT_UNIQUE` (`idCROSSREF BILL/PAYMENT` ASC) VISIBLE,
  INDEX `fk_CROSSREF BILL/PAYMENT_1_idx` (`idBILL` ASC) VISIBLE,
  INDEX `fk_CROSSREF BILL/PAYMENT_2_idx` (`idPAYMENT` ASC) VISIBLE,
  CONSTRAINT `fk_CROSSREF BILL/PAYMENT_1`
    FOREIGN KEY (`idBILL`)
    REFERENCES `mydb`.`BILL` (`idBILL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CROSSREF BILL/PAYMENT_2`
    FOREIGN KEY (`idPAYMENT`)
    REFERENCES `mydb`.`PAYMENT` (`idPAYMENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
