-- Procedimientos almacenados
-- Eventos
-- Alta eventos
drop procedure alta_evento;

delimiter //
create procedure alta_evento (nombreEv varchar(50), fechaIEv date, fechaFEv date, nombre_sede varchar(50), direccion_sede varchar(50), out mensaje varchar (50))
begin
	if exists (select nombre, fecha_inicio, fecha_fin from evento where nombre = nombreEv and fecha_inicio = fechaIEv and fecha_fin = fechaFEv)then
		set mensaje = "Evento existente o fecha ocupada";
	else 
		if exists (select nombre, direccion from sede where nombre = nombre_sede) then
			insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
        else
        insert into sede values (nombre_sede, direccion_sede);
		insert into evento values (nombreEv, fechaIEv, fechaFEV, nombre_sede);
        
        set mensaje = "Evento creado exitosamente";
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
-- Baja sede
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