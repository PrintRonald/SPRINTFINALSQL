-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema indidualfinal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema indidualfinal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `indidualfinal` DEFAULT CHARACTER SET utf8 ;
USE `indidualfinal` ;

-- -----------------------------------------------------
-- Table `indidualfinal`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `indidualfinal`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `ingreso_aplicacion` INT NOT NULL DEFAULT 1,
  `dsoporte` INT NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;

ALTER TABLE `indidualfinal2`.`usuario` 
DROP COLUMN `dsoporte`;


-- -----------------------------------------------------
-- Table `indidualfinal`.`operario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `indidualfinal`.`operario` (
  `idoperario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `edad` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `cantidad_de_soporte` VARCHAR(45) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idoperario`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;
UPDATE `indidualfinal2`.`operario` SET `cantidad_de_soporte` = '3' WHERE (`idoperario` = '1');
UPDATE `indidualfinal2`.`operario` SET `cantidad_de_soporte` = '2' WHERE (`idoperario` = '2');
UPDATE `indidualfinal2`.`operario` SET `cantidad_de_soporte` = '2' WHERE (`idoperario` = '4');

-- -----------------------------------------------------
-- Table `indidualfinal`.`soporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `indidualfinal`.`soporte` (
  `operario_idoperario` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `nombre_operario` VARCHAR(45) NOT NULL,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `evaluacion` INT NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`operario_idoperario`, `usuario_idusuario`),
  INDEX `fk_operario_has_usuario_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_operario_has_usuario_operario_idx` (`operario_idoperario` ASC) VISIBLE,
  UNIQUE INDEX `nombre_operario_UNIQUE` (`nombre_operario` ASC) VISIBLE,
  UNIQUE INDEX `nombre_usuario_UNIQUE` (`nombre_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_operario_has_usuario_operario`
    FOREIGN KEY (`operario_idoperario`)
    REFERENCES `indidualfinal`.`operario` (`idoperario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_operario_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `indidualfinal`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


SELECT * FROM operario;

insert into operario (nombre, apellido, edad, correo, cantidad_de_soporte)
values
('Angustias','Rivera',30 ,'vommeifaxuxu-3938@yopmail.com',3),
('Eleuterio','Candela', 29,'quetriddauddinnau-8649@yopmail.com',2),
('Aurora','Suarez', 39,'waujeinnepoho-3172@yopmail.com', 2),
('Silvia','Osuna', 32,'neranoqueppa-7191@yopmail.com', 2),
('Pastora','Ojeda', 33,'koprippodedde-4115@yopmail.com', 1);

SELECT * FROM soporte;

insert into soporte (operario_idoperario, usuario_idusuario, nombre_operario, nombre_usuario,evaluacion, fecha)
values
(1,1,'Angustias', 'Camilo',5,CURRENT_TIMESTAMP() ),
(2,2,'Eleuterio', 'Alejo',6,CURRENT_TIMESTAMP() ),
(1,3,'Angustias', 'Eloy',7,CURRENT_TIMESTAMP() ),
(3,4,'Aurora', 'Alexia',4,CURRENT_TIMESTAMP() ),
(4,1,'Silvia', 'Camilo',7,CURRENT_TIMESTAMP() ),
(3,5,'Aurora', 'Leonor',5,CURRENT_TIMESTAMP() ),
(1,2,'Angustias', 'Alejo',3,CURRENT_TIMESTAMP() ),
(2,1,'Eleuterio', 'Camilo',6,CURRENT_TIMESTAMP() ),
(5,5,'Pastora', 'Leonor', 7,CURRENT_TIMESTAMP() ),
(4,1,'Silvia', 'Camilo', 5,CURRENT_TIMESTAMP() );

SELECT * FROM usuario;

insert into usuario (nombre, apellido, edad, correo, ingreso_aplicacion)
values
('Camilo','Cabeza',25,'teunatrusouye-2807@yopmail.com', 4),
('Alejo','Prats',30,'quoufreseffogra-4838@yopmail.com', 2),
('Eloy','Marques',39,'bragrouquefeune-8359@yopmail.com', 1),
('Alexia','Mariscal',28,'bequojunnolei-9166@yopmail.com', 1),
('Leonor','Santiago',31,'bajeisicrihe-6234@yopmail.com', 2);


/*Seleccione las 3 operaciones con mejor evaluación.*/
select nombre_operario, nombre_usuario, evaluacion from soporte
order by evaluacion desc
limit 3;

/*Seleccione las 3 operaciones con menos evaluación.*/
select nombre_operario, nombre_usuario, evaluacion from soporte
order by evaluacion asc
limit 3;
/*Seleccione al operario que más soportes ha realizado.*/
select nombre, cantidad_de_soporte from operario
where cantidad_de_soporte = (select max(cantidad_de_soporte) from operario);

/*Seleccione al cliente que menos veces ha utilizado la aplicación.*/
select nombre, ingreso_aplicacion from usuario
where ingreso_aplicacion = (select min(ingreso_aplicacion) from usuario);

/*Agregue 10 años a los tres primeros usuarios registrados.*/
select idusuario, nombre, edad from usuario
limit 3;

UPDATE usuario SET edad = edad+10 where idusuario=1;
UPDATE usuario SET edad = edad+10 where idusuario=2;
UPDATE usuario SET edad = edad+10 where idusuario=3;

/*Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.*/
ALTER TABLE usuario CHANGE correo email VARCHAR(45);
ALTER TABLE operario CHANGE correo email VARCHAR(45);

/*Seleccione solo los operarios mayores de 20 años.*/
select nombre, edad from  operario where edad > 20;