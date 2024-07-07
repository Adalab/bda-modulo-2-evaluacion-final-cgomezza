USE sakila

-- Ejercicio 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Selecciona de forma unica los titulos desde table FILM
SELECT DISTINCT title
FROM film;

-- Ejercicio 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"
-- Selecciona de forma unica desde la table FILM, donde aparezaca rating PG-13
SELECT DISTINCT title
FROM film
WHERE rating = "PG-13";

-- Ejercicio 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Selecciona tituto y descrpcion de la table film, cuando en la descrpcion aparezca la palabra amazing
SELECT title, description
FROM film
WHERE description LIKE ("%amazing%");

-- Ejercicio 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Selecciona de forma unica el titulo desde la tabla film, donde la duranción sea mayor que 120.
SELECT DISTINCT title
FROM film
WHERE length > 120;

-- Ejercicio 5. Recupera los nombres de todos los actores.
-- Selecciona nombre y apellidos de la tabla actores.
SELECT first_name, last_name
FROM actor;

-- Ejercicio 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- Selecciona nombre y apeliidos de la table actores cuando el last_name sea gibson
SELECT first_name, last_name
FROM actor
WHERE last_name = ("GIBSON");

-- Ejercicio 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Selecciona la id actor y nombre, desde la tabla actor, cuando el ID del actor entre comprendido entre 10 y 20.
SELECT actor_id, first_name
FROM actor
WHERE actor_id >=10 AND actor_id <=20;

-- Ejercicio 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Selecciona el titulo de la tabla film, cuando en la columna rating no aparezca R o PG-13.
SELECT title
FROM film
WHERE rating NOT IN ("R", "PG-13");

-- Ejercicio 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.alter
-- Selecciona rating contabilizandolo  de la tabla film y agrupalo por ratings.
SELECT rating, COUNT(*) as count
FROM film
GROUP BY rating;

-- Ejercicio 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Selecciona el id, nombre y apellido del cliente de la tabla clientes y juntalo con la table rental atraves de la columna customer id. Agrupalo por cliente.
SELECT c.customer_id, c.first_name, c.last_name 
FROM customer AS c

INNER JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- Ejercicio 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT 


--  12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
-- Selecciona el rating calculando el promedio de la tabla film y agrupalo por rating.
SELECT rating, AVG(length) AS average_length
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- Selecciona nombre y apellidos de la tabla actores y unelo a la tabla film, a traves del film.id cuando el titulo sea "indian love"
SELECT a.first_name, a.last_name 
FROM actor AS a

INNER JOIN film AS f
ON f.film_id = f.film_id
WHERE f.title = ("Indian Love");

-- 14.  Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- Selecciona el titulo de la tabla pelicula de la tabla film, cuando en la descrpcion aparezca como "dog" o "cat"
SELECT title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

-- 15 . Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
-- Selecciona id actor, nombre y apellidos de actor, uniendolo con film actor pot actor.id. y buscar donde el id.actor is NULL.
SELECT  a.actor_id, a.first_name, a.last_name
FROM actor AS a

LEFT JOIN film_actor 
ON a.actor_id = film_actor.actor_id
WHERE a.actor_id IS NULL;


-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- Selecciona el titulo de la tabla film de las peliculas hechas entre 2005 y 2010.
SELECT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

 -- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family"
 SELECT * 
 FROM category
 -- Selecciona el titulo de la pelicula desde la tabla film, y unelo a traves de film.id con la tabla film category. Y ahora une la tabla category a traves de la columna category y id. Y una vez creado, busca los datos donde el category name sea Family
 
SELECT film.title
FROM film

INNER JOIN film_category 
ON film.film_id = film_category.film_id

INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- 18.  Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- Seleccionamos el nombre y apellido de la tabla actor, y lo unimos con un inner join a través de la columna actor ID. lo agrupamos y de ese grupo seleccionamos contabilizando los que tienen mas de 10 peliculas.

SELECT a.first_name, a.last_name
FROM actor AS a

INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
-- Selecionamos el titulo de las peliculas en la tabla FILM que rating sea = a R y que la duracion sea mayor que 120.

SELECT title
FROM film
WHERE rating = 'R' AND length > 120;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
 --  Necesitamos el nombre, y el promedio, entonces ponemos SELECT, y buscamos las comlumnas en comun, para la categoria unimos por category:id de la tabla category y film_ category.
 --  y para la duracion la sacamos de la tabla film y la unimos con film category a traves de la columna film.id. Y lo agrupamos por el nombre de la categoria. Ponemos la condicion de que sea mas de 120min.
SELECT * 
FROM category;

SELECT name AS nombre, AVG(f.length) AS promedio
FROM category AS c

INNER JOIN film_category AS fc
ON c.category_id = fc.category_id

INNER JOIN film AS f
ON fc.film_id = f.film_id

GROUP BY c.name
HAVING AVG(f.length) > 120;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

SELECT *
FROM actor;
SELECT *
FROM film_actor;

-- Utilizamos actor id para unir las tablas fil actor y actor, lo agrupamos por el actor y le pedimos que nos cuente solo los que tienen 5 o mas peliculas.

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS count
FROM actor AS a

INNER JOIN film_actor as fa
ON a.actor_id = fa.actor_id

GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;

-- 22.  Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.


-- 23.  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores


-- BONUS 24. : Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
 -- Necesitamos el titulo de la tabla FILM y a traves de film_id lo unimos con la tabla category_film, con los datos que coincidan en ambas tablas, y hacemos lo mismo con category_id. Y le especificamso que solo 
 -- necesitamos las que el nombre de la categoria sea Comedy de la tabla category y de la tabla film sea > 180 min. 
SELECT f.title
FROM film AS f

INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id

INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;
