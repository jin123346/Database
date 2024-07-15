-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ShopERD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ShopERD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ShopERD` DEFAULT CHARACTER SET utf8 ;
USE `ShopERD` ;

-- -----------------------------------------------------
-- Table `ShopERD`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ShopERD`.`Customer` (
  `custId` VARCHAR(10) NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  `hp` VARCHAR(13) NULL DEFAULT NULL,
  `addr` VARCHAR(100) NULL DEFAULT NULL,
  `redate` DATE NOT NULL,
  PRIMARY KEY (`custId`),
  UNIQUE INDEX `hp_UNIQUE` (`hp` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ShopERD`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ShopERD`.`Product` (
  `prodNo` INT NOT NULL,
  `prodName` VARCHAR(10) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `price` INT NULL DEFAULT NULL,
  `company` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`prodNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ShopERD`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ShopERD`.`order` (
  `orderNo` INT NOT NULL AUTO_INCREMENT,
  `orderId` VARCHAR(10) NOT NULL,
  `orderProduct` INT NOT NULL,
  `orderCount` INT NOT NULL DEFAULT 1,
  `orderDate` DATETIME NOT NULL,
  PRIMARY KEY (`orderNo`),
  INDEX `fk_order_Customer1_idx` (`orderId` ASC) VISIBLE,
  INDEX `fk_order_Product1_idx` (`orderProduct` ASC) VISIBLE,
  CONSTRAINT `fk_order_Customer1`
    FOREIGN KEY (`orderId`)
    REFERENCES `ShopERD`.`Customer` (`custId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_Product1`
    FOREIGN KEY (`orderProduct`)
    REFERENCES `ShopERD`.`Product` (`prodNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
