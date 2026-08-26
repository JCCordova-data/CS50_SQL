SELECT "english_title" AS "Top 10 Least Brightness Hokusai's Prints", "brightness" FROM "views"
WHERE "artist" = 'Hokusai'
ORDER BY "brightness" ASC
LIMIT 10;