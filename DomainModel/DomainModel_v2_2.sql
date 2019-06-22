-- MySQL Script generated by MySQL Workbench
-- Fri Jun 21 17:45:23 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ZXQ
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ZXQ
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ZXQ` DEFAULT CHARACTER SET utf8 ;
USE `ZXQ` ;

-- -----------------------------------------------------
-- Table `ZXQ`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `weichat_id` VARCHAR(45) NOT NULL,
  `nickname` VARCHAR(16) NOT NULL,
  `phone_number` VARCHAR(11) NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `photo` VARCHAR(45) NOT NULL,
  `isprove` VARCHAR(1) NULL DEFAULT '0',
  `identity` VARCHAR(1) NULL DEFAULT '0',
  `intro` VARCHAR(255) NULL DEFAULT '\"\"',
  `create_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`));


-- -----------------------------------------------------
-- Table `ZXQ`.`stu_identity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`stu_identity` (
  `user_stu_id` INT NOT NULL AUTO_INCREMENT,
  `school` VARCHAR(32) NOT NULL,
  `college` VARCHAR(16) NOT NULL,
  `student_num` INT(10) NOT NULL,
  `prove` VARCHAR(45) NOT NULL,
  `gender` BIT NOT NULL,
  `state_prove` VARCHAR(1) NOT NULL DEFAULT '0',
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`user_stu_id`, `user_user_id`),
  INDEX `fk_stu_identity_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_stu_identity_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ZXQ`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`organization` (
  `org_name` VARCHAR(16) NOT NULL,
  `introduction` VARCHAR(255) NOT NULL,
  `founder_name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`org_name`, `founder_name`));


-- -----------------------------------------------------
-- Table `ZXQ`.`organization_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`organization_has_user` (
  `organization_org_name` VARCHAR(16) NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`organization_org_name`, `user_user_id`),
  INDEX `fk_organization_has_user_user1_idx` (`user_user_id` ASC) ,
  INDEX `fk_organization_has_user_organization_idx` (`organization_org_name` ASC) ,
  CONSTRAINT `fk_organization_has_user_organization`
    FOREIGN KEY (`organization_org_name`)
    REFERENCES `ZXQ`.`organization` (`org_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_organization_has_user_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ZXQ`.`founder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`founder` (
  `founder_id` INT NOT NULL AUTO_INCREMENT,
  `organization_org_name` VARCHAR(16) NOT NULL,
  `organization_founder_name` VARCHAR(16) NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`founder_id`, `organization_org_name`, `organization_founder_name`, `user_user_id`),
  INDEX `fk_founder_organization1_idx` (`organization_org_name` ASC, `organization_founder_name` ASC) ,
  INDEX `fk_founder_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_founder_organization1`
    FOREIGN KEY (`organization_org_name` , `organization_founder_name`)
    REFERENCES `ZXQ`.`organization` (`org_name` , `founder_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_founder_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ZXQ`.`com_identity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`com_identity` (
  `user_job_id` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(32) NOT NULL,
  `job_num` VARCHAR(10) NOT NULL,
  `prove` VARCHAR(45) NOT NULL,
  `state_prove` VARCHAR(1) NOT NULL DEFAULT '0',
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`user_job_id`, `user_user_id`),
  INDEX `fk_job_identity_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_job_identity_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ZXQ`.`audit_administrator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`audit_administrator` (
  `audit_id` INT NOT NULL,
  `name` VARCHAR(16) NOT NULL,
  `account` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`audit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZXQ`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`task` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(20) NOT NULL,
  `type` VARCHAR(1) NOT NULL,
  `task_intro` VARCHAR(225) NOT NULL,
  `participants_num` INT NULL,
  `release_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sign_start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sign_end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `task_start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `task_end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_administrator_audit_id` INT NOT NULL,
  PRIMARY KEY (`task_id`, `audit_administrator_audit_id`),
  INDEX `fk_task_audit_administrator1_idx` (`audit_administrator_audit_id` ASC) ,
  CONSTRAINT `fk_task_audit_administrator1`
    FOREIGN KEY (`audit_administrator_audit_id`)
    REFERENCES `ZXQ`.`audit_administrator` (`audit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `ZXQ`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`publisher` (
  `publisher_id` INT NOT NULL AUTO_INCREMENT,
  `user_user_id` INT NOT NULL,
  `task_task_id` INT NOT NULL,
  PRIMARY KEY (`publisher_id`, `user_user_id`, `task_task_id`),
  INDEX `fk_publisher_user1_idx` (`user_user_id` ASC) ,
  INDEX `fk_publisher_task1_idx` (`task_task_id` ASC) ,
  CONSTRAINT `fk_publisher_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publisher_task1`
    FOREIGN KEY (`task_task_id`)
    REFERENCES `ZXQ`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ZXQ`.`user_has_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZXQ`.`user_has_task` (
  `user_user_id` INT NOT NULL,
  `task_task_id` INT NOT NULL,
  `task_audit_administrator_audit_id` INT NOT NULL,
  PRIMARY KEY (`user_user_id`, `task_task_id`, `task_audit_administrator_audit_id`),
  INDEX `fk_user_has_task_task1_idx` (`task_task_id` ASC, `task_audit_administrator_audit_id` ASC) ,
  INDEX `fk_user_has_task_user1_idx` (`user_user_id` ASC) ,
  CONSTRAINT `fk_user_has_task_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ZXQ`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_task_task1`
    FOREIGN KEY (`task_task_id` , `task_audit_administrator_audit_id`)
    REFERENCES `ZXQ`.`task` (`task_id` , `audit_administrator_audit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
