-- INSERT USERS

INSERT INTO public.user(
	user_last_name, user_first_name, user_email, user_login, user_password)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', 'dugrand'),
		   ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', 'sauvagneau'),
		   ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', 'dupond'),
		   ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', 'marquez'),
		   ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', 'leclerc'),
		   ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', 'lavigne'),
		   ('Lazard', 'Arnaud', 'arnaud.lazard@mail.com', 'lazard', 'lazard'),
		   ('Bain', 'Aaron', 'aaron.bain@mail.com', 'bain', 'bain'),
		   ('Valverde', 'Paul', 'paul.valverde@mail.com', 'valverde', 'valverde');

-- INSERT LOCATIONS

INSERT INTO public.locations(
	location_name, location_adress)
	VALUES ('Leroy merlin', 'Rue de Versailles, 59650 Villeneuve-d''Ascq'),
		   ('XPEHO', '1 Boulevard de Valmy, 59650 Villeneuve d Ascq'),
		   ('ADEO', '135 Rue Sadi Carnot, 59790 Ronchin');

-- INSERT OWNERS

INSERT INTO public.owner(
	owner_user_id)
	VALUES (8);

-- INSERT CUSTOMERS

INSERT INTO public.customer(
	customer_user_id,customer_owner_id,customer_location_id)
	VALUES (6,1,1),
		   (7,1,2);

-- INSERT CAPTAINS

INSERT INTO public.captain(
	captain_user_id,captain_customer_id)
	VALUES (6,1),
		   (4,2);

-- INSERT TEAM

INSERT INTO public.team(
	team_captain_id, team_name)
	VALUES (1, 'Equipe 1'),
	       (2, 'Equipe 2');

-- INSERT TEAM MATES

INSERT INTO public.team_mate(
	team_mate_team_id, team_mate_user_id)
	VALUES (1, 1),
		   (1, 2),
		   (2, 3),
		   (2, 5);

-- INSERT DECLARATIONS

INSERT INTO public.declaration(
	declaration_team_mate_id, declaration_date, declaration_status)
	VALUES -- for team_mate 1
		   (1, '2023-02-20', 'on site'),
		   (1, '2023-02-19', 'on site'),
		   (1, '2023-02-18', 'remote'),
		   (1, '2023-02-17', 'on site'),
		   (1, '2023-02-16', 'remote'),
		   -- for team_mate 2
		   (2, '2023-02-20', 'on site'),
		   (2, '2023-02-19', 'remote'),
		   (2, '2023-02-18', 'remote'),
		   (2, '2023-02-17', 'on site'),
		   (2, '2023-02-16', 'on site'),
		   -- for team_mate 3
		   (3, '2023-02-20', 'vacation'),
		   (3, '2023-02-19', 'vacation'),
		   (3, '2023-02-18', 'vacation'),
		   (3, '2023-02-17', 'vacation'),
		   (3, '2023-02-16', 'vacation'),
		   -- for team_mate 4
		   (4, '2023-02-20', 'on site'),
		   (4, '2023-02-19', 'remote'),
		   (4, '2023-02-18', 'remote'),
		   (4, '2023-02-17', 'remote'),
		   (4, '2023-02-16', 'remote');