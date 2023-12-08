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
insert into usuario values ('1','alexrdz1221@gmail.com', '123', 'Admin');
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
select * from integrante;
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
select * from evento;
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
-- Todos los sedes
create or replace view sedes as
select nombre as nombre, direccion as direccion from sede;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = root@localhost 
    SQL SECURITY DEFINER
VIEW evaluacionprototipos.eventos AS
    SELECT 
        evaluacionprototipos.evento.nombre AS nombre,
        evaluacionprototipos.evento.fecha_inicio AS fInicio,
        evaluacionprototipos.evento.fecha_fin AS fFin,
        evaluacionprototipos.evento.nombre_sede AS sede
    FROM
        evaluacionprototipos.evento

SELECT * FROM evaluacionprototipos.eventos

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

-- Puntajes obtenidos por categorías y por equipo. (ANALIZAR BASE DE DATOS)

-- Todos los equipos de cualquier categoría que tenga los 30 puntos. (INCOMPLETO)
create view equipos_puntaje as 
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria;

-- Reporte de que equipos faltaron (ANALIZAR BASE DE DATOS)

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
DROP PROCEDURE IF EXISTS alta_integrante;
DELIMITER //
CREATE PROCEDURE alta_integrante(
    nombreI VARCHAR(30),
    apellido1I VARCHAR(30),
    apellido2I VARCHAR(30),
    fechaNacimientoI DATE,
    OUT mensaje VARCHAR(100)
)
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
        INSERT INTO integrante (id, nombre, apellido1, apellido2, fecha_nacimiento)
        VALUES (idIntegrante, nombreI, apellido1I, apellido2I, fechaNacimientoI);

        SET mensaje = 'Integrante agregado correctamente';
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

select * from integrante;
select * from equipo;
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
DELIMITER //
CREATE PROCEDURE baja_integrante (idIntegrante VARCHAR(10), OUT mensaje VARCHAR(100))
BEGIN
    DECLARE integranteExistente INT;

    -- Verificar si el integrante existe
    SELECT COUNT(*) INTO integranteExistente FROM integrante WHERE id = idIntegrante;

    IF integranteExistente > 0 THEN
        DELETE FROM integrante WHERE id = idIntegrante;
        SET mensaje = "Integrante eliminado correctamente";
        SELECT mensaje AS resultado;
    ELSE
        SET mensaje = "Integrante no existente";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS alta_asesor;
DELIMITER //
CREATE PROCEDURE alta_asesor(
    correoA VARCHAR(50),
    contrasenaA VARCHAR(50),
    nombreA VARCHAR(30),
    apellido1A VARCHAR(30),
    apellido2A VARCHAR(30),
    nivelIns ENUM("Primaria", "Secundaria", "Bachillerato", "Profesional"),
    OUT mensaje VARCHAR(100)
)
BEGIN
    DECLARE idUs VARCHAR(10);
    DECLARE idAsesor VARCHAR(10);
    IF EXISTS (SELECT correo, contraseña FROM usuario WHERE correo = correoA) THEN
        SET mensaje = "Asesor existente";
        SELECT mensaje AS resultado;
    ELSE
        SET idUs = (SELECT generar_id_usuario(correoA, contrasenaA));
        SET idAsesor = (SELECT generar_id_asesor(nombreA, apellido1A, apellido2A));
        INSERT INTO usuario VALUES (idUs, correoA, contrasenaA, 'Asesor');
        INSERT INTO asesor VALUES (idAsesor, nombreA, apellido1A, apellido2A, nivelIns, idUs);
        SET mensaje = "Agregado correctamente";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;
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
CREATE PROCEDURE modificar_integrante (
    integrante_nombre varchar(50), 
    nuevo_nombre varchar(50), 
    nuevo_apellido1 varchar(50), 
    nuevo_apellido2 varchar(50), 
    nueva_fecha_nacimiento varchar(50), 
    OUT mensaje varchar(50)
)
BEGIN
    IF EXISTS (SELECT nombre FROM integrante WHERE nombre LIKE integrante_nombre) THEN
        UPDATE integrante 
        SET 
            nombre = nuevo_nombre, 
            apellido1 = nuevo_apellido1, 
            apellido2 = nuevo_apellido2, 
            fecha_nacimiento = nueva_fecha_nacimiento 
        WHERE nombre = integrante_nombre;
        
        SET mensaje = "Actualización realizada con éxito";
        SELECT mensaje AS resultado;
    ELSE
        SET mensaje = "Ese integrante no existe";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE buscar_integrante (nombre_integrante varchar(50), OUT mensaje varchar(50))
BEGIN
    IF EXISTS (SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM integrante WHERE nombre LIKE nombre_integrante) THEN
        SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM integrante WHERE nombre LIKE nombre_integrante;
    ELSE
        SET mensaje = "No encontrado";
        SELECT mensaje AS resultado;
    END IF;
END //
DELIMITER ;

delimiter //
create procedure alta_institucion(correoIns varchar(50), contrasenaIns varchar(50), nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), direccion varchar(50), out mensaje varchar(100))
begin
	declare idUs varchar(10);
		if exists(select correo, contraseña from usuario where correo = correoIns and contraseña = contrasenaIns) then
			set mensaje = "Instituto existente";
            select mensaje as resultado;
		else 
            set idUs = (select generar_id_usuario (correoIns, contrasenaIns));
            insert into usuario values (idUs, correoIns, contrasenaIns, 'Instituto');
            insert into institucion values (nombreIns, nivelIns, direccion, null, idUs);
            set mensaje = "Agregado correctamente";
            select mensaje as resultado;
		end if;
end // 
delimiter ;
-- Eventos
-- Alta eventos
drop procedure inicio_sesion;

delimiter //
create procedure inicio_sesion(correoUs varchar(50), contrasenaUs varchar(50))
begin
		declare credencial boolean;
        set credencial = (select validar_credenciales(correoUs, contrasenaUs));
        
        if credencial > 0 then
        select rol as puesto, id as idUs from usuario where correo = correoUs;
    else
		select "No existe" as resultado;
    end if;
end //
delimiter;

drop procedure alta_evento;

delimiter //
create procedure alta_evento (nombreEv varchar(50), fechaIEv datetime, fechaFEv datetime, nombre_sede varchar(50), direccion_sede varchar(50), out mensaje varchar (50))
begin
	if exists (select nombre, fecha_inicio, fecha_fin from evento where nombre = nombreEv and fecha_inicio = fechaIEv and fecha_fin = fechaFEv)then
		set mensaje = "Evento existente o fecha ocupada";
        select mensaje as resultado;
	else 
		if exists (select nombre, direccion from sede where nombre = nombre_sede) then
			if(fechaIEv < fechaFEv) then
				insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
				set mensaje = "Evento creado sede existente";
                select mensaje as resultado;
			else 
				set mensaje = "El evento no puede finalizar antes de que empiece";
                select mensaje as resultado;
			end if;
        else
        insert into sede values (nombre_sede, direccion_sede);
		insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
        
        set mensaje = "Evento creado exitosamente sede no creada";
        select mensaje as resultado;
		end if;
    end if;
end //
delimiter ;

call alta_evento ("Prueba1", "2023-10-11", "2023-10-10", "Unidad deportiva tampico", "Calle prueba" , @mensaje);
select * from evento;
select * from sede;
select @mensaje;
delete from evento where nombre = "Prueba1";

-- Baja 
drop procedure baja_evento;

delimiter //
create procedure baja_evento (nombreEv varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from evento where nombre = nombreEv )then
		delete from evento where nombre = nombreEv;
        set mensaje = "Evento eliminado de manera correcta";
	else 
        set mensaje = "Evento no existe";
	end if;
end //
delimiter ;

call baja_evento ("Prueba1", @mensaje);
select * from evento;
select @mensaje;

drop procedure inicio_sesion;

delimiter //
create procedure inicio_sesion(correoUs varchar(50), contrasenaUs varchar(50))
begin
        declare credencial boolean;
        set credencial = (select validar_credenciales(correoUs, contrasenaUs));

        if credencial > 0 then
        select rol as puesto, id as idUs from usuario where correo = correoUs;
    else
        select "No existe" as resultado;
    end if;
end //
delimiter ;

-- Modificar
drop procedure actualizar_evento;

delimiter //
create procedure actualizar_evento (nombreEv varchar(50), nombreNEv varchar(50), fechaIEv date, fechaFEv date, nombreSede varchar(50), direccion_sede varchar(50),out mensaje varchar(50))
begin
	if exists (select nombre from evento where nombre = nombreEv )then
		if exists(select nombre from sede where nombre = nombreSede) then
			update evento 
            set nombre = nombreNEv, fecha_inicio = fechaIEv, fecha_fin = fechaFEv, nombre_sede = nombreSede
            where nombre = nombreEv;
            
            set mensaje = "Actualizacion exitosa sede existente";
        else
            insert into sede values (nombreSede, direccion_Sede);
            
			update evento 
            set nombre = nombreNEv, fecha_inicio = fechaIEv, fecha_fin = fechaFEv, nombre_sede = nombreSede
            where nombre = nombreEv;
            
            set mensaje = "Actualizacion exitosa sede existente";
        end if;
	else 
        set mensaje = "Evento no existe";
	end if;
end //
delimiter ;

call actualizar_evento ("Prueba 0", "Prueba 1", "2023-10-11", "2023-10-12", "Instituto tecnologico de ciudad madero", "Calle prueba 0", @mensaje);
select * from evento;
select * from sede;
select @mensaje;

-- Sedes
-- Alta sede
drop procedure alta_sede

delimiter //
create procedure alta_sede (nombreSede varchar(50), direccionSede varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from sede where nombre = nombreSede and direccion = direccionSede) then
		set mensaje = "Sede existe";
    else 
		insert into sede values (nombreSede, direccionSede);
        set mensaje  = "Sede agregada exitosamente";
    end if;
end //
delimiter ;

call alta_sede ('Instituto tenconologico de ciudad madero', "madero", @mensaje);
select @mensaje;
select * from sede;
-- Baja sede

drop procedure baja_sede
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'halo031003'
delimiter //
create procedure baja_sede (nombreSede varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from sede where nombre like nombreSede) then
		delete from sede where nombre = nombreSede;
        set mensaje  = "Sede elimnada exitosamente";
		select mensaje as resultado;
    else 
		set mensaje = "Sede no existe";
        select mensaje as resultado;
    end if;
end //
delimiter ;
call baja_sede ("Pollo church", @mensaje);

drop procedure modificar_evento

delimiter //
create procedure modificar_evento(nombreActual varchar(50), nombreNuevo varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from evento where nombre = nombreActual) then
		set mensaje = "Evento actualizado correctamente";
        update evento set nombre = nombreNuevo where nombre = nombreActual;
        select mensaje as resultado;
    else
		set mensaje = "Error al actualizar";
        select mensaje as resutlado;
	end if;
end //
delimiter ;

call modificar_evento('Prueba', 'Prueba1', @mensaje);
drop procedure buscar_sede

delimiter //
create procedure buscar_sede (nombre_sede varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre, direccion from sede where nombre like nombre_sede) then
		select nombre as sede, direccion as direccion from sede where nombre like nombre_sede;
    else
		set mensaje = "No encontrado";
		select mensaje as result;
    end if;
end //
delimiter ;
-- Modificar sede
drop procedure modificar_sede

delimiter //
create procedure modificar_sede (sede_nombre varchar(50),nombre_sede varchar(50), direccion_sede varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from sede where nombre like sede_nombre) then
		update sede set nombre = nombre_sede, direccion = direccion_sede where nombre = sede_nombre;
        set mensaje = "Actualizacion realizada con exito";
        select mensaje as resultado;
	else
		set mensaje = "Esa sede no existe";
        select mensaje as resultado;
    end if;
end //
delimiter ;
-- Institucion
-- Alta institucion
drop procedure buscar_evento;

delimiter //
create procedure buscar_evento(nombre_evento varchar(50))
begin
	if exists(select nombre from evento where nombre = nombre_evento) then
		select nombre as evento, fecha_inicio as inicio, fecha_fin as fina, nombre_sede as sede from evento where nombre = nombre_evento;
	else
		select "No existe" as resultado;
    end if;
end //
delimiter ;
call buscar_evento('Prueba');
drop procedure alta_institucion;
delimiter //
create procedure alta_institucion (correoIns varchar(50), contrasenaIns varchar(50), nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), direccion varchar(50), out mensaje varchar(100))
begin
	declare idUs varchar(10);
		if exists(select correo, contraseña from usuario where correo = correoIns and contraseña = contrasenaIns) then
			set mensaje = "Instituto existente";
		else 
            set idUs = (select generar_id_usuario (correoIns, contrasenaIns));
            insert into usuario values (idUs, correoIns, contrasenaIns, 'Instituto');
            insert into institucion values (nombreIns, nivelIns, direccion, null, idUs);
            set mensaje = "Agregado correctamente";
		end if;
end //
delimiter ;

call alta_institucion ('colegioTiyoli@gmail.com', "1234", "Colegio Tiyoli", "Primaria", "Nardo 150", @mensaje);
select @mensaje;
select * from institucion;
select * from usuario;

-- Baja institucion
drop procedure baja_institucion;
delimiter //
create procedure baja_institucion (nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), out mensaje varchar(100))
begin
declare idUs varchar(10);
		if exists(select nombre, nivel from institucion where nombre = nombreIns and nivel = nivelIns) then
            set idUs = (select id_usuario from institucion where nombre = nombreIns and nivel = nivelIns);
            delete from usuario where id = idUs;
            delete from institucion where nombre = nombreIns and nivel = nivelIns;
            set mensaje = "Instituto eliminado correctamente";
            select mensaje as resultado;
		else 
            set mensaje = "Instituto no existente";
            select mensaje as resultado;
		end if;
end //
delimiter ;

call baja_institucion ('colegioTiyoli@gmail.com', "Colegio Tiyoli","Primaria", @mensaje);
select @mensaje;
select * from institucion;
select * from usuario;

-- Jueces

-- Alta 
drop procedure alta_juez;
delimiter //
create procedure alta_juez (correoJ varchar(50), contrasenaJ varchar(50), nombreJ varchar(30), apellido1J varchar(30), apellido2J varchar(30),direccion varchar(50),nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), institucion varchar(50), out mensaje varchar(100))
begin
	declare idUs varchar(10);
    declare idJuez varchar(10);
		if exists(select correo, contraseña from usuario where correo = correoJ)  then
			set mensaje = "Juez existente";
		else 
            set idUs = (select generar_id_usuario (correoJ, contrasenaJ));
            set idJuez = (select  generar_id_asesor(nombreJ, apellido1J, apellido2J));
            insert into usuario values (idUs, correoJ, contrasenaJ, 'Juez');
            insert into juez values (idJuez,nombreJ, apellido1J, apellido2J, direccion, nivelIns, institucion, idUs);
            set mensaje = "Agregado correctamente";
		end if;
end //
delimiter ;

call alta_juez ('nestor@prointernet.mx', "1234","PEPO","Balderas","Soto","Laguna de champayan 305H","Profesional", "Harvard", @mensaje);
call alta_juez ('netoilluminati258@gmail.com', "1234","pepe","Balderas","Soto","Laguna de champayan 305H","Profesional", "Harvard", @mensaje);
select @mensaje;
select * from juez;
select * from usuario;

-- baja
drop procedure baja_juez;
delimiter //
create procedure baja_juez (nombreJ varchar(30), apellido1J varchar(30), apellido2J varchar(30), out mensaje varchar(100))
begin
	declare idUs varchar(10);
		if exists(select nombre, apellido1, apellido2 from juez where nombre = nombreJ and apellido1 = apellido1J and apellido2 = apellido2J) then
            set idUs = (select id_usuario from juez where nombre = nombreJ and apellido1 = apellido1J and apellido2 = apellido2J);
            delete from usuario where id = idUs;
            delete from juez where nombre = nombreJ and apellido1 = apellido1J and apellido2 = apellido2J;
            set mensaje = "Juez eliminado correctamente";
            select mensaje as resultado;
		else 
            set mensaje = "Juez no existente";
            select mensaje as resultado;
		end if;
end //
delimiter ;

call baja_juez ('María', "Sanchez","Balderas", @mensaje);
select @mensaje;
select * from juez;
select * from sede;

SET GLOBAL log_bin_trust_function_creators = 1;
USE evaluacionprototipos;
-- Funciones
delimiter //
create function validar_credenciales(correo_usuario varchar(50), contraseña_usuario varchar(50)) returns boolean
begin 
	if exists (select correo, contraseña from usuario where correo = correo_usuario and contraseña = contraseña_usuario) then
		return true;
    else 
		return false;
    end if;
end 
//

delimiter  //
create function generar_id_equipo(equipo varchar(50), institucion varchar(50)) returns varchar(10)
begin
    declare nombre varchar(50);
    declare nom_institucion varchar(50);

    set nombre = substring((select hex(equipo)), 1, 8);
    set nom_institucion = substring((select hex(institucion)),1,2);
	return concat(nombre, nom_institucion);
end
//

delimiter  //
create function generar_id_asesor(nombreAs varchar(30), apellido1As varchar(30), apellido2As varchar(30)) returns varchar(10)
begin
    declare nombreAsistente varchar(30);
    declare apellido1Asistente varchar(30);
    declare apellido2Asistente varchar(30);

    set nombreAsistente = substring((select hex(nombreAs)), 1, 4);
    set apellido1Asistente = substring((select hex(apellido1As)),1,3);
    set apellido2Asistente = substring((select hex(apellido2As)),1,3);
	return concat(nombreAsistente, apellido1Asistente, apellido2Asistente);
end
//

delimiter  //
create function generar_id_usuario(correoUs varchar(50), contrasenaUs varchar(50)) returns varchar(10)
begin
    declare correoUsuario varchar(50);
    declare contraseñaUsuario varchar(50);

    set correoUsuario = substring((select hex(correoUs)), 1, 8);
    set contraseñaUsuario = substring((select hex(contrasenaUs)),1,2);

	return concat(correoUsuario, contraseñaUsuario);
end
//

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

delimiter //
create procedure alta_institucion(correoIns varchar(50), contrasenaIns varchar(50), nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), direccion varchar(50), out mensaje varchar(100))
begin
    declare idUs varchar(10);
        if exists(select correo, contraseña from usuario where correo = correoIns and contraseña = contrasenaIns) then
            set mensaje = "Instituto existente";
            select mensaje as resultado;
        else 
            set idUs = (select generar_id_usuario (correoIns, contrasenaIns));
            insert into usuario values (idUs, correoIns, contrasenaIns, 'Instituto');
            insert into institucion values (nombreIns, nivelIns, direccion, null, idUs);
            set mensaje = "Agregado correctamente";
            select mensaje as resultado;
        end if;
end // 
delimiter ;

/*Juez*/
delimiter //
create procedure participar_evento(usuario varchar(10),evento varchar(100))
begin
	update juez set nombre_evento=evento where id_usuario=usuario;
end//
delimiter ;

delimiter //
create procedure evento()
begin
	select nombre,date_format(fecha_inicio,'%d-%m-%Y') AS fecha_inicio,date_format(fecha_fin,'%d-%m-%Y') AS fecha_fin from evento ;
end//
delimiter ;

delimiter //
create function generar_id_criterio(codigoJuez varchar(20),codigo_equipo varchar(10),tipo varchar(4)) returns varchar(10) deterministic
begin
	declare juez varchar(30);
    declare equ varchar(30);
    declare tip varchar(30);
    
    set juez=substring((select hex(codigoJuez)),1,4);
    set equ=substring((select hex(codigo_equipo)),1,3);
    set tip=substring((select hex(tipo)),1,3);
    return concat(juez,equ,tip);
end//
delimiter //

delimiter //
create procedure calificar_equipo(programacion_e boolean,diseño_e boolean,construccion_e boolean,cod_equ varchar(6),cod_juez varchar(10),out mensaje varchar(10))
begin
	declare integrantes int;
    declare cod_pro varchar(10);
    declare cod_dis varchar(10);
    declare cod_con varchar(10);
    declare juez_usu varchar(10);
    set juez_usu=(select id from juez where id_usuario=cod_juez);
    set cod_pro=(select generar_id_criterio(juez_usu,cod_equ ,'pro'));
    set cod_dis=(select generar_id_criterio(juez_usu,cod_equ,'dis'));
    set cod_con=(select generar_id_criterio(juez_usu,cod_equ,'con'));
    set integrantes=(select count(id) from integrante where id_equipo=cod_equ);
    
    if(integrantes>0) then
		insert into construccion(id_construccion,respuesta,id_jurado,id_equipo) values(cod_con,construccion_e,juez_usu,cod_equ);
        insert into programacion(id_programacion,respuesta,id_jurado,id_equipo) values(cod_pro,programacion_e,juez_usu,cod_equ);
        insert into diseño(id_diseño,respuesta,id_jurado,id_equipo) values(cod_dis,diseño_e,juez_usu,cod_equ);
        set mensaje='OK';
    else
		set mensaje='no';
    end if;
end//
delimiter ;

delimiter //
create procedure equipos()
begin
	select id_equipo,nombre from equipo;
end//
delimiter ;
