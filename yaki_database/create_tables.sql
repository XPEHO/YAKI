-- Begin with initiating the sequence for IDs regarding the users, captains, teams, team mates, locations and declarations

-- CREATE USER IDs

CREATE SEQUENCE IF NOT EXISTS public.user_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.user_id_seq
    OWNER TO yaki;


-- CREATE CAPTAIN IDs

CREATE SEQUENCE IF NOT EXISTS public.captain_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.captain_id_seq
    OWNER TO yaki;


-- CREATE TEAM IDs

CREATE SEQUENCE IF NOT EXISTS public.team_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.team_id_seq
    OWNER TO yaki;


-- CREATE TEAM MATE IDs

CREATE SEQUENCE IF NOT EXISTS public.team_mate_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.team_mate_id_seq
    OWNER TO yaki;  


-- CREATE LOCATION IDs

CREATE SEQUENCE IF NOT EXISTS public.location_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.location_id_seq
    OWNER TO yaki;


-- CREATE DECLARATION IDs

CREATE SEQUENCE IF NOT EXISTS public.declaration_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.declaration_id_seq
    OWNER TO yaki;

-- Then create the databases' main tables for captains, team, team mates, locations and declarations

-- CREATE TABLE FOR USERS

CREATE TABLE IF NOT EXISTS public."user"
(
    user_id integer NOT NULL DEFAULT nextval('user_id_seq'::regclass),
    user_last_name character varying(100) COLLATE pg_catalog."default",
    user_first_name character varying(100) COLLATE pg_catalog."default",
    user_email character varying(100) COLLATE pg_catalog."default",
    user_login character varying(100) COLLATE pg_catalog."default",
    user_password character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT user_pkey PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."user"
    OWNER to yaki;


-- CREATE TABLE FOR CAPTAINS

CREATE TABLE IF NOT EXISTS public.captain
(
    captain_id integer NOT NULL DEFAULT nextval('captain_id_seq'::regclass),
    captain_user_id integer,
    CONSTRAINT "CAPTAIN_pkey" PRIMARY KEY (captain_id),
    CONSTRAINT captain_user_id_fkey FOREIGN KEY (captain_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.captain
    OWNER to yaki;

-- CREATE TABLE FOR TEAMS

CREATE TABLE IF NOT EXISTS public.team
(
    team_id integer NOT NULL DEFAULT nextval('team_id_seq'::regclass),
    team_captain_id integer,
    team_name character varying COLLATE pg_catalog."default",
    CONSTRAINT "TEAM_pkey" PRIMARY KEY (team_id),
    CONSTRAINT fk_captain FOREIGN KEY (team_captain_id)
        REFERENCES public.captain (captain_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.team
    OWNER to yaki;
	

--- CREATE TABLE FOR TEAM MATES

CREATE TABLE IF NOT EXISTS public.team_mate
(
    team_mate_id integer NOT NULL DEFAULT nextval('team_mate_id_seq'::regclass),
    team_mate_team_id integer NOT NULL,
    team_mate_user_id integer,
    CONSTRAINT "TEAM_MATE_pkey" PRIMARY KEY (team_mate_id),
    CONSTRAINT team_mate_team_id_fkey FOREIGN KEY (team_mate_team_id)
        REFERENCES public.team (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT team_mate_user_id_fkey FOREIGN KEY (team_mate_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.team_mate
    OWNER to yaki;

-- CREATE TABLE FOR LOCATIONS

CREATE TABLE IF NOT EXISTS public.locations
(
    location_id integer NOT NULL DEFAULT nextval('location_id_seq'::regclass),
    location_name character varying(100) COLLATE pg_catalog."default",
    location_adress character varying(250) COLLATE pg_catalog."default",
    CONSTRAINT locations_pkey PRIMARY KEY (location_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.locations
    OWNER to yaki;


-- CREATE TABLE FOR DECLARATIONS

CREATE TABLE IF NOT EXISTS public.declaration
(
    declaration_id integer NOT NULL DEFAULT nextval('declaration_id_seq'::regclass),
    declaration_team_mate_id integer NOT NULL,
    declaration_date timestamp with time zone,
    declaration_status character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT declaration_pkey PRIMARY KEY (declaration_id),
	CONSTRAINT declaration_team_mate_id_fkey FOREIGN KEY (declaration_team_mate_id)
		REFERENCES public.team_mate (team_mate_id) MATCH SIMPLE
		ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.declaration
    OWNER to yaki;