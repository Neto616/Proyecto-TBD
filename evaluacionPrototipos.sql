DROP DATABASE evalucionprototipos;
CREATE DATABASE evaluacionPrototipos CHARACTER SET utf8mb4;
USE evaluacionPrototipos;

SET GLOBAL log_bin_trust_function_creators = 1;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Neto_616';

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

drop procedure if exists inicio_sesion;

drop procedure if exists baja_juez;

drop procedure if exists baja_institucion;
drop procedure if exists alta_institucion;

drop procedure if exists alta_evento;
drop procedure if exists baja_evento;
drop procedure if exists modificar_evento;
drop procedure if exists buscar_evento;

drop procedure if exists alta_sede;
drop procedure if exists modificar_sede;
drop procedure if exists buscar_sede;
drop procedure if exists baja_sede;

DROP PROCEDURE IF EXISTS alta_integrante;
drop procedure buscar_integrante;

DROP PROCEDURE IF EXISTS alta_asesor;


--  asesores, instituciones, jueces
CREATE TABLE usuario(
	id         VARCHAR(10)  NOT NULL PRIMARY KEY,
	correo     VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50) NOT NULL,
    rol ENUM("Admin", "Instituto", "Asesor", "Juez")
);
select * from asesor;
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
alter table evento modify column fecha_inicio datetime not null;
alter table evento modify column fecha_fin datetime not null;

CREATE TABLE jurado(
	id            VARCHAR(6) NOT NULL PRIMARY KEY,
    nombre_evento VARCHAR(50),
    FOREIGN KEY(nombre_evento) REFERENCES evento(nombre) ON DELETE CASCADE on update cascade
);

CREATE TABLE juez(
	id       	    VARCHAR(10)  NOT NULL PRIMARY KEY,
    nombre    		VARCHAR(30) NOT NULL,
    apellido1 		VARCHAR(30) NOT NULL,
    apellido2       VARCHAR(30) NOT NULL,
    direccion       VARCHAR(50) NOT NULL,
    nivel_academico ENUM ("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    institucion     VARCHAR(50),
    id_usuario      VARCHAR(10)  NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) on delete cascade on update cascade
);
alter table juez modify column id_usuario varchar(10) not null;
alter table juez modify column id varchar(10);
alter table juez add column nombre_evento varchar(50);
CREATE TABLE juezPerteneceJurado(
    id_juez   VARCHAR(10)   NOT NULL,
    id_jurado VARCHAR(6)   NOT NULL,
    PRIMARY KEY(id_juez, id_jurado),
    FOREIGN KEY(id_juez)   REFERENCES juez(id) on delete cascade on update cascade,
    FOREIGN KEY(id_jurado) REFERENCES jurado(id) on delete cascade on update cascade
);
alter table juezPerteneceJurado modify column id_juez varchar(10) not null;
CREATE TABLE institucion(
    nombre          VARCHAR(50) NOT NULL,
    nivel           ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional") NOT NULL,
    PRIMARY KEY(nombre, nivel),
    direccion       VARCHAR(50) NOT NULL,
    nombre_evento   VARCHAR(50),
    id_usuario      VARCHAR(10) NOT NULL,
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
alter table asesor modify column id varchar(10);
alter table asesor modify column id_usuario varchar(10);
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
	id               VARCHAR(10)  NOT NULL PRIMARY KEY,
    nombre           VARCHAR(30) NOT NULL,
    apellido1        VARCHAR(30) NOT NULL,
    apellido2        VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_equipo    VARCHAR(10),
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) ON DELETE CASCADE on update cascade
);
alter table integrante modify column id varchar(10);

CREATE TABLE diseño(
    id_diseño     VARCHAR(10)  NOT NULL PRIMARY KEY,
    respuesta     BOOLEAN     NOT NULL,
    id_jurado     VARCHAR(10)  NOT NULL,
    id_equipo VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES juez(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE programacion(
	id_programacion VARCHAR(10) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN NOT NULL,
    id_jurado       VARCHAR(10) NOT NULL,
	id_equipo   VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES juez(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE construccion(
	id_construccion VARCHAR(10) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN,
    id_jurado       VARCHAR(10) NOT NULL,
    id_equipo   VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado) REFERENCES juez(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

insert into usuario values ('1111','mtraCortez@gmail.com', 'del1al10', 'Admin');

drop trigger Disparador;
delimiter //
create trigger Disparador BEFORE insert on usuario
for each row
begin
 delete from usuario where correo = "";
end;
//
-- Vistas 
create or replace view asesores as
select id as idAsesor, nombre as nombre, apellido1 as apellidoP, apellido2 as apellidoM, nivel_institucion as nivelAcademico, nombre_institucion as instituto from asesor;

select * from institucion;

create or replace view sedes as
select nombre as nombre, direccion as direccion from sede;

create view eventos as
		select nombre as nombre, fecha_inicio as fInicio, fecha_fin as fFin,nombre_sede as sede from evento

-- Todos los jueces
create or replace view jueces as 
select nombre as nombres, apellido1 as apellidoP, apellido2 as apellidoM, nivel_academico as estudios, institucion as institucion
from juez;

-- Todas las escuelas
create or replace view escuelas as 
select nombre as nombre, nivel as nivelEscolar from institucion;

select * from escuelas;
-- Todas las categorias 
create view equipos_categoria as 
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo order by nombre, categoria; 

-- Equipos que estan en la categoria "Primaria"
create view equipos_primaria as
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo where categoria like "Primaria";

-- Equipos que estan en la categoria "Secundaria"
create view equipos_secundaria as
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo where categoria like "Secundaria";
-- Equipos que estan en la categoria "Bachillerato"
create view equipos_bachillerato as
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo where categoria like "Bachillerato";
-- Equipos que estan en la categoria "Profesional"
create view equipos_profesional as
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo where categoria like "Profesional";

-- Procedimientos almacenados
delimiter //
create procedure alta_juez(correoJ varchar(50), contrasenaJ varchar(50), nombreJ varchar(30), apellido1J varchar(30), apellido2J varchar(30),direccion varchar(50),nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), institucion varchar(50), out mensaje varchar(100))
begin
	declare idUs varchar(10);
    declare idJuez varchar(10);
		if exists(select correo, contraseña from usuario where correo = correoJ)  then
			set mensaje = "Juez existente";
            select mensaje as resultado;
		else 
            set idUs = (select generar_id_usuario (correoJ, contrasenaJ));
            set idJuez = (select  generar_id_asesor(nombreJ, apellido1J, apellido2J));
            insert into usuario values (idUs, correoJ, contrasenaJ, 'Juez');
            insert into juez values (idJuez,nombreJ, apellido1J, apellido2J, direccion, nivelIns, institucion, idUs);
            set mensaje = "Agregado correctamente";
			select mensaje as resultado;
        end if;
end //
delimiter ;

-- Procedimiento para agregar un integrante
drop procedure alta_integrante;
DELIMITER //
CREATE PROCEDURE alta_integrante(coockie varchar(10), nombreI VARCHAR(30), apellido1I VARCHAR(30),apellido2I VARCHAR(30),fechaNacimientoI DATE,OUT mensaje VARCHAR(100))
BEGIN
    DECLARE idUs VARCHAR(10);
    DECLARE idIntegrante VARCHAR(10);

    -- Verificar si el integrante ya existe
    IF EXISTS (SELECT nombre, apellido1, apellido2 FROM integrante WHERE nombre = nombreI AND apellido1 = apellido1I AND apellido2 = apellido2I) THEN
        SET mensaje = 'El integrante ya existe';
        SELECT mensaje AS resultado;
    ELSE
        -- Generar ID para el nuevo integrante
        SET idUs = (SELECT generar_id_usuario(CONCAT(nombreI, apellido1I, apellido2I), 'password')); -- Cambiar 'password' por la contraseña deseada
        SET idIntegrante = (SELECT CONCAT(SUBSTRING(HEX(nombreI), 1, 4), SUBSTRING(HEX(apellido1I), 1, 3), SUBSTRING(HEX(apellido2I), 1, 3)));

        -- Insertar el nuevo integrante en la tabla
        INSERT INTO integrante (id, nombre, apellido1, apellido2, fecha_nacimiento, instituto)
        VALUES (idIntegrante, nombreI, apellido1I, apellido2I, fechaNacimientoI, (select institucion.nombre as nombreInst from institucion join usuario on institucion.id_usuario = usuario.id where institucion.id_usuario = coockie));

        SET mensaje = 'Integrante agregado correctamente';
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;


-- Procedimiento para agregar un equipo
DROP PROCEDURE IF EXISTS alta_equipo;
DELIMITER //
CREATE PROCEDURE alta_equipo(
    nombreE VARCHAR(50),
    deporteE VARCHAR(50),
    OUT mensaje VARCHAR(100)
)
BEGIN
    DECLARE idEquipo VARCHAR(10);

    -- Verificar si el equipo ya existe
    IF EXISTS (SELECT nombre FROM equipo WHERE nombre = nombreE) THEN
        SET mensaje = 'El equipo ya existe';
        SELECT mensaje AS resultado;
    ELSE
        -- Generar ID para el nuevo equipo
        SET idEquipo = (SELECT CONCAT(SUBSTRING(HEX(nombreE), 1, 4), SUBSTRING(HEX(deporteE), 1, 3)));

        -- Insertar el nuevo equipo en la tabla
        INSERT INTO equipo (id, nombre, deporte)
        VALUES (idEquipo, nombreE, deporteE);

        SET mensaje = 'Equipo agregado correctamente';
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS baja_integrante;
delimiter //
create procedure baja_integrante (nombreInt varchar(30), apellidoPInt varchar(30), apellidoMInt varchar(30), OUT mensaje VARCHAR(100))
begin
	if exists(select nombre, apellido1, apellido2 from integrante where nombre like nombreInt and apellido1 like apellidoPInt and apellido2 like apellidoMInt) then
		delete from integrante where nombre like nombreInt and apellido1 like apellidoPInt and apellido2 like apellidoMInt;
        set mensaje = "Eliminación exitosa";
        select mensaje as resultado;
    else
		set mensaje = "Integrante no existe";
        select mensaje as resultado;
	end if;
end //
delimiter ;



select * from asesor;
drop procedure alta_asesor;

delimiter //
create procedure alta_asesor(coockie varchar(50), correoA VARCHAR(50),contrasenaA VARCHAR(50),nombreA VARCHAR(30),apellido1A VARCHAR(30),apellido2A VARCHAR(30),nivelIns ENUM('Primaria','Secundaria','Bachillerato','Profesional'),OUT mensaje VARCHAR(100))
begin
    declare idUs VARCHAR(10);
    declare idAsesor VARCHAR(10);
    if exists (select correo, contraseña from usuario where correo = correoA) then
        set mensaje = "Asesor existente";
        select mensaje as resultado;
    else
			set idUs = (select generar_id_usuario(correoA, contrasenaA));
			set idAsesor = (select generar_id_asesor(nombreA, apellido1A, apellido2A));
			insert into usuario values (idUs, correoA, contrasenaA, 'Asesor');
			insert into  asesor (id, nombre, apellido1, apellido2, nombre_institucion, nivel_institucion, id_usuario) values (idAsesor, nombreA, apellido1A, apellido2A, (select institucion.nombre as nombreInst from institucion join usuario on institucion.id_usuario = usuario.id where institucion.id_usuario = coockie) ,nivelIns, idUs);
			set mensaje = "Agregado correctamente";
			select mensaje as resultado;
        end if;
END //
DELIMITER ;

delete from usuario where id = '65726E6531';
select * from usuario;
select * from asesor;
CREATE VIEW Vista_Eventos_Con_Sedes AS
SELECT evento.nombre AS evento,
       evento.fecha_inicio AS fecha_inicio,
       evento.fecha_fin AS fecha_fin,
       sede.nombre AS nombreSede,
       sede.direccion AS direccion
FROM evento
JOIN sede ON evento.nombre_sede = sede.nombre;

DELIMITER //
CREATE PROCEDURE modificar_integrante (integrante_nombre varchar(50), nuevo_nombre varchar(50), nuevo_apellido1 varchar(50), 
    nuevo_apellido2 varchar(50), nueva_fecha_nacimiento varchar(50), OUT mensaje varchar(50))
BEGIN
    IF EXISTS (SELECT nombre FROM integrante WHERE nombre LIKE integrante_nombre) THEN
        UPDATE integrante 
        SET nombre = nuevo_nombre, apellido1 = nuevo_apellido1, apellido2 = nuevo_apellido2, fecha_nacimiento = nueva_fecha_nacimiento 
        WHERE nombre = integrante_nombre;
        
        SET mensaje = "Actualización realizada con éxito";
        SELECT mensaje AS resultado;
    ELSE  
        SET mensaje = "Ese integrante no existe";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

drop procedure buscar_integrante;
DELIMITER //
CREATE PROCEDURE buscar_integrante (nombreIn varchar(30), apellidoPatIn varchar(30), apellidoMatIn varchar(30) ,OUT mensaje varchar(50))
BEGIN
    IF EXISTS (SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM integrante WHERE nombre LIKE nombreIn and apellido1 like apellidoPatIn and apellido2 like apellidoMatIn) THEN
        SELECT nombre as nombre, apellido1 as apellidoPat, apellido2 as apellidoMat FROM integrante WHERE nombre LIKE nombreIn and apellido1 like apellidoPatIn and apellido2 like apellidoMatIn;
    ELSE
        SET mensaje = "No encontrado";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;
drop procedure alumnos;
delimiter //
create procedure alumnos (coockie varchar(10))
begin
	select nombre as nombre, apellido1 as apellidoPat, apellido2 as apellidoMat, TIMESTAMPDIFF(YEAR,fecha_nacimiento,CURDATE()) AS edad from integrante where instituto = (select institucion.nombre as nombreInst from institucion join usuario on institucion.id_usuario = usuario.id where institucion.id_usuario = coockie limit 1);
end //
delimiter ;

drop procedure usuario_id_escuela;
delimiter //
create procedure usuario_id_escuela (coockie varchar(10)) 
begin
	select institucion.nombre as nombreInst from institucion join usuario on institucion.id_usuario = usuario.id where usuario.id like coockie;
end //
delimiter ;
call usuario_id_escuela ('63646D6163');

call buscar_integrante('Julian Alejandro', 'Rodriguez', 'Lopez', @mensaje);
insert into integrante values ("1234", "Ivan", "Balderas", "Soto", "2003-06-16", null, "TecnologicoCiudadMadero");
select * from integrante;
select * from evento;
select * from institucion;
select * from usuario;
select * from juez;
select * from sede;
select * from asesor;

-- -----------------------------------------------------------------------------------------------------
call alta_juez ('netoilluminati258@gmail.com', "1234","Nestor","Balderas","Soto","Laguna de champayan 305H","Profesional", "Harvard", @mensaje);
call baja_juez ('María', "Sanchez","Balderas", @mensaje);

call alta_institucion ('colegioTiyoli@gmail.com', "1234", "Colegio Tiyoli", "Primaria", "Nardo 150", @mensaje);
call baja_institucion ('colegioTiyoli@gmail.com', "Colegio Tiyoli","Primaria", @mensaje);

call alta_evento ("Prueba1", "2023-10-11", "2023-10-10", "Unidad deportiva tampico", "Calle prueba" , @mensaje);
call baja_evento ("Prueba1", @mensaje);
call modificar_evento('Prueba', 'Prueba1', @mensaje);
call buscar_evento('Prueba');

call alta_sede ('Instituto tenconologico de ciudad madero', "madero", @mensaje);
call baja_sede ("Pollo church", @mensaje);