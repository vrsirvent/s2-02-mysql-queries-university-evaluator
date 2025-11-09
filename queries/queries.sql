-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades. (nombre, apellido1, apellido2)
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Retorna el llistat dels alumnes que van néixer en 1999. (id, nombre, apellido1, apellido2, fecha_nacimiento)
SELECT id, nombre, apellido1, apellido2, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;


-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K. (nombre, apellido1, apellido2, nif)
SELECT nombre, apellido1, apellido2, nif FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7. (id, nombre, cuatrimestre, curso, id_grado)
SELECT id, nombre, cuatrimestre, curso, id_grado FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom. (apellido1, apellido2, nombre, departamento)
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS departamento FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M. (nombre, anyo_inicio, anyo_fin)
SELECT asignatura.nombre, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura AS am JOIN asignatura ON am.id_asignatura = asignatura.id JOIN curso_escolar AS ce ON am.id_curso_escolar = ce.id JOIN persona ON am.id_alumno = persona.id WHERE persona.nif = '26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015). (nombre)
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_grado = 4;

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019. (nombre, apellido1, apellido2)
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2 FROM alumno_se_matricula_asignatura AS am JOIN persona ON am.id_alumno = persona.id JOIN curso_escolar AS ce ON am.id_curso_escolar = ce.id WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
-- 10. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. (departamento, apellido1, apellido2, nombre)
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

-- 11. Retorna un llistat amb els professors/es que no estan associats a un departament. (apellido1, apellido2, nombre)
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' AND departamento.id IS NULL;

-- 12. Retorna un llistat amb els departaments que no tenen professors/es associats. (nombre)
SELECT departamento.nombre FROM profesor RIGHT JOIN departamento ON profesor.id_departamento = departamento.id WHERE profesor.id_profesor IS NULL;

-- 13. Retorna un llistat amb els professors/es que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM asignatura RIGHT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor RIGHT JOIN persona ON profesor.id_profesor = persona.id WHERE persona.tipo = 'profesor' AND asignatura.id IS NULL;

-- 14. Retorna un llistat amb les assignatures que no tenen un professor/a assignat. (id, nombre)
SELECT asignatura.id, asignatura.nombre FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL;

-- 15. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar. (nombre)
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id IS NULL;

-- 16. Retorna el nombre total d'alumnes que hi ha. (total)
SELECT COUNT(*) AS total FROM persona WHERE tipo = 'alumno';

-- 17. Calcula quants alumnes van néixer en 1999. (total)
SELECT COUNT(*) AS total FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 18. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es. (departamento, total)
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS total FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY total DESC;

-- 19. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. (departamento, total)
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS total FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY departamento;

-- 20. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures. (grau, total)
SELECT grado.nombre AS grau, COUNT(asignatura.id) AS total FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY total DESC;

-- 21. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades. (grau, total)
SELECT grado.nombre AS grau, COUNT(asignatura.id) AS total FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40 ORDER BY Total DESC;

-- 22. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. (grau, tipus, total_creditos)
SELECT grado.nombre AS grau, asignatura.tipo AS tipus, SUM(asignatura.creditos) AS total_creditos FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo ORDER BY grado.nombre, asignatura.tipo;

-- 23. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats. (anyo_inicio, total)
SELECT ce.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS total FROM curso_escolar AS ce LEFT JOIN alumno_se_matricula_asignatura AS am ON ce.id = am.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY ce.anyo_inicio;

-- 24. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures. (id, nombre, apellido1, apellido2, total)
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id) AS total FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE persona.tipo = 'profesor' GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2 ORDER BY total DESC;

-- 25. Retorna totes les dades de l'alumne/a més jove. (*)
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona WHERE tipo = 'alumno');

-- 26. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura. (apellido1, apellido2, nombre)
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
