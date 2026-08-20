-- 1. FILTRADO BÁSICO Y MÚLTIPLE (Precedencia con paréntesis)
SELECT "title", "format" 
FROM "longlist" 
WHERE ("year" = 2022 OR "year" = 2023) AND "format" != 'hardcover';

-- 2. OPERADORES DE RANGO (BETWEEN)
SELECT "title", "year" 
FROM "longlist"
WHERE "year" BETWEEN 2019 AND 2022;

-- 3. FILTRADO DE VALORES NULOS Y PATRONES DE TEXTO
-- 'LIKE' ignora case sensitivity. '%' es comodín universal.
SELECT "title", "translator" 
FROM "longlist"
WHERE "translator" IS NULL OR "title" LIKE 'The %';

-- 4. ORDENAMIENTO (ORDER BY) Y LÍMITES
-- Ordena primero por rating (mayor a menor) y luego desempata por votos.
SELECT "title", "rating", "votes" 
FROM "longlist"
ORDER BY "rating" DESC, "votes" DESC
LIMIT 10;

-- 5. FUNCIONES DE AGREGACIÓN MATEMÁTICA
SELECT ROUND(AVG("rating"), 2) AS "average_rating" FROM "longlist";
SELECT MAX("rating") AS "highest_rating" FROM "longlist";
SELECT MIN("rating") AS "lowest_rating" FROM "longlist";
SELECT SUM("votes") AS "total_votes" FROM "longlist";

-- 6. CONTEO Y VALORES ÚNICOS (DISTINCT)
-- Cuenta todas las filas vs cuenta solo los publicadores únicos
SELECT COUNT(*) FROM "longlist";
SELECT COUNT(DISTINCT "publisher") FROM "longlist";