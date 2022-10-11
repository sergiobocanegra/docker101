-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
DROP DATABASE IF EXISTS taskdb;

CREATE DATABASE taskdb;

ALTER DATABASE taskdb DEFAULT CHARACTER SET utf8;
ALTER DATABASE taskdb DEFAULT CHARACTER SET latin1;

USE taskdb;

DROP TABLE IF EXISTS USUARIO;

CREATE TABLE USUARIO (
  ID_USUARIO int NOT NULL AUTO_INCREMENT,
  NOMBRE varchar(50) NOT NULL,
  PATERNO varchar(50) NOT NULL,
  MATERNO varchar(50) NOT NULL,
  ACTIVO int DEFAULT 1,
  PRIMARY KEY (ID_USUARIO)
) ;

DROP TABLE IF EXISTS CAT_STATUS;
CREATE TABLE CAT_STATUS (
  ID_STATUS int NOT NULL AUTO_INCREMENT,
  DESCRIPCION varchar(45) DEFAULT NULL,
  ACTIVO int DEFAULT 1,
  CREACION date DEFAULT CURDATE(),
  PRIMARY KEY (ID_STATUS)
) ;

DROP TABLE IF EXISTS TAREA;

--ID_USUARIO: Este es el propietario de la tarea
CREATE TABLE TAREA (
  ID_TAREA int NOT NULL AUTO_INCREMENT,
  TITULO varchar(100) DEFAULT NULL,
  DESCRIPCION varchar(300) DEFAULT NULL,
  ID_STATUS int DEFAULT 1,
  ID_USUARIO int NOT NULL, 
  CREACION date DEFAULT CURDATE(),
  FINALIZACION date DEFAULT NULL,
  PRIMARY KEY (ID_TAREA),
  CONSTRAINT fk_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID_USUARIO),
  CONSTRAINT fk_CAT_STATUS FOREIGN KEY (ID_STATUS) REFERENCES CAT_STATUS (ID_STATUS)
) ;

drop user docker@localhost, docker@'%';
CREATE USER 'docker'@'localhost' IDENTIFIED BY 'docker';
GRANT USAGE ON taskdb.* TO 'docker'@'%' IDENTIFIED BY 'docker';
GRANT USAGE ON taskdb.* TO 'docker'@'localhost' IDENTIFIED BY 'docker';
-- REVOKE ALL ON *.* FROM 'docker'@'docker101';

-- Restricciones de Lectura
GRANT SELECT ON taskdb.* TO 'docker'@'%';

-- Restricciones de Escritura y Actualizacion
GRANT INSERT, UPDATE ON taskdb.TAREA TO 'docker'@'%';

-- Asigancion de los Roles
FLUSH PRIVILEGES;

INSERT INTO CAT_STATUS (ID_STATUS, DESCRIPCION)
VALUES (1,"Activa"), (2,"Finalizada"), (3,"Cancelada");

INSERT INTO USUARIO (NOMBRE, PATERNO, MATERNO)
VALUES ('Sergio Tomás','Bocanegra','García');

INSERT INTO TAREA (ID_USUARIO, TITULO, DESCRIPCION, CREACION)
VALUES 
(1,"Preparar el archivo .pptx Workshop","Crear la presentación con la información relavante.",'2022-10-01'),
(1,"Prepara ejemplos","Preparar los ejemplos a utilizar.",'2022-10-01'),
(1,"Lanzar la convocatoria del Workshop","Crear el invite en outlook.",'2022-10-01'),
(1,"Realizar el Workshop","Realizar la ponencia.",'2022-10-01');

UPDATE TAREA SET FINALIZACION = '2022-10-11', ID_STATUS = 2 WHERE ID_TAREA <= 3;

SELECT 
  TAREA.TITULO AS "TASK_TITULO",
  TAREA.DESCRIPCION AS "TASK_DESCRIPCION",
  TAREA.CREACION AS "TASK_FECHA_CREACION",
  CAT_STATUS.DESCRIPCION AS "TASK_STATUS"
FROM TAREA
INNER JOIN USUARIO
ON TAREA.ID_USUARIO = USUARIO.ID_USUARIO
INNER JOIN CAT_STATUS
ON TAREA.ID_STATUS = CAT_STATUS.ID_STATUS
WHERE USUARIO.ID_USUARIO = 1 AND TAREA.ID_STATUS = 1;