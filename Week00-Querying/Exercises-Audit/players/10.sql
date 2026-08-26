SELECT "first_name" AS "Nombre", "last_name" AS "Apellido", "weight" AS "Peso_Libras", "height" AS "Estatura" FROM "players"
WHERE "birth_country" = 'Peru'
ORDER BY "first_name", "last_name";