SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `mydb`.`db_submarinoregistro` COLLATE = utf8_general_ci , ADD COLUMN `contrasena` VARCHAR(30) NOT NULL  AFTER `documento` ;

ALTER TABLE `mydb`.`db_tipodocumento` COLLATE = utf8_general_ci ;

ALTER TABLE `mydb`.`db_fotoregistro` COLLATE = utf8_general_ci ;

CREATE  TABLE IF NOT EXISTS `mydb`.`db_historias` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `documento` VARCHAR(30) NOT NULL ,
  `email` VARCHAR(30) NOT NULL ,
  `historia_fresa` TEXT(250) NOT NULL ,
  `historia_chocolate` TEXT(250) NOT NULL ,
  `historia_arequipe` TEXT(250) NOT NULL ,
  `historia_mora` TEXT(250) NOT NULL ,
  `f_reg` DATE NULL DEFAULT NULL ,
  `h_reg` TIME NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
