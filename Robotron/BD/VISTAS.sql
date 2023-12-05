USE evaluacionprototipos;

-- Vistas 

-- Reporte de cada equipo por categorías y de que institución vienen 
-- (Evento x Tiene tantos equipos (equipo a institución a ….. Equipo n ,Institución n ), se puede filtrar por categoría).
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
create view equipos_puntaje as 
select nombre as Equipo, nombre_institucion as Escuela, categoria as Categoria

-- Reporte de que equipos faltaron (ANALIZAR BASE DE DATOS)
