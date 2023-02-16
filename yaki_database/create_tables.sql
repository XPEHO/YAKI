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
