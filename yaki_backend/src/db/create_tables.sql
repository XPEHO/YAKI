-- Begin with initiating the sequence for IDs regarding the users, captains, teams, team mates, locations, declarations, owners and customers
-- CREATE USER IDs
CREATE SEQUENCE IF NOT EXISTS public.user_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.user_id_seq
    OWNER TO yaki;
CREATE SEQUENCE IF NOT EXISTS public.verification_token_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.verification_token_id_seq
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
-- CREATE OWNER IDs
CREATE SEQUENCE IF NOT EXISTS public.owner_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.owner_id_seq
    OWNER TO yaki;
-- CREATE CUSTOMER IDs
CREATE SEQUENCE IF NOT EXISTS public.customer_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.customer_id_seq
    OWNER TO yaki;
-- CREATE CUSTOMER_RIGHTS IDS
CREATE SEQUENCE IF NOT EXISTS public.customer_rights_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.customer_id_seq
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
-- CREATE DECLARATION IDs
CREATE SEQUENCE IF NOT EXISTS public.declaration_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.declaration_id_seq
    OWNER TO yaki;
-- CREATE CAPTAINS TEAMS JOIN TABLE IDS
CREATE SEQUENCE IF NOT EXISTS public.captains_teams_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.captains_teams_id_seq
    OWNER TO yaki;
-- CREATE ENTITY LOG IDS
CREATE SEQUENCE IF NOT EXISTS public.entity_log_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.entity_log_id_seq
    OWNER TO yaki;
    
-- Then create the databases' main tables for captains, team, team mates, locations and declarations
-- CREATE TABLE FOR LOGS   
CREATE TABLE IF NOT EXISTS public.entity_log(
    entity_log_id integer NOT NULL DEFAULT nextval('entity_log_id_seq'::regclass),
    entity_log_creation_date timestamp with time zone,
    entity_log_inactivation_date timestamp with time zone,
    CONSTRAINT "ENTITY_LOG_pkey" PRIMARY KEY (entity_log_id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.entity_log
    OWNER to yaki;

-- CREATE TABLE FOR USERS
CREATE TABLE IF NOT EXISTS public.user
(
    user_id integer NOT NULL DEFAULT nextval('user_id_seq'::regclass),
    user_last_name character varying(100),
    user_first_name character varying(100),
    user_email character varying(100),
    user_login character varying(100),
    user_password character varying(255),
    user_enabled boolean NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (user_id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.user
    ADD COLUMN IF NOT EXISTS user_enabled boolean DEFAULT true,
    OWNER to yaki;
-- CREATE TABLE FOR LOCATIONS
CREATE TABLE IF NOT EXISTS public.locations
(
    location_id integer NOT NULL DEFAULT nextval('location_id_seq'::regclass),
    location_name character varying(100),
    location_adress character varying(250),
    CONSTRAINT locations_pkey PRIMARY KEY (location_id)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.locations
    OWNER to yaki;
-- CREATE TABLE FOR OWNERS
CREATE TABLE IF NOT EXISTS public.owner
(
    owner_id integer NOT NULL DEFAULT nextval('owner_id_seq'::regclass),
    owner_user_id integer NOT NULL,
    CONSTRAINT "OWNER_pkey" PRIMARY KEY (owner_id),
    CONSTRAINT owner_user_id_fkey FOREIGN KEY (owner_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.owner
    OWNER to yaki;
-- CREATE TABLE FOR CUSTOMERS
CREATE TABLE IF NOT EXISTS public.customer
(
    customer_id integer NOT NULL DEFAULT nextval('customer_id_seq'::regclass),
    customer_name character varying(100),
    customer_owner_id integer NOT NULL,
    customer_location_id integer NOT NULL,
    customer_actif_flag boolean NOT NULL,
    customer_entity_log_id integer,
    CONSTRAINT "CUSTOMER_pkey" PRIMARY KEY (customer_id),
    CONSTRAINT customer_owner_id_fkey FOREIGN KEY (customer_owner_id)
        REFERENCES public.owner (owner_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT customer_location_id_fkey FOREIGN KEY (customer_location_id)
        REFERENCES public.locations (location_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT customer_entity_log_id_fkey FOREIGN KEY (customer_entity_log_id)
    REFERENCES public.entity_log (entity_log_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.customer
    OWNER to yaki;
-- CREATE TABLE FOR CUSTOMER_RIGHTS
CREATE TABLE IF NOT EXISTS public.customer_rights
(
    customer_rights_id integer NOT NULL DEFAULT nextval('customer_rights_id_seq'::regclass),
    customer_rights_user_id integer NOT NULL,
    customer_rights_customer_id integer NOT NULL,
    CONSTRAINT "CUSTOMER_RIGHTS_pkey" PRIMARY KEY (customer_rights_id),
    CONSTRAINT customer_rights_user_id_fkey FOREIGN KEY (customer_rights_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT customer_rights_customer_id_fkey FOREIGN KEY (customer_rights_customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.customer_rights
    OWNER to yaki;
-- CREATE TABLE FOR CAPTAINS
CREATE TABLE IF NOT EXISTS public.captain
(
    captain_id integer NOT NULL DEFAULT nextval('captain_id_seq'::regclass),
    captain_user_id integer NOT NULL,
    captain_customer_id integer NOT NULL,
    captain_entity_log_id integer,
    captain_actif_flag boolean NOT NULL,
    CONSTRAINT "CAPTAIN_pkey" PRIMARY KEY (captain_id),
    CONSTRAINT captain_user_id_fkey FOREIGN KEY (captain_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT captain_customer_id_fkey FOREIGN KEY (captain_customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT captain_entity_log_id_fkey FOREIGN KEY (captain_entity_log_id)
    REFERENCES public.entity_log (entity_log_id) MATCH SIMPLE
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
    team_name character varying,
    team_customer_id integer NOT NULL,
    team_actif_flag boolean NOT NULL,
    team_entity_log_id integer,
    CONSTRAINT "TEAM_pkey" PRIMARY KEY (team_id),
    CONSTRAINT fk_customer FOREIGN KEY (team_customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT team_entity_log_id_fkey FOREIGN KEY (team_entity_log_id)
    REFERENCES public.entity_log (entity_log_id) MATCH SIMPLE
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
    team_mate_user_id integer NOT NULL,
    team_mate_entity_log_id integer,
    team_mate_actif_flag boolean NOT NULL,
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
        NOT VALID,
    CONSTRAINT team_mate_entity_log_id_fkey FOREIGN KEY (team_mate_entity_log_id)
    REFERENCES public.entity_log (entity_log_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.team_mate
    OWNER to yaki;
-- CREATE TABLE FOR DECLARATIONS
CREATE TABLE IF NOT EXISTS public.declaration
(
    declaration_id integer NOT NULL DEFAULT nextval('declaration_id_seq'::regclass),
    declaration_user_id integer NOT NULL,
    declaration_date timestamp with time zone,
    declaration_date_start timestamp with time zone,
    declaration_date_end timestamp with time zone,
    declaration_status character varying(30),
    declaration_team_id integer NOT NULL,
    CONSTRAINT declaration_pkey PRIMARY KEY (declaration_id),
    CONSTRAINT declaration_user_id_fkey FOREIGN KEY (declaration_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT declaration_team_id_fkey FOREIGN KEY (declaration_team_id)
        REFERENCES public.team (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.declaration
    OWNER to yaki;
-- CREATE TABLE FOR VERIFICATION_TOKEN
CREATE TABLE IF NOT EXISTS public.verification_token
(
    verification_token_id integer NOT NULL DEFAULT nextval('verification_token_id_seq'::regclass),
    verification_token_user_id integer NOT NULL,
    expiration_date timestamp with time zone,
    token character varying(250),
    CONSTRAINT "VERIFICATION_TOKEN_pkey" PRIMARY KEY (verification_token_id),
    CONSTRAINT verification_token_user_id_fkey FOREIGN KEY (verification_token_user_id)
        REFERENCES public.user (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.verification_token
    OWNER to yaki;
CREATE TABLE IF NOT EXISTS public.captains_teams(
    captains_teams_id integer NOT NULL DEFAULT nextval('captains_teams_id_seq'::regclass),
    captains_teams_captain_id integer NOT NULL,
    captains_teams_team_id integer NOT NULL,
    CONSTRAINT "CAPTAINS_TEAMS_pkey" PRIMARY KEY (captains_teams_id),
    CONSTRAINT captains_teams_captain_id_fkey FOREIGN KEY (captains_teams_captain_id)
        REFERENCES public.captain (captain_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT captains_teams_team_id_fkey FOREIGN KEY (captains_teams_team_id)
        REFERENCES public.team (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.captains_teams
    OWNER to yaki;