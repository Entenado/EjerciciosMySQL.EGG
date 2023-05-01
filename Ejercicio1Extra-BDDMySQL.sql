/*------A continuación, se deben realizar las siguientes consultas sobre la base de datos:----------*/
/*MYSQL ----------------- NBA*/
/*1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/
select nombre from jugadores
order by nombre asc;
/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/
select * from jugadores
where Posicion = 'c' 
and Peso > 250
order by Nombre asc;
/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/
select nombre from equipos
order by nombre asc;
/*4. Mostrar el nombre de los equipos del este (East).*/
select nombre from equipos
where ciudad = 'East';
/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
select * from equipos 
where ciudad like 'c%';
/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/
select * from jugadores
order by Nombre_equipo asc;
/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/
select * from jugadores 
where Nombre_equipo = 'Raptors'
order by Nombre asc;
/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.*/
select Puntos_por_partido, jugador, temporada from
estadisticas
where jugador = (select codigo from jugadores
where nombre = 'Pau Gasol');
/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
select Puntos_por_partido from
estadisticas
where jugador = (select codigo from jugadores
where nombre = 'Pau Gasol' and temporada = '04/05') ;
/*10. Mostrar el número de puntos de cada jugador en toda su carrera.*/

SELECT nombre, 
       (SELECT SUM(Puntos_por_partido) 
        FROM estadisticas 
        WHERE estadisticas.jugador = jugadores.codigo) as puntos_totales 
FROM jugadores;
/*11. Mostrar el número de jugadores de cada equipo.*/
select count(Nombre_equipo)as 'numero de jugadores', Nombre_equipo 
from jugadores
group by Nombre_equipo;
/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/

SELECT nombre, 
       (SELECT SUM(Puntos_por_partido)
        FROM estadisticas 
        WHERE estadisticas.jugador = jugadores.codigo) as Puntos_totales,
        (select MAX(Puntos_por_partido)
        from estadisticas
        where estadisticas.jugador = jugadores.codigo) as max_puntos
FROM jugadores;
/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
select j.nombre_equipo, e.Conferencia, e. Division,
(select nombre from jugadores 
where max(altura))
from jugadores j, equipos e;

SELECT j.nombre_equipo, e.Conferencia, e.Division, 
(SELECT nombre FROM jugadores 
    WHERE altura = (SELECT MAX(altura) FROM jugadores 
    where j.Nombre_equipo) = (SELECT e.Nombre from equipos)) AS jugador_mas_alto
FROM jugadores j, equipos e
LIMIT 1;

/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
select avg(es.Puntos_por_partido)as promedioPorPartido, eq.Division 
from estadisticas es , equipos eq
where eq.Division = 'Pacific'
group by eq.Division;

/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/

SELECT equipo_local, equipo_visitante, MAX((puntos_local - puntos_visitante)) as 'PuntosTotales'
FROM partidos
GROUP BY equipo_local, equipo_visitante
order by MAX((puntos_local - puntos_visitante)) desc
limit 1;

/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/

select AVG(es.Puntos_por_partido) as 'promedioPuntosPorPartido' from estadisticas es
join equipos eq on es.Puntos_por_partido
where eq.Division = 'Pacific';
/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.*/
SELECT eq1.Nombre, eq2.Nombre, puntos_visitante
from partidos p
join equipos eq1 on p.equipo_visitante
join equipos eq2 on p.equipo_local;
select * from partidos;
SELECT e1.nombre AS equipo_local, e2.nombre AS equipo_visitante, p.puntos_local, p.puntos_visitante
FROM partidos p
JOIN equipos e1 ON p.id_equipo_local = e1.id_equipo
JOIN equipos e2 ON p.id_equipo_visitante = e2.id_equipo;
/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/
select codigo, equipo_local, equipo_visitante,
(select puntos_local - puntos_visitantes from jugadores) as 'equipoGanador'
from jugadores;

SELECT codigo, equipo_local, equipo_visitante, puntos_local, puntos_visitante,
       CASE
           WHEN puntos_local > puntos_visitante THEN equipo_local
           WHEN puntos_local < puntos_visitante THEN equipo_visitante
           ELSE NULL
       END AS equipo_ganador
FROM partidos;