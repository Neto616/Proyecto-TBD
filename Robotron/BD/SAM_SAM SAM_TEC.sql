DROP DATABASE evalucionprototipos;
CREATE DATABASE evaluacionPrototipos CHARACTER SET utf8mb4;
USE evaluacionPrototipos;

DROP TABLE IF EXISTS juezPerteneceJurado;
DROP TABLE IF EXISTS juez;
DROP TABLE IF EXISTS construccion;
DROP TABLE IF EXISTS programacion;
DROP TABLE IF EXISTS diseño;
DROP TABLE IF EXISTS integrante;
DROP TABLE IF EXISTS equipo;
DROP TABLE IF EXISTS asesor;
DROP TABLE IF EXISTS institucion;
DROP TABLE IF EXISTS jurado;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS sede;
DROP TABLE IF EXISTS usuario;

--  asesores, instituciones, jueces
CREATE TABLE usuario(
	id         VARCHAR(6)  NOT NULL PRIMARY KEY,
	correo     VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50) NOT NULL,
    rol ENUM("Admin", "Instituto", "Asesor", "Juez")
);

CREATE TABLE sede(
	nombre    VARCHAR(50) NOT NULL PRIMARY KEY,
    direccion VARCHAR(50) NOT NULL
);

CREATE TABLE evento(
	nombre       VARCHAR(50) NOT NULL PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin    DATE NOT NULL,
    nombre_sede  VARCHAR(50),
    FOREIGN KEY(nombre_sede) REFERENCES sede(nombre) ON DELETE CASCADE on update cascade
);

CREATE TABLE jurado(
	id            VARCHAR(6) NOT NULL PRIMARY KEY,
    nombre_evento VARCHAR(50),
    FOREIGN KEY(nombre_evento) REFERENCES evento(nombre) ON DELETE CASCADE on update cascade
);

CREATE TABLE juez(
	id       	    VARCHAR(6)  NOT NULL PRIMARY KEY,
    nombre    		VARCHAR(30) NOT NULL,
    apellido1 		VARCHAR(30) NOT NULL,
    apellido2       VARCHAR(30) NOT NULL,
    direccion       VARCHAR(50) NOT NULL,
    nivel_academico ENUM ("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    institucion     VARCHAR(50),
    id_usuario      VARCHAR(6)  NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) on delete cascade on update cascade
);
alter table juez modify column id_usuario varchar(10) not null;
alter table juez modify column id varchar(10);

CREATE TABLE juezPerteneceJurado(
    id_juez   VARCHAR(6)   NOT NULL,
    id_jurado VARCHAR(6)   NOT NULL,
    PRIMARY KEY(id_juez, id_jurado),
    FOREIGN KEY(id_juez)   REFERENCES juez(id) on delete cascade on update cascade,
    FOREIGN KEY(id_jurado) REFERENCES jurado(id) on delete cascade on update cascade
);

CREATE TABLE institucion(
    nombre          VARCHAR(50) NOT NULL,
    nivel           ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional") NOT NULL,
    PRIMARY KEY(nombre, nivel),
    direccion       VARCHAR(50) NOT NULL,
    nombre_evento   VARCHAR(50),
    id_usuario      VARCHAR(6) NOT NULL,
    FOREIGN KEY(nombre_evento) REFERENCES evento(nombre) ON DELETE CASCADE on update cascade,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE on update cascade
);
alter table institucion modify column id_usuario varchar(10) not null;
CREATE TABLE asesor(
	id                 VARCHAR(5)  NOT NULL PRIMARY KEY,
    nombre             VARCHAR(30) NOT NULL,
    apellido1          VARCHAR(30) NOT NULL,
    apellido2 		   VARCHAR(30) NOT NULL,
    nombre_institucion VARCHAR(50),
    nivel_institucion  ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    id_usuario         VARCHAR(6)  NOT NULL,
    FOREIGN KEY(nombre_institucion, nivel_institucion) REFERENCES institucion(nombre, nivel) ON DELETE CASCADE,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

CREATE TABLE equipo(
	id_equipo		   VARCHAR(6) NOT NULL PRIMARY KEY,
	nombre             VARCHAR(50),
    id_asesor          VARCHAR(5),
    nombre_institucion VARCHAR(50),
    nivel_institucion  ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    id_jurado          VARCHAR(6),
    nombre_evento      VARCHAR(50),
    categoria          ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    FOREIGN KEY(id_asesor)     REFERENCES asesor(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(nombre_institucion,nivel_institucion) REFERENCES institucion(nombre, nivel) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_jurado)     REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(nombre_evento) REFERENCES evento(nombre) ON DELETE CASCADE on update cascade
);

alter table usuario modify column id varchar(10);

CREATE TABLE integrante(
	id               VARCHAR(5)  NOT NULL PRIMARY KEY,
    nombre           VARCHAR(30) NOT NULL,
    apellido1        VARCHAR(30) NOT NULL,
    apellido2        VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_equipo    VARCHAR(50),
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) ON DELETE CASCADE on update cascade
);

CREATE TABLE diseño(
    id_diseño     VARCHAR(6)  NOT NULL PRIMARY KEY,
    respuesta     BOOLEAN     NOT NULL,
    id_jurado     VARCHAR(6)  NOT NULL,
    id_equipo VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE programacion(
	id_programacion VARCHAR(6) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN NOT NULL,
    id_jurado       VARCHAR(6) NOT NULL,
	id_equipo   VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE construccion(
	id_construccion VARCHAR(6) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN,
    id_jurado       VARCHAR(6) NOT NULL,
    id_equipo   VARCHAR(50) NOT NULL,
    FOREIGN KEY(id_jurado) REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);