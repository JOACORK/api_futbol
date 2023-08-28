-- -----------------------------------------------------
-- Schema futbol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `futbol` DEFAULT CHARACTER SET utf8mb4 ;
USE `futbol` ;

-- -----------------------------------------------------
-- Table `futbol`.`paises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`paises` (
  `codigo` VARCHAR(2) NOT NULL,
  `pais` VARCHAR(100) NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`ligas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`ligas` (
  `id` INT NOT NULL,
  `codigo_pais` VARCHAR(2) NULL,
  `nombre_liga` VARCHAR(100) NULL,
  `tipo_liga` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_paises_ligas_idx` (`codigo_pais` ASC) VISIBLE,
  CONSTRAINT `fk_paises_ligas`
    FOREIGN KEY (`codigo_pais`)
    REFERENCES `futbol`.`paises` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`datos_ligas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`datos_ligas` (
  `liga_id` INT NOT NULL,
  `temporada` INT NOT NULL,
  `inicio` DATE NULL,
  `fin` DATE NULL,
  `f_eventos` TINYINT NULL,
  `f_alineaciones` TINYINT NULL,
  `f_estadistitcas` TINYINT NULL,
  `f_jugadores` TINYINT NULL,
  `clasificaciones` TINYINT NULL,
  `jugadores` TINYINT NULL,
  `top_goleadores` TINYINT NULL,
  `top_asistencias` TINYINT NULL,
  `top_tarjetas` TINYINT NULL,
  `lesiones` TINYINT NULL,
  `predicciones` TINYINT NULL,
  `apuestas` TINYINT NULL,
  PRIMARY KEY (`liga_id`, `temporada`),
  CONSTRAINT `fk_ligas_datos`
    FOREIGN KEY (`liga_id`)
    REFERENCES `futbol`.`ligas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`equipos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(100) NULL,
  `codigo` VARCHAR(3) NULL,
  `fundado` INT NULL,
  `id_liga` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ligas_equipos_idx` (`id_liga` ASC) VISIBLE,
  CONSTRAINT `fk_ligas_equipos`
    FOREIGN KEY (`id_liga`)
    REFERENCES `futbol`.`ligas` (`codigo_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `futbol`.`ligas_equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`ligas_equipos` (
  `id_liga` INT NOT NULL,
  `id_equipo` INT NOT NULL,
  `temporada` INT NULL,
  INDEX (`id_liga`,`id_equipo`),
  CONSTRAINT `fk_ligas_id` 
  FOREIGN KEY (`id_liga`)
    REFERENCES `futbol`.`ligas` (`id`),
CONSTRAINT `fk_equipos_id` 
  FOREIGN KEY (`id_equipo`)
    REFERENCES `futbol`.`equipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `futbol`.`equipos_estadisticas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`equipos_estadisticas` (
  `id` INT NOT NULL,
  `id_equipo` INT NULL,
  `id_liga` INT NULL,
  `temporada` INT NULL,
  `pj_local` INT NULL,
  `pj_visitante` INT NULL,
  `pg_local` INT NULL,
  `pg_visitante` INT NULL,
  `pe_local` INT NULL,
  `pe_visitante` INT NULL,
  `pp_local` INT NULL,
  `pp_visitante` INT NULL,
  `goles_local` INT NULL,
  `goles_visitante` INT NULL,
  `goles_contra_local` INT NULL,
  `goles_contra_visitante` INT NULL,
  `arco_invicto_local` INT NULL,
  `arco_invicto_visitante` INT NULL,
  `goles_errados_local` INT NULL,
  `goles_errados_visitante` INT NULL,
  `penales_convertidos` INT NULL,
  `penales_errados` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `temporada` (`temporada` ASC) VISIBLE,
  INDEX `fk_equipos_equipos_estadisticas_idx1` (`id_equipo` ASC, `id_liga` ASC) VISIBLE,
  CONSTRAINT `fk_equipos_equipos_estadisticas`
    FOREIGN KEY (`id_equipo` , `id_liga`)
    REFERENCES `futbol`.`equipos` (`id` , `id_liga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`tarjetas_detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`tarjetas_detalles` (
  `id_equipo` INT NOT NULL,
  `a_0_15` INT NULL,
  `a_16_30` INT NULL,
  `a_31_45` INT NULL,
  `a_46_60` INT NULL,
  `a_61_75` INT NULL,
  `a_76_90` INT NULL,
  `a_91_105` INT NULL,
  `a_106_120` INT NULL,
  `r_0_15` INT NULL,
  `r_16_30` INT NULL,
  `r_31_45` INT NULL,
  `r_46_60` INT NULL,
  `r_61_75` INT NULL,
  `r_76_90` INT NULL,
  `r_91_105` INT NULL,
  `r_106_120` INT NULL,
  PRIMARY KEY (`id_equipo`),
  CONSTRAINT `fk_equipo_estadisticas_tarjetas`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `futbol`.`equipos_estadisticas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`goles_detalles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`goles_detalles` (
  `id_equipo` INT NOT NULL,
  `gf_0_15` INT NULL,
  `gf_16_30` INT NULL,
  `gf_31_45` INT NULL,
  `gf_46_60` INT NULL,
  `gf_61_75` INT NULL,
  `gf_76_90` INT NULL,
  `gf_91_105` INT NULL,
  `gf_106_120` INT NULL,
  `gc_0_15` INT NULL,
  `gc_16_30` INT NULL,
  `gc_31_45` INT NULL,
  `gc_46_60` INT NULL,
  `gc_61_75` INT NULL,
  `gc_76_90` INT NULL,
  `gc_91_105` INT NULL,
  `gc_106_120` INT NULL,
  PRIMARY KEY (`id_equipo`),
  CONSTRAINT `fk_equipo_estadisticas_tarjetas_detalle`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `futbol`.`equipos_estadisticas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`hitos_equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`hitos_equipos` (
  `id_equipo_estadistica` INT NOT NULL,
  `mayor_racha_victorias` INT NULL,
  `mayor_racha_empates` INT NULL,
  `mayor_racha_derrotas` INT NULL,
  `mayor_victoria_local` VARCHAR(6) NULL,
  `mayor_victoria_visitante` VARCHAR(6) NULL,
  `mayor_derrota_local` VARCHAR(6) NULL,
  `mayor_derrota_visitante` VARCHAR(6) NULL,
  `mayor_goles_convertidos_local` INT NULL,
  `mayor_goles_convertidos_visitante` INT NULL,
  `mayor_goles_recibidos_local` INT NULL,
  `mayor_goles_recibidos_visitante` INT NULL,
  PRIMARY KEY (`id_equipo_estadistica`),
  CONSTRAINT `fk_equipos_estadisticas_hitos_equipos`
    FOREIGN KEY (`id_equipo_estadistica`)
    REFERENCES `futbol`.`equipos_estadisticas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `futbol`.`formaciones_equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `futbol`.`formaciones_equipos` (
  `id_equipo_estadistica` INT NOT NULL,
  `formacion` VARCHAR(45) NULL,
  `partidos` INT NULL,
  PRIMARY KEY (`id_equipo_estadistica`),
  CONSTRAINT `fk_equipos_estadisticas_formaciones_equipos`
    FOREIGN KEY (`id_equipo_estadistica`)
    REFERENCES `futbol`.`equipos_estadisticas` (`id_equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

create table ejemplo(variable varchar(10)
, fijo int);

select *from ejemplo;
insert into ejemplo select "124567890","7890";


/*
xecuting SQL script in server
ERROR: Error 3780: Referencing column 'id_liga' and referenced column 'codigo_pais' in foreign key constraint 'fk_ligas_equipos' are incompatible.