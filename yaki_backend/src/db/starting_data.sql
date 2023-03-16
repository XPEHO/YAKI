-- INSERT USERS

INSERT INTO public."user"(
	user_last_name, user_first_name, user_email, user_login, user_password)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', 'dugrand'),
		   ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', 'sauvagneau'),
		   ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', 'dupond'),
		   ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', 'marquez'),
		   ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', 'leclerc'),
		   ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', 'lavigne');

-- INSERT CAPTAINS

INSERT INTO public.captain(
	captain_user_id)
	VALUES (6),
		   (4);

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

INSERT INTO public.declaration(
	declaration_team_mate_id, declaration_date, declaration_status)
	VALUES -- for team_mate 1
		   (1, '2023-02-20', 'sur site'),
		   (1, '2023-02-19', 'sur site'),
		   (1, '2023-02-18', 'remote'),
		   (1, '2023-02-17', 'sur site'),
		   (1, '2023-02-16', 'remote'),
		   -- for team_mate 2
		   (2, '2023-02-20', 'sur site'),
		   (2, '2023-02-19', 'remote'),
		   (2, '2023-02-18', 'remote'),
		   (2, '2023-02-17', 'sur site'),
		   (2, '2023-02-16', 'sur site'),
		   -- for team_mate 3
		   (3, '2023-02-20', 'congés'),
		   (3, '2023-02-19', 'congés'),
		   (3, '2023-02-18', 'congés'),
		   (3, '2023-02-17', 'congés'),
		   (3, '2023-02-16', 'congés'),
		   -- for team_mate 4
		   (4, '2023-02-20', 'sur site'),
		   (4, '2023-02-19', 'remote'),
		   (4, '2023-02-18', 'remote'),
		   (4, '2023-02-17', 'remote'),
		   (4, '2023-02-16', 'remote');

INSERT INTO public.locations(
	location_name, location_adress)
	VALUES ('Leroy merlin', 'Rue de Versailles, 59650 Villeneuve-d''Ascq'),
		   ('XPEHO', '1 Boulevard de Valmy, 59650 Villeneuve d Ascq'),
		   ('ADEO', '135 Rue Sadi Carnot, 59790 Ronchin');