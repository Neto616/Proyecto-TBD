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