-- Begin with initiating the sequence for IDs regarding the captains, team, team mates, locations and declarations

-- SEQUENCE: public.captain_id_seq
-- DROP SEQUENCE IF EXISTS public.captain_id_seq;


-- captain IDs

CREATE SEQUENCE IF NOT EXISTS public.captain_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.captain_id_seq
-- will have to update the OWNER
    OWNER TO postgres;

-- team IDs

CREATE SEQUENCE IF NOT EXISTS public.team_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.captain_id_seq
    OWNER TO postgres;

-- team mate IDs

CREATE SEQUENCE IF NOT EXISTS public.team_mate_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.captain_id_seq
    OWNER TO postgres;  

-- location IDs

CREATE SEQUENCE IF NOT EXISTS public.location_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.captain_id_seq
    OWNER TO postgres;

-- decalaration IDs

-- SEQUENCE: public.declaration_id_seq

-- DROP SEQUENCE IF EXISTS public.declaration_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.declaration_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.declaration_id_seq
    OWNER TO postgres;

-- Then create the databases' main tables for captains, team, team mates, locations and declarations

-- CREATE TABLE FOR TEAM MATE

CREATE TABLE public.team_mate
(
    team_mate_id integer NOT NULL,
    surname character varying,
    last_name character varying,
    team_mate_pwd character varying,
    username character varying,
    email character varying,
    CONSTRAINT "TEAMMATE_pkey" PRIMARY KEY (team_mate_id)
);

ALTER TABLE IF EXISTS public.team_mate
    OWNER to postgres;


-- CREATE TABLE FOR TEAM

CREATE TABLE public.team
(
    team_id integer NOT NULL,
    team_mate_id integer,
    team_name character varying,
    PRIMARY KEY (team_id),
    CONSTRAINT "TEAM_pkey" PRIMARY KEY (team_id),
    CONSTRAINT fk_team
        FOREIGN KEY(team_mate_id)
            REFERENCES team_mate(team_mate_id)
);

ALTER TABLE IF EXISTS public.team
    OWNER to postgres;