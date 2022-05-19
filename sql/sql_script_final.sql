-- MySQL Workbench Synchronization
-- Generated: 2022-05-11 20:47
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Admin

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `busin_main` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `busin_main`.`Company` (
  `company_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE INDEX `idCompany_UNIQUE` (`company_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`Department` (
  `department_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `company_id` INT(11) NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `company_id_idx` (`company_id` ASC) VISIBLE,
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC) VISIBLE,
  CONSTRAINT `company_id`
    FOREIGN KEY (`company_id`)
    REFERENCES `busin_main`.`Company` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`User` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `surname` VARCHAR(30) NOT NULL,
  `position` VARCHAR(30) NOT NULL,
  `e-mail` VARCHAR(320) NULL DEFAULT NULL,
  `password` VARCHAR(225) NULL DEFAULT NULL,
  `profile_picture` LONGBLOB NULL DEFAULT NULL,
  `department_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `busin_main`.`Department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`Announcement` (
  `announcement_id` INT(11) NOT NULL AUTO_INCREMENT,
  `announcement_body` VARCHAR(300) NOT NULL,
  `sender_id` INT(11) NOT NULL,
  PRIMARY KEY (`announcement_id`),
  UNIQUE INDEX `announcement_id_UNIQUE` (`announcement_id` ASC) VISIBLE,
  INDEX `sender_id_idx` (`sender_id` ASC) VISIBLE,
  CONSTRAINT `sender_id`
    FOREIGN KEY (`sender_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`AnnouncementReceiver` (
  `announcement_id` INT(11) NOT NULL AUTO_INCREMENT,
  `receiver_id` INT(11) NOT NULL,
  `time_saw` TIMESTAMP NOT NULL,
  `has_seen` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`announcement_id`, `receiver_id`),
  INDEX `receiver_id_idx` (`receiver_id` ASC) VISIBLE,
  CONSTRAINT `receiver_id`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `announcement_id`
    FOREIGN KEY (`announcement_id`)
    REFERENCES `busin_main`.`Announcement` (`announcement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`Message` (
  `message_id` INT(11) NOT NULL AUTO_INCREMENT,
  `sender_id` INT(11) NOT NULL,
  `receiver_⁯id` INT(11) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message_body` VARCHAR(200) NOT NULL,
  `parent_message_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`),
  UNIQUE INDEX `message_id_UNIQUE` (`message_id` ASC) VISIBLE,
  INDEX `sender_id_idx` (`sender_id` ASC) VISIBLE,
  INDEX `receiver_id_idx` (`receiver_⁯id` ASC) VISIBLE,
  INDEX `parent_id_idx` (`parent_message_id` ASC) VISIBLE,
  CONSTRAINT `sender_id`
    FOREIGN KEY (`sender_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `receiver_id`
    FOREIGN KEY (`receiver_⁯id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `parent_id`
    FOREIGN KEY (`parent_message_id`)
    REFERENCES `busin_main`.`Message` (`message_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`Group` (
  `group_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `group_creation_date` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`),
  UNIQUE INDEX `group_id_UNIQUE` (`group_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`GroupParticipant` (
  `group_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`group_id`, `user_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `busin_main`.`Group` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`GroupMessage` (
  `group_message_id` INT(11) NOT NULL AUTO_INCREMENT,
  `sender_id` INT(11) NOT NULL,
  `group_id` INT(11) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message_body` VARCHAR(300) NOT NULL,
  `parent_message_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`group_message_id`),
  UNIQUE INDEX `chat_message_id_UNIQUE` (`group_message_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`sender_id` ASC) VISIBLE,
  INDEX `group_id_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`sender_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `group_id`
    FOREIGN KEY (`group_id`)
    REFERENCES `busin_main`.`Group` (`group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `parent_message`
    FOREIGN KEY (`group_message_id`)
    REFERENCES `busin_main`.`GroupMessage` (`group_message_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `busin_main`.`Schedule` (
  `schedule_id` INT(11) NOT NULL AUTO_INCREMENT,
  `work_date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`schedule_id`),
  UNIQUE INDEX `schedule_id_UNIQUE` (`schedule_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `busin_main`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
