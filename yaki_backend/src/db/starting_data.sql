-- INSERT USERS

INSERT INTO public.user(
	user_last_name, user_first_name, user_email, user_login, user_password)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', '$5$rounds=10000$abcdefghijklmnop$OA65zl2VDjeMzN.O3S/2pSV4eWCglNv9o4nVabmkQz5'),
           ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', '$5$rounds=10000$abcdefghijklmnop$xlREmQbTt/diimOXnxUzDQaWJx8CPvKtJFL5EH8jAE7'),
           ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', '$5$rounds=10000$abcdefghijklmnop$5nP0MR35CzShPTl9K3Vl5gEF2kBc6cDKoQ2LEtG18FB'),
           ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', '$5$rounds=10000$abcdefghijklmnop$RPAmnJzQd9oz41ZHa/w/irK73ragHk6.coDwjarc8PB'),
           ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', '$5$rounds=10000$abcdefghijklmnop$86rpsyu697b0vfHinaeAwhJ7bXwRPXM7JifCH41sgt9'),
           ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', '$5$rounds=10000$abcdefghijklmnop$aVV68ybbmry88mMGXU1snZOfwd0pKbYFTQbzrv.7n44'),
           ('Lazard', 'Arnaud', 'arnaud.lazard@mail.com', 'lazard', '$5$rounds=10000$abcdefghijklmnop$FwrCge3JnXlGV1xkCrOnyT5QDBQb//f6oGmyjQ6nDc0'),
           ('Bain', 'Aaron', 'aaron.bain@mail.com', 'bain', '$5$rounds=10000$abcdefghijklmnop$flxzos/1DN13hD1e0Wjji3clwr.cL7jZqfuimgtVO80'),
           ('Valverde', 'Paul', 'paul.valverde@mail.com', 'valverde', '$5$rounds=10000$abcdefghijklmnop$RMO84AgIIe8yMm8I4mdbFWBRUrikpr7XdPIpMVnOE4C');
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
	customer_user_id,customer_name,customer_owner_id,customer_location_id)
	VALUES (6,'customer0',1,1),
		   (7,'Customer1',1,2);

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
	customer_name,customer_owner_id,customer_location_id)
	VALUES ('customer0',1,1),
		   ('Customer1',1,2),
		   ('Customer2',1,3);

-- INSERT CUSTOMER_RIGHTS

INSERT INTO public.customer_rights(
	customer_rights_user_id,customer_rights_customer_id)
	VALUES (7,1),
		   (8,1);
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
		   (1, '2023-02-20','2023-02-20','2023-02-20', 'on site'),
		   (1, '2023-02-19','2023-02-19','2023-02-19', 'on site'),
		   (1, '2023-02-18','2023-02-18','2023-02-18', 'remote'),
		   (1, '2023-02-17','2023-02-17','2023-02-17', 'on site'),
		   (1, '2023-02-16','2023-02-16','2023-02-16', 'remote'),
		   -- for team_mate 2
		   (2, '2023-02-20','2023-02-20','2023-02-20', 'on site'),
		   (2, '2023-02-19','2023-02-19','2023-02-19', 'remote'),
		   (2, '2023-02-18','2023-02-19','2023-02-19', 'remote'),
		   (2, '2023-02-17','2023-02-17','2023-02-17', 'on site'),
		   (2, '2023-02-16','2023-02-16','2023-02-16', 'on site'),
		   -- for team_mate 3
		   (3, '2023-02-20','2023-02-20','2023-02-20', 'vacation'),
		   (3, '2023-02-19','2023-02-19','2023-02-19', 'vacation'),
		   (3, '2023-02-18','2023-02-19','2023-02-19', 'vacation'),
		   (3, '2023-02-17','2023-02-17','2023-02-17', 'vacation'),
		   (3, '2023-02-16','2023-02-16','2023-02-16', 'vacation'),
		   -- for team_mate 4
		   (4, '2023-02-20','2023-02-20','2023-02-20', 'on site'),
		   (4, '2023-02-19','2023-02-19','2023-02-19', 'remote'),
		   (4, '2023-02-18','2023-02-19','2023-02-19', 'remote'),
		   (4, '2023-02-17','2023-02-17','2023-02-17', 'remote'),
		   (4, '2023-02-16','2023-02-16','2023-02-16', 'remote');

