-- migration script to allow team_id to be nullable, run the script on the database
ALTER TABLE public.declaration
ALTER COLUMN declaration_team_id DROP NOT NULL;