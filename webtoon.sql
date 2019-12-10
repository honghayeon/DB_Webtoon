-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema webtoon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema webtoon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `webtoon` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `webtoon` ;

-- -----------------------------------------------------
-- Table `webtoon`.`reader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`reader` (
  `readerid` INT(11) NOT NULL AUTO_INCREMENT,
  `age` INT(11) NULL DEFAULT NULL,
  `gender` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`readerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`writer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`writer` (
  `writerid` INT(11) NOT NULL AUTO_INCREMENT,
  `nick` VARCHAR(45) NOT NULL,
  `writername` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`writerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`webtoon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`webtoon` (
  `wtoonid` INT(11) NOT NULL,
  `wtoonname` VARCHAR(45) NOT NULL,
  `we_writerid` INT(11) NOT NULL,
  `1st_date` DATE NOT NULL,
  `compl` TINYINT(4) NULL DEFAULT 0,
  PRIMARY KEY (`wtoonid`),
  INDEX `fk_webtoon_writer1_idx` (`we_writerid` ASC) VISIBLE,
  CONSTRAINT `fk_webtoon_writer1`
    FOREIGN KEY (`we_writerid`)
    REFERENCES `webtoon`.`writer` (`writerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`buy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`buy` (
  `buyid` INT(11) NOT NULL AUTO_INCREMENT,
  `b_readerid` INT(11) NOT NULL,
  `b_wtoonid` INT(11) NOT NULL,
  `price` INT(11) NOT NULL,
  PRIMARY KEY (`buyid`, `b_readerid`, `b_wtoonid`),
  INDEX `fk_webtoon_has_reader_reader1_idx` (`b_readerid` ASC) VISIBLE,
  INDEX `fk_webtoon_has_reader_webtoon1_idx` (`b_wtoonid` ASC) VISIBLE,
  CONSTRAINT `fk_webtoon_has_reader_reader1`
    FOREIGN KEY (`b_readerid`)
    REFERENCES `webtoon`.`reader` (`readerid`),
  CONSTRAINT `fk_webtoon_has_reader_webtoon1`
    FOREIGN KEY (`b_wtoonid`)
    REFERENCES `webtoon`.`webtoon` (`wtoonid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`challenge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`challenge` (
  `chalid` INT(11) NOT NULL AUTO_INCREMENT,
  `chalname` VARCHAR(45) NOT NULL,
  `ch_writerid` INT(11) NOT NULL,
  PRIMARY KEY (`chalid`),
  INDEX `fk_challenge_writer1_idx` (`ch_writerid` ASC) VISIBLE,
  CONSTRAINT `fk_challenge_writer1`
    FOREIGN KEY (`ch_writerid`)
    REFERENCES `webtoon`.`writer` (`writerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`comment` (
  `cmntid` INT(11) NOT NULL AUTO_INCREMENT,
  `co_wtoonid` INT(11) NULL DEFAULT NULL,
  `co_chalid` INT(11) NULL DEFAULT NULL,
  `co_readerid` INT(11) NOT NULL,
  `good` INT(11) NULL DEFAULT '0',
  `bad` INT(11) NULL DEFAULT '0',
  `best` TINYINT(4) NULL DEFAULT '0',
  PRIMARY KEY (`cmntid`),
  INDEX `fk_comment_webtoon1_idx` (`co_wtoonid` ASC) VISIBLE,
  INDEX `fk_comment_challenge1_idx` (`co_chalid` ASC) VISIBLE,
  INDEX `fk_comment_reader1_idx` (`co_readerid` ASC) VISIBLE,
  CONSTRAINT `fk_comment_challenge1`
    FOREIGN KEY (`co_chalid`)
    REFERENCES `webtoon`.`challenge` (`chalid`),
  CONSTRAINT `fk_comment_reader1`
    FOREIGN KEY (`co_readerid`)
    REFERENCES `webtoon`.`reader` (`readerid`),
  CONSTRAINT `fk_comment_webtoon1`
    FOREIGN KEY (`co_wtoonid`)
    REFERENCES `webtoon`.`webtoon` (`wtoonid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`login` (
  `l_writerid` INT(11) NOT NULL,
  `id` VARCHAR(45) NOT NULL,
  `pwd` VARCHAR(45) NOT NULL,
  INDEX `fk_login_writer1_idx` (`l_writerid` ASC) VISIBLE,
  PRIMARY KEY (`l_writerid`),
  CONSTRAINT `fk_login_writer1`
    FOREIGN KEY (`l_writerid`)
    REFERENCES `webtoon`.`writer` (`writerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `webtoon`.`manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webtoon`.`manager` (
  `mngrid` INT(11) NOT NULL AUTO_INCREMENT,
  `mngrname` VARCHAR(45) NOT NULL,
  `m_wtoonid` INT(11) NOT NULL,
  PRIMARY KEY (`mngrid`),
  INDEX `fk_manager_webtoon1_idx` (`m_wtoonid` ASC) VISIBLE,
  CONSTRAINT `fk_manager_webtoon1`
    FOREIGN KEY (`m_wtoonid`)
    REFERENCES `webtoon`.`webtoon` (`wtoonid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
