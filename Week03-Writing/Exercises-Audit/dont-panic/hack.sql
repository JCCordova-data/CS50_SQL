-- First block, update the admin password so that it may be the same as emily33's password: 44bf025d27eea66336e5c1133c3827f7
UPDATE "users"
SET "password" = (
    SELECT "password" FROM "users"
    WHERE "username" = 'emily33'
)
WHERE "username" = 'admin';

-- Second block, update the admin password to "oops!" hashed
UPDATE "users"
SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username" = 'admin';

-- Thirs bloc, delete the hints
DELETE FROM "user_logs"
WHERE "new_password" = '982c0381c279d139fd221fce974916e7';