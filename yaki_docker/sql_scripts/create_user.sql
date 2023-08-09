export const createUser = `do \
$$ \
Begin \
  IF NOT EXISTS (SELECT * FROM pg_user WHERE usename = 'yaki') THEN \
  CREATE ROLE yaki WITH \
    LOGIN \
    NOSUPERUSER \
    INHERIT \
    NOCREATEDB \
    NOCREATEROLE \
    NOREPLICATION \
    PASSWORD 'yaki'; \
  END IF; \
END \
$$ \
;`