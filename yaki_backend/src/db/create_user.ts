export const createUser = `do \
$$ \
Begin \
  IF NOT EXISTS (SELECT * FROM pg_user WHERE usename = '${process.env.DB_ROLE}') THEN \
  CREATE ROLE yaki WITH \
    LOGIN \
    NOSUPERUSER \
    INHERIT \
    NOCREATEDB \
    NOCREATEROLE \
    NOREPLICATION \
    PASSWORD '${process.env.DB_ROLE_PWD}'; \
  END IF; \
END \
$$ \
;`