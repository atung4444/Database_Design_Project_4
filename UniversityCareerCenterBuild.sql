-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema universitycareercenter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema universitycareercenter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `universitycareercenter` DEFAULT CHARACTER SET utf8 ;
USE `universitycareercenter` ;

-- -----------------------------------------------------
-- Table `universitycareercenter`.`STUDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`STUDENT` (
  `StudentID` INT NOT NULL,
  `StudentFName` VARCHAR(20) NOT NULL,
  `StudentMName` VARCHAR(20) NOT NULL,
  `StudentLName` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(50) NOT NULL,
  `PermanentAddress` VARCHAR(50) NOT NULL,
  `GraduationDate` DATE NOT NULL,
  `AcademicStanding` VARCHAR(10) NOT NULL,
  `FinancialStanding` VARCHAR(10) NOT NULL,
  `CumulativeGPA` DOUBLE NOT NULL,
  PRIMARY KEY (`StudentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`COURSE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`COURSE` (
  `CourseName` VARCHAR(40) NOT NULL,
  `CourseQualification` VARCHAR(45) NOT NULL,
  `ProgramName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CourseName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`SECTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`SECTION` (
  `CourseSection` INT NOT NULL,
  `CourseName` VARCHAR(40) NOT NULL,
  `StudentID` INT NOT NULL,
  `Semester` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`CourseSection`, `CourseName`, `StudentID`),
  INDEX `fk_Section_Course1_idx` (`CourseName` ASC) VISIBLE,
  INDEX `fk_SECTION_STUDENT1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_Section_Course1`
    FOREIGN KEY (`CourseName`)
    REFERENCES `universitycareercenter`.`COURSE` (`CourseName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_SECTION_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`STUDENTMAJOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`STUDENTMAJOR` (
  `Major` VARCHAR(45) NOT NULL,
  `Degree` VARCHAR(45) NOT NULL,
  `StudentID` INT NOT NULL,
  PRIMARY KEY (`Major`, `StudentID`, `Degree`),
  INDEX `fk_STUDENTMAJOR_STUDENT1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENTMAJOR_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`STUDENTMINOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`STUDENTMINOR` (
  `Minor` VARCHAR(20) NOT NULL,
  `StudentID` INT NOT NULL,
  PRIMARY KEY (`Minor`, `StudentID`),
  INDEX `fk_STUDENTMINOR_STUDENT1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENTMINOR_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`STUDENTQUAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`STUDENTQUAL` (
  `StudentQualification` VARCHAR(45) NOT NULL,
  `StudentID` INT NOT NULL,
  `QualificationDate` DATE NOT NULL,
  PRIMARY KEY (`StudentQualification`, `StudentID`),
  INDEX `fk_STUDENTQUAL_STUDENT1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENTQUAL_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`COMPANY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`COMPANY` (
  `CompanyName` VARCHAR(45) NOT NULL,
  `CompanyState` VARCHAR(45) NOT NULL,
  `CompanyCity` VARCHAR(45) NOT NULL,
  `CompanyZipCode` VARCHAR(45) NOT NULL,
  `ComapanyAddress` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CompanyName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`STUDENTCONC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`STUDENTCONC` (
  `Concentration` VARCHAR(45) NOT NULL,
  `StudentID` INT NOT NULL,
  PRIMARY KEY (`Concentration`, `StudentID`),
  INDEX `fk_STUDENTCONC_STUDENT1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_STUDENTCONC_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`OPENING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`OPENING` (
  `OpeningNumber` INT NOT NULL,
  `OpeningName` VARCHAR(45) NOT NULL,
  `OpeningDescription` VARCHAR(45) NOT NULL,
  `OpeningDate` DATE NOT NULL,
  `TypeOfOpening` VARCHAR(45) NOT NULL,
  `OpeningQualification` VARCHAR(45) NOT NULL,
  `ClosingDate` DATE NOT NULL,
  `CompanyName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OpeningNumber`),
  INDEX `fk_OPENING_COMPANY1_idx` (`CompanyName` ASC) VISIBLE,
  CONSTRAINT `fk_OPENING_COMPANY1`
    FOREIGN KEY (`CompanyName`)
    REFERENCES `universitycareercenter`.`COMPANY` (`CompanyName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `universitycareercenter`.`PLACEMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `universitycareercenter`.`PLACEMENT` (
  `PlacementNumber` INT NOT NULL,
  `PlacementDate` DATE NOT NULL,
  `StartingSalary` DOUBLE NOT NULL,
  `BonusAmount` DOUBLE NOT NULL,
  `StudentID` INT NOT NULL,
  `OpeningNumber` INT NOT NULL,
  PRIMARY KEY (`StudentID`, `OpeningNumber`),
  INDEX `fk_PLACEMENT_OPENING1_idx` (`OpeningNumber` ASC) VISIBLE,
  CONSTRAINT `fk_PLACEMENT_STUDENT1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `universitycareercenter`.`STUDENT` (`StudentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PLACEMENT_OPENING1`
    FOREIGN KEY (`OpeningNumber`)
    REFERENCES `universitycareercenter`.`OPENING` (`OpeningNumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
