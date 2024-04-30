-- INSERT USERS

INSERT INTO public.user(
	user_last_name, user_first_name, user_email, user_login, user_password,user_avatar_choice, user_enabled)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeoui4jDGURA4U0LyJcQ4DsuqebxQLrDy',null, true),
           ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', '$2b$16$/QOMfvRTxIkPWvy2I8vGde6V9.myezzhttR7dAlM58MRM8h.TOVFW',null, true),
           ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', '$2b$16$JQl5eqV4Cub/VCQiA7Vrx.ZPl.Tjk./vYSzMEWTdhDdG.dzPY0n1S',null, true),
           ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeuxFXCKyQkcLoKKuNpzqRalDEDp5.fRS',null, true),
           ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', '$2b$16$/QOMfvRTxIkPWvy2I8vGdes2QzfMbDr.Ur0PV6oqZjCvbxS.hw73W',null, true),
           ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeEx/ALW4lxYvJPShsj49q/EPq9Y4HESC',null, true),
           ('Lazard', 'Arnaud', 'arnaud.lazard@mail.com', 'lazard', '$2b$16$tEMB6H99BLM7uHPnFVJKHeMFsl9/j5hrYbr8/rdoUSD21AB1HmNeG',null, true),
           ('Bain', 'Aaron', 'aaron.bain@mail.com', 'bain', '$2b$16$/QOMfvRTxIkPWvy2I8vGde74f0VcXHYHQZVRyGYldOfnSXxzVny5W',null, true),
           ('Valverde', 'Paul', 'paul.valverde@mail.com', 'valverde', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeT2Eik.XKZvxcaxvNnD05e6X1y3JeWWu',null, true),
		   ('Dupres', 'Robert', 'dupres.robert@mail.com', 'robert', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeJY3SUPgjnWNQ2b0t.a0XDr7.n/U2gEu',null, true),
           ('Deschamps', 'Marguerite', 'marguerite.deschamps@mail.com', 'marguerite', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeVdGbYs4rtQovOMFHUEndBtWAlblrhcq',null, true);
-- INSERT LOCATIONS

INSERT INTO public.entity_log(
entity_log_creation_date, entity_log_inactivation_date)
VALUES 
	('2023-02-20', '2050-02-20');		   

INSERT INTO public.locations(
	location_name, location_adress, location_entity_log_id, location_is_active)
	VALUES ('Leroy merlin', 'Rue de Versailles, 59650 Villeneuve-d''Ascq', 1, true),
		   ('XPEHO', '1 Boulevard de Valmy, 59650 Villeneuve d Ascq', 1, true),
		   ('ADEO', '135 Rue Sadi Carnot, 59790 Ronchin', 1, true),
		   ('NADEO', '40 Rue de la voiture, 59000 Lille', 1, true);

-- INSERT OWNERS

INSERT INTO public.owner(
	owner_user_id)
	VALUES (8);

-- INSERT CUSTOMERS

INSERT INTO public.customer(
	customer_name,customer_owner_id,customer_location_id, customer_actif_flag, customer_entity_log_id)
	VALUES ('customer0',1,1,true,1),
		   ('Customer1',1,2,true,1),
		   ('Customer2',1,3,true,1),
		   ('Customer3',1,3,true,1);

-- INSERT CUSTOMER_RIGHTS

INSERT INTO public.customer_rights(
	customer_rights_user_id,customer_rights_customer_id)
	VALUES (7,1),
		   (8,1);

-- INSERT CAPTAINS

INSERT INTO public.captain(
	captain_user_id,captain_customer_id, captain_entity_log_id, captain_actif_flag)
	VALUES (6,1,1,true),
		   (4,2,1,true),
		   (10,3,1,true),
		   (11,4,1,true);

-- INSERT TEAM

INSERT INTO public.team(
	team_name, team_customer_id ,team_actif_flag , team_entity_log_id, team_description)
	VALUES ('Equipe 1',1,true,1, ''),
	       ('Equipe 2',2,true,1, ''),
		   ('Equipe 3',3,true,1, ''),
		   ('Equipe 4',4,true,1, '');

-- INSERT CAPTAINS_TEAMS

INSERT INTO public.captains_teams(
	captains_teams_captain_id, captains_teams_team_id)
	VALUES (1,1),
		   (2,2),
		   (3,3),
		   (4,4);		   

-- INSERT TEAMMATES

INSERT INTO public.teammate(
	teammate_team_id, teammate_user_id, teammate_entity_log_id, teammate_actif_flag)
	VALUES (1, 1,1,true),
		   (1, 2,1,true),
		   (2, 1,1,true),
		   (2, 3,1,true),
		   (2, 5,1,true),
		   (3, 1,1,true),
		   (3, 2,1,true),
		   (4, 3,1,true),
		   (4, 5,1,true);

-- INSERT DECLARATIONS

-- INSERT DECLARATIONS

INSERT INTO public.declaration(
	declaration_user_id, declaration_date,declaration_date_start, declaration_date_end, declaration_status, declaration_team_id, declaration_is_latest)
	VALUES -- for team_mate 1
		   (1, '2023-02-20','2023-02-20 00:00:00','2023-02-20 23:59:59', 'on site', 1, true),
		   (1, '2023-02-19','2023-02-19 00:00:00','2023-02-19 23:59:59', 'on site', 1, true),
		   (1, '2023-02-18','2023-02-18 00:00:00','2023-02-18 12:00:00', 'remote', 1, true),
		   (1, '2023-02-17','2023-02-18 13:00:00','2023-02-18 23:59:59', 'on site', 1, true),
		   (1, '2023-02-16','2023-02-17 00:00:00','2023-02-17 23:59:59', 'remote', 1, true),
		   -- for team_mate 2
		   (2, '2023-02-20','2023-02-20 00:00:00','2023-02-20 23:59:59', 'on site', 2, true),
		   (2, '2023-02-19','2023-02-19 00:00:00','2023-02-19 23:59:59', 'remote', 2, false),
		   (2, '2023-02-18','2023-02-19 00:00:00','2023-02-19 23:59:59', 'remote', 2, true),
		   (2, '2023-02-17','2023-02-17 00:00:00','2023-02-17 23:59:59', 'on site', 2, true),
		   (2, '2023-02-16','2023-02-16 00:00:00','2023-02-16 23:59:59', 'on site', 2, true),
		   -- for team_mate 3
		   (3, '2023-02-20','2023-02-20 00:00:00','2023-02-20 23:59:59', 'on site', 1, true),
		   (3, '2023-02-19','2023-02-19 00:00:00','2023-02-19 12:00:00', 'remote', 1, true),
		   (3, '2023-02-18','2023-02-19 13:00:00','2023-02-19 23:59:59', 'absence', 1, true),
		   (3, '2023-02-17','2023-02-17 00:00:00','2023-02-17 23:59:59', 'remote', 1, true),
		   (3, '2023-02-16','2023-03-14 00:00:00','2023-03-28 23:59:59', 'absence', 1, true),
		   -- for team_mate 4
		   (4, '2023-02-20','2023-02-20 00:00:00','2023-02-20 23:59:59', 'on site', 2, true),
		   (4, '2023-02-19','2023-02-19 00:00:00','2023-02-19 23:59:59', 'remote', 2, false),
		   (4, '2023-02-18','2023-02-19 00:00:00','2023-02-19 23:59:59', 'on site', 2, true),
		   (4, '2023-02-17','2023-02-17 00:00:00','2023-02-17 23:59:59', 'remote', 2, true),
		   (4, '2023-02-16','2023-02-16 00:00:00','2023-02-16 23:59:59', 'remote', 2, true);
