
/*1. Obtener los datos completos de los empleados.*/
select * from empleados;
/*2. Obtener los datos completos de los departamentos. */
select * from departamentos;
/*3. Listar el nombre de los departamentos. */
select nombre_depto from departamentos; 
/*4. Obtener el nombre y salario de todos los empleados. */
select nombre,sal_emp from empleados;
/*5. Listar todas las comisiones. */
select nombre, comision_emp from empleados;
/*6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’. */
select * from empleados where cargo_emp = 'secretaria';
/* 7. Obtener los datos de los empleados vendedores, ordenados por nombre
alfabéticamente.*/
select * from empleados
where cargo_emp = 'vendedor'
 order by nombre asc;
 /*8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a
mayor.*/
select cargo_emp, nombre, sal_emp from empleados
order by sal_emp;
/*9-Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad
de “Ciudad Real”*/
select nombre_jefe_depto, ciudad from departamentos where ciudad ='Ciudad Real';
/*10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las
respectivas tablas de empleados.*/
select nombre, cargo_emp as cargo from empleados;
/*11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado
por comisión de menor a mayor.*/
select sal_emp, comision_emp, d.id_depto
from departamentos d, empleados e
where d.id_depto = e.id_depto 
and d.id_depto = 2000
order by e.comision_emp asc;
/*12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético.*/
select  nombre, (sal_emp+ comision_emp+500)as 'total a pagar'
from departamentos d, empleados e 
where d.id_depto = e.id_depto
and d.id_depto=3000
order by e.nombre asc;
/*13. Muestra los empleados cuyo nombre empiece con la letra J.*/
select nombre from empleados
where nombre like 'J%' ;
/*14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
empleados que tienen comisión superior a 1000.*/
select nombre, comision_emp, (comision_emp + sal_emp) AS 'sueldoTotal'
from empleados
where comision_emp > 1000;
/*15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión.*/
select nombre, comision_emp, (comision_emp + sal_emp) AS 'sueldoTotal'
from empleados
where comision_emp = 'null' or comision_emp = 0;
/*16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.*/
select * 
from empleados
where comision_emp > sal_emp;
/*17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.*/
select * 
from empleados
where comision_emp <= sal_emp*0.3;
/*18. Hallar los empleados cuyo nombre no contiene la cadena “MA”*/
select * 
from empleados
where nombre not like '%MA%';
/*19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento.*/
select * from departamentos
where nombre_depto = 'Ventas' or
nombre_depto = 'Investigacion' or
nombre_depto = 'Mantenimiento';
/*where nombre_depto in ('ventas', 'Investigacion', 'Mantenimiento');*/
/*20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.*/

select * from departamentos
/*where nombre_depto != 'Ventas' or
nombre_depto != 'Investigacion' or
nombre_depto != 'Mantenimiento';*/
where nombre_depto not in ('ventas', 'Investigacion', 'Mantenimiento');
/*21. Mostrar el salario más alto de la empresa.*/
select *
from empleados
where sal_emp = (select max(sal_emp) from empleados);
select MAX(sal_emp) 
from empleados;
/*22. Mostrar el nombre del último empleado de la lista por orden alfabético.*/
select * 
from empleados
order by nombre desc
limit 2;
/*23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.*/

select max(sal_emp) as salarioMaximo, min(sal_emp) as salarioMinimo, 
(max(sal_emp)-min(sal_emp)) as diferencia 
from empleados;

/*24. Hallar el salario promedio por departamento.*/

select round(AVG(e.sal_emp))as 'promedio salario', d.nombre_depto 
from empleados e, departamentos d
where e.id_depto = d.id_depto
group by d.nombre_depto;

SELECT d.nombre_depto, AVG(e.sal_emp) AS promedio_salario
FROM empleados e 
INNER JOIN departamentos d ON e.id_depto = d.id_depto
GROUP BY d.nombre_depto;
/*-----HAVING----------*/
/*25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos.*/
select d.id_depto,count(*) as numeroEmpleados
from empleados e, departamentos d
where e.id_depto= d.id_depto
group by d.id_depto
having count(*)>3 ;
/*26. Hallar los departamentos que no tienen empleados*/
select d.id_depto,count(*) as numeroEmpleados
from empleados e, departamentos d
where e.id_depto= d.id_depto
group by d.id_depto
having count(*)=0 or count(*)= null ;

/*27. Mostrar la lista de empleados, con su respectivo departamento y el jefe de cada
departamento.*/
select e.id_emp, e.nombre,d.nombre_depto, d.nombre_jefe_depto from empleados e
left outer join departamentos d
on e.id_depto = d.id_depto;
/*28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento. */
SELECT e.nombre, e.sal_emp, d.nombre_depto
FROM empleados e
INNER JOIN departamentos d ON e.id_depto = d.id_depto
WHERE e.sal_emp >= (SELECT AVG(sal_emp) FROM empleados)
ORDER BY d.nombre_depto;
SELECT round(AVG(sal_emp)) FROM empleados;
