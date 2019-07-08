-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema JavaWeb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema JavaWeb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `JavaWeb` ;
USE `JavaWeb` ;

-- -----------------------------------------------------
-- Table `JavaWeb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`user` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(50) NOT NULL,
  `profile_photo_url` VARCHAR(100) NULL DEFAULT NULL,
  `registered_time` TIMESTAMP NOT NULL,
  `type` VARCHAR(10) NOT NULL DEFAULT 'user',
  CHECK (`type` in ("user", "operator", "admin")),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JavaWeb`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`post` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`post` (
  `post_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL ,
  `post_name` VARCHAR(100) NOT NULL,
  `content` TEXT NOT NULL,
  `post_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `JavaWeb`.`user` (`id`)  
    ON DELETE cascade
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JavaWeb`.`floor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`floor` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`floor` (
  `floor_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `floor_num` INT UNSIGNED NOT NULL,
  `parent_post_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `floor_content` TEXT NOT NULL,
  `floor_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`floor_id`),
  INDEX `floor_user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `floor_post_id_idx` (`parent_post_id` ASC) VISIBLE,
  CONSTRAINT `floor_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `JavaWeb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `floor_post_id`
    FOREIGN KEY (`parent_post_id`)
    REFERENCES `JavaWeb`.`post` (`post_id`)
    ON DELETE cascade
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JavaWeb`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`comment` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`comment` (
  `comment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `root_floor_id` INT UNSIGNED NOT NULL,
  `pre_comment_id` INT NULL DEFAULT -1,
  `content` TEXT NOT NULL,
  `comment_time` TIMESTAMP NOT NULL,
  `isdeleted` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`comment_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `comment_root_floor_id_idx` (`root_floor_id` ASC) VISIBLE,
  CONSTRAINT `commnet_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `JavaWeb`.`user` (`id`)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_root_floor_id`
    FOREIGN KEY (`root_floor_id`)
    REFERENCES `JavaWeb`.`floor` (`floor_id`)
    ON DELETE cascade
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JavaWeb`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`profile` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`profile` (
  `id` INT UNSIGNED NOT NULL,
  `gender` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `following_num` INT UNSIGNED NULL DEFAULT 0,
  `follower_num` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  CONSTRAINT `profile_id`
    FOREIGN KEY (`id`)
    REFERENCES `JavaWeb`.`user` (`id`)
    ON DELETE cascade
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JavaWeb`.`follow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JavaWeb`.`follow` ;

CREATE TABLE IF NOT EXISTS `JavaWeb`.`follow` (
  `follower_id` INT UNSIGNED,
  `followed_id` INT UNSIGNED,
  PRIMARY KEY (`follower_id`, `followed_id`),
  CONSTRAINT `follower_id`
    FOREIGN KEY (`follower_id`)
    REFERENCES `JavaWeb`.`user` (`id`)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT `followed_id`
    FOREIGN KEY (`followed_id`)
    REFERENCES `JavaWeb`.`user` (`id`)
    ON DELETE cascade
    ON UPDATE NO ACTION
)

ENGINE = InnoDB;

USE `JavaWeb`;

DELIMITER $$

USE `JavaWeb`$$
DROP TRIGGER IF EXISTS `JavaWeb`.`follow_BEFORE_INSERT` $$
USE `JavaWeb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `JavaWeb`.`follow_BEFORE_INSERT` BEFORE INSERT ON `follow` FOR EACH ROW
BEGIN
	UPDATE profile SET following_num = following_num + 1 WHERE id = NEW.follower_id;
    UPDATE profile SET follower_num = follower_num + 1 WHERE id = NEW.followed_id;
END$$


USE `JavaWeb`$$
DROP TRIGGER IF EXISTS `JavaWeb`.`follow_BEFORE_DELETE` $$
USE `JavaWeb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `JavaWeb`.`follow_BEFORE_DELETE` BEFORE DELETE ON `follow` FOR EACH ROW
BEGIN
	UPDATE profile SET following_num = following_num - 1 WHERE id = OLD.follower_id;
    UPDATE profile SET follower_num = follower_num - 1 WHERE id = OLD.followed_id;
END$$

DELIMITER ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
