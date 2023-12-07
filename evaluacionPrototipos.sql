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
    id_jurado     VARCHAR(6)  NOT NULL,
    id_equipo VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE programacion(
	id_programacion VARCHAR(10) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN NOT NULL,
    id_jurado       VARCHAR(6) NOT NULL,
	id_equipo   VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado)     REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

CREATE TABLE construccion(
	id_construccion VARCHAR(10) NOT NULL PRIMARY KEY,
    respuesta                  BOOLEAN,
    id_jurado       VARCHAR(6) NOT NULL,
    id_equipo   VARCHAR(10) NOT NULL,
    FOREIGN KEY(id_jurado) REFERENCES jurado(id) ON DELETE CASCADE on update cascade,
    FOREIGN KEY(id_equipo) REFERENCES equipo(id_equipo) on delete cascade on update cascade
);

-- Vistas 
-- Todos los sedes
create or replace view sedes as
select nombre as nombre, direccion as direccion from sede;

-- Todos los jueces
create or replace view jueces as 
select nombre as nombres, apellido1 as apellidoP, apellido2 as apellidoM, nivel_academico as estudios, institucion as institucion
from juez;

-- Todas las escuelas
create or replace view escuelas as 
select nombre as nombre, nivel as nivelEscolar from institucion;

-- Todos los eventos
create or replace view eventos as
select nombre as nombre, fecha_inicio as fInicio, fecha_fin as fFin, nombre_sede as sede from evento;

-- Todas las categorias 
create view equipos_categoria as 
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria from equipo group by nombre, categoria; 

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
create procedure alta_evento (nombreEv varchar(50), fechaIEv date, fechaFEv date, nombre_sede varchar(50), direccion_sede varchar(50), out mensaje varchar (50))
begin
	if exists (select nombre, fecha_inicio, fecha_fin from evento where nombre = nombreEv and fecha_inicio = fechaIEv and fecha_fin = fechaFEv)then
		set mensaje = "Evento existente o fecha ocupada";
	else 
		if exists (select nombre, direccion from sede where nombre = nombre_sede) then
			insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
            set mensaje = "Evento creado sede existente";
        else
        insert into sede values (nombre_sede, direccion_sede);
		insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
        
        set mensaje = "Evento creado exitosamente sede no creada";
		end if;
    end if;
end //
delimiter ;

call alta_evento ("Prueba1", "2023-10-11", "2023-10-12", "Unidad deportiva tampico", "Calle prueba" , @mensaje);
select * from evento;
select * from sede;
select @mensaje;
delete from sede;

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
        select mensaje as resultado;
    else 
		insert into sede values (nombreSede, direccionSede);
        set mensaje  = "Sede agregada exitosamente";
        select mensaje as resultado;
    end if;
end //
delimiter ;

call alta_sede ('Instituto tenconologico de ciudad madero', "madero", @mensaje);
select @mensaje;
select * from sede;
-- Baja sede

drop procedure baja_sede

delimiter //
create procedure baja_sede (nombreSede varchar(50), out mensaje varchar(50))
begin
	if exists (select nombre from sede where nombre = nombreSede) then
		delete from sede where nombre = nombreSede;
        set mensaje  = "Sede elimnada exitosamente";
		select mensaje as resultado;
    else 
		set mensaje = "Sede no existe";
        select mensaje as resultado;
    end if;
end //
delimiter ;

-- Modificar sede

-- Institucion
-- Alta institucion
drop procedure alta_institucion;
delimiter //
create procedure alta_institucion (correoIns varchar(50), contrasenaIns varchar(50), nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), direccion varchar(50), out mensaje varchar(100))
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

call alta_institucion ('colegioTiyoli@gmail.com', "1234", "Colegio Tiyoli", "Primaria", "Nardo 150", @mensaje);
select @mensaje;
select * from institucion;
select * from usuario;

-- Baja institucion
drop procedure baja_institucion;
delimiter //
create procedure baja_institucion (correoIns varchar(50), nombreIns varchar(50), nivelIns enum("Primaria", "Secundaria", "Bachillerato", "Profesional"), out mensaje varchar(100))
begin
		if exists(select correo, contraseña from usuario where correo = correoIns) then
            delete from usuario where correo = correoIns;
            delete from institucion where nombre = nombreIns and nivel = nivelIns;
            set mensaje = "Instituto eliminado correctamente";
		else 
            set mensaje = "Instituto no existente";
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

call alta_juez ('nestor@prointernet.mx', "1234","PEPO","Balderas","Soto","Laguna de champayan 305H","Profesional", "Harvard", @mensaje);
call alta_juez ('netoilluminati258@gmail.com', "1234","pepe","Balderas","Soto","Laguna de champayan 305H","Profesional", "Harvard", @mensaje);
select @mensaje;
select * from juez;
select * from usuario;

-- baja
drop procedure baja_juez;
delimiter //
create procedure baja_juez (correoJ varchar(50), nombreJ varchar(30), apellido1J varchar(30), apellido2J varchar(30), out mensaje varchar(100))
begin
		if exists(select correo, contraseña from usuario where correo = correoJ) then
            delete from usuario where correo = correoJ;
            delete from juez where nombre = nombreJ and apellido1 = apellido1J and apellido2 = apellido2J;
            set mensaje = "Juez eliminado correctamente";
		else 
            set mensaje = "Juez no existente";
		end if;
end //
delimiter ;

call baja_juez ('netoilluminati258@gmail.com', "pepe","Balderas", "Soto", @mensaje);
select @mensaje;
select * from juez;
select * from usuario;

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
