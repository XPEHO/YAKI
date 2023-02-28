-- INSERT USERS

INSERT INTO public."user"(
	user_last_name, user_first_name, user_email, user_login, user_password)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', '$5$rounds=10000$abcdefghijklmnop$OA65zl2VDjeMzN.O3S/2pSV4eWCglNv9o4nVabmkQz5'),
		   ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', '$5$rounds=10000$abcdefghijklmnop$xlREmQbTt/diimOXnxUzDQaWJx8CPvKtJFL5EH8jAE7'),
		   ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', '$5$rounds=10000$abcdefghijklmnop$5nP0MR35CzShPTl9K3Vl5gEF2kBc6cDKoQ2LEtG18FB'),
		   ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', '$5$rounds=10000$abcdefghijklmnop$RPAmnJzQd9oz41ZHa/w/irK73ragHk6.coDwjarc8PB'),
		   ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', '$5$rounds=10000$abcdefghijklmnop$gm8iA7lvznQaK9d.WhXI.OEuKZzq.jLL8G4zuhJvgzD'),
		   ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', '$5$rounds=10000$abcdefghijklmnop$aVV68ybbmry88mMGXU1snZOfwd0pKbYFTQbzrv.7n44');

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