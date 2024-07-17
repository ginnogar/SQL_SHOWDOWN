-- PRIMER Ejercicio
/* ★ Selecciona las columnas DisplayName, Location y Reputation de los usuarios con mayor
reputación. Ordena los resultados por la columna Reputation de forma descendente y
presenta los resultados en una tabla mostrando solo las columnas DisplayName,
Location y Reputation. 
Seleccionar los nombres, ubicaciones y reputaciones de los usuarios con la mayor reputación, 
ordenados de mayor a menor reputación. */

SELECT TOP (200) DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

-- SEGUNDO Ejercicio
/* ★ Selecciona la columna Title de la tabla Posts junto con el DisplayName de los usuarios
que lo publicaron para aquellos posts que tienen un propietario.
Para lograr esto une las tablas Posts y Users utilizando OwnerUserId para obtener el
nombre del usuario que publicó cada post. Presenta los resultados en una tabla
mostrando las columnas Title y DisplayName 
Seleccionar los títulos de las publicaciones y los nombres de los usuarios que las publicaron. */

SELECT TOP (200) Posts.Title, Users.DisplayName
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
Where Posts.OwnerUserId IS NOT NULL; /* Where: Filtrar */

-- TERCER Ejercicio
/* ★ Calcula el promedio de Score de los Posts por cada usuario y muestra el DisplayName
del usuario junto con el promedio de Score.
Para esto agrupa los posts por OwnerUserId, calcula el promedio de Score para cada
usuario y muestra el resultado junto con el nombre del usuario. Presenta los resultados
en una tabla mostrando las columnas DisplayName y el promedio de Score
Calcular el promedio de puntuación de los posts por cada usuario y mostrar su nombre junto con el promedio de puntuación. */

SELECT TOP (200) Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL
GROUP BY Users.DisplayName
ORDER BY AverageScore DESC;


-- CUARTO Ejercicio
/* Encuentra el DisplayName de los usuarios que han realizado más de 100 comentarios
en total. Para esto utiliza una subconsulta para calcular el total de comentarios por
usuario y luego filtra aquellos usuarios que hayan realizado más de 100 comentarios en
total. Presenta los resultados en una tabla mostrando el DisplayName de los usuarios */
/* Encontrar los nombres de los usuarios que han realizado más de 100 comentarios en total. */

SELECT TOP (200) Users.DisplayName
FROM Users
WHERE (SELECT COUNT(*) FROM Comments WHERE Comments.UserId = Users.Id) > 100;

-- QUINTO Ejercicio
/* Actualiza la columna Location de la tabla Users cambiando todas las ubicaciones vacías
por "Desconocido". Utiliza una consulta de actualización para cambiar las ubicaciones
vacías. Muestra un mensaje indicando que la actualización se realizó correctamente. 
Actualizar la columna Location de la tabla Users cambiando todas las ubicaciones vacías por "Desconocido". */

UPDATE Users /* Update = Actualizar */
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = '';
-- Mostrar mensaje de confirmación
PRINT 'La actualización se realizó correctamente.';    
-- PARA VER
SELECT TOP (200) Id, DisplayName, Location
FROM Users
WHERE Location = 'Desconocido';


-- SEXTO Ejercicio
/* ★ Elimina todos los comentarios realizados por usuarios con menos de 100 de reputación.
Utiliza una consulta de eliminación para eliminar todos los comentarios realizados y
muestra un mensaje indicando cuántos comentarios fueron eliminados 
Eliminar comentarios de usuarios con menos de 100 de reputación */
-- Eliminar comentarios realizados por usuarios con menos de 100 de reputación
DELETE Comments
FROM Comments
WHERE
    UserId IN (SELECT Id FROM Users WHERE Reputation < 100);
-- Mostrar mensaje de confirmación con número de filas eliminadas
PRINT 'Número de comentarios eliminados: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));


-- SEPTIMO Ejercicio
/* Para cada usuario, muestra el número total de publicaciones (Posts), comentarios
(Comments) y medallas (Badges) que han realizado. Utiliza uniones (JOIN) para combinar
la información de las tablas Posts, Comments y Badges por usuario. Presenta los
resultados en una tabla mostrando el DisplayName del usuario junto con el total de
publicaciones, comentarios y medallas.
Número total de publicaciones, comentarios y medallas por usuario */
-- Seleccionar el DisplayName del usuario y contar el número de posts, comentarios y medallas
SELECT TOP 200
    Users.DisplayName,
    (SELECT COUNT(*) FROM Posts WHERE OwnerUserId = u.Id) AS TotalPosts,
    (SELECT COUNT(*) FROM Comments WHERE UserId = u.Id) AS TotalComments,
    (SELECT COUNT(*) FROM Badges WHERE UserId = u.Id) AS TotalBadges
FROM 
    Users 
ORDER BY 
    TotalPosts DESC, Users.DisplayName;

-- OCTAVO Ejercicio
/* Muestra las 10 publicaciones más populares basadas en la puntuación (Score) de la
tabla Posts. Ordena las publicaciones por puntuación de forma descendente y
selecciona solo las 10 primeras. Presenta los resultados en una tabla mostrando el Title
de la publicación y su puntuación
Las 10 publicaciones más populares */
SELECT TOP 10 Title, Score
FROM Posts
WHERE Title IS NOT NULL
ORDER BY Score DESC

-- NOVENO Ejercicio
/* ★ Muestra los 5 comentarios más recientes de la tabla Comments. Ordena los comentarios
por fecha de creación de forma descendente y selecciona solo los 5 primeros. Presenta
los resultados en una tabla mostrando el Text del comentario y la fecha de creación
Los 5 comentarios más recientes */
SELECT TOP 5 Text, CreationDate
  FROM Comments
  ORDER BY 
    CreationDate DESC