SELECT 'author' AS "profession", "name" FROM "translators"
UNION
SELECT 'translator' AS "profession", "name" FROM "authors";