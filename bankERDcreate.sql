-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Bank
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Bank
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Bank` DEFAULT CHARACTER SET utf8 ;
USE `Bank` ;

-- -----------------------------------------------------
-- Table `Bank`.`bank_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bank`.`bank_customer` (
  `c_no` VARCHAR(14) NOT NULL,
  `c_name` VARCHAR(20) NOT NULL,
  `c_dist` TINYINT NOT NULL DEFAULT 0,
  `c_phone` CHAR(13) NOT NULL,
  `c_addr` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`c_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank`.`bank_account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bank`.`bank_account` (
  `a_no` CHAR(11) NOT NULL,
  `a_item_dist` CHAR(2) NOT NULL,
  `a_item_name` VARCHAR(20) NOT NULL,
  `a_c_no` VARCHAR(14) NOT NULL,
  `a_balance` INT NOT NULL DEFAULT 0,
  `a_open_date` DATE NOT NULL,
  PRIMARY KEY (`a_no`),
  INDEX `fk_bank_account_bank_customer_idx` (`a_c_no` ASC) VISIBLE,
  CONSTRAINT `fk_bank_account_bank_customer`
    FOREIGN KEY (`a_c_no`)
    REFERENCES `Bank`.`bank_customer` (`c_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank`.`bank_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bank`.`bank_transaction` (
  `t_no` INT NOT NULL AUTO_INCREMENT,
  `t_a_no` CHAR(11) NOT NULL,
  `t_dist` TINYINT NOT NULL,
  `t_amount` INT NOT NULL DEFAULT 0,
  `t_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`t_no`),
  INDEX `fk_bank_transaction_bank_account1_idx` (`t_a_no` ASC) VISIBLE,
  CONSTRAINT `fk_bank_transaction_bank_account1`
    FOREIGN KEY (`t_a_no`)
    REFERENCES `Bank`.`bank_account` (`a_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
