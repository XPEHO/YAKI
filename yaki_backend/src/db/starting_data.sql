-- INSERT USERS

INSERT INTO public.user(
	user_last_name, user_first_name, user_email, user_login, user_password)
	VALUES ('DuGrand', 'Jacques', 'dugrand.jacques@mail.com', 'dugrand', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeoui4jDGURA4U0LyJcQ4DsuqebxQLrDy'),
           ('Sauvagneau', 'Benjamin', 'benjamin.sauvagneau@mail.com', 'sauvagneau', '$2b$16$/QOMfvRTxIkPWvy2I8vGde6V9.myezzhttR7dAlM58MRM8h.TOVFW'),
           ('Dupond', 'Michel', 'dupond.michel@mail.com', 'dupond', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeKjn6DtPHf9DAD86BlKR.lleTntRfsrO'),
           ('Marquez', 'Auguste', 'auguste.marquez@mail.com', 'marquez', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeuxFXCKyQkcLoKKuNpzqRalDEDp5.fRS'),
           ('Leclerc', 'Megane', 'megane.leclerc@mail.com', 'leclerc', '$2b$16$/QOMfvRTxIkPWvy2I8vGdes2QzfMbDr.Ur0PV6oqZjCvbxS.hw73W'),
           ('Lavigne', 'Valentin', 'valentin.lavigne@mail.com', 'lavigne', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeEx/ALW4lxYvJPShsj49q/EPq9Y4HESC'),
           ('Lazard', 'Arnaud', 'arnaud.lazard@mail.com', 'lazard', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeUkRfce0nFk1JavtSc.A75fy3M0DDwTi'),
           ('Bain', 'Aaron', 'aaron.bain@mail.com', 'bain', '$2b$16$/QOMfvRTxIkPWvy2I8vGde74f0VcXHYHQZVRyGYldOfnSXxzVny5W'),
           ('Valverde', 'Paul', 'paul.valverde@mail.com', 'valverde', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeT2Eik.XKZvxcaxvNnD05e6X1y3JeWWu'),
		   ('Dupres', 'Robert', 'dupres.robert@mail.com', 'robert', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeJY3SUPgjnWNQ2b0t.a0XDr7.n/U2gEu'),
           ('Deschamps', 'Marguerite', 'marguerite.deschamps@mail.com', 'marguerite', '$2b$16$/QOMfvRTxIkPWvy2I8vGdeVdGbYs4rtQovOMFHUEndBtWAlblrhcq');
-- INSERT LOCATIONS

INSERT INTO public.locations(
	location_name, location_adress)
	VALUES ('Leroy merlin', 'Rue de Versailles, 59650 Villeneuve-d''Ascq'),
		   ('XPEHO', '1 Boulevard de Valmy, 59650 Villeneuve d Ascq'),
		   ('ADEO', '135 Rue Sadi Carnot, 59790 Ronchin'),
		   ('NADEO', '40 Rue de la voiture, 59000 Lille');

-- INSERT OWNERS

INSERT INTO public.owner(
	owner_user_id)
	VALUES (8);

-- INSERT CUSTOMERS

INSERT INTO public.customer(
	customer_name,customer_owner_id,customer_location_id)
	VALUES ('customer0',1,1),
		   ('Customer1',1,2),
		   ('Customer2',1,3),
		   ('Customer3',1,3);

-- INSERT CUSTOMER_RIGHTS

INSERT INTO public.customer_rights(
	customer_rights_user_id,customer_rights_customer_id)
	VALUES (7,1),
		   (8,1);
-- INSERT CAPTAINS

INSERT INTO public.captain(
	captain_user_id,captain_customer_id )
	VALUES (6,1),
		   (4,2),
		   (10,3),
		   (11,4);

-- INSERT TEAM

INSERT INTO public.team(
	team_captain_id, team_name)
	VALUES (1, 'Equipe 1'),
	       (2, 'Equipe 2'),
		   (3, 'Equipe 3'),
		   (4, 'Equipe 4');

-- INSERT TEAM MATES

INSERT INTO public.team_mate(
	team_mate_team_id, team_mate_user_id)
	VALUES (1, 1),
		   (1, 2),
		   (2, 3),
		   (2, 5),
		   (3, 1),
		   (3, 2),
		   (4, 3),
		   (4, 5);

-- INSERT DECLARATIONS

-- INSERT DECLARATIONS

INSERT INTO public.declaration(
	declaration_team_mate_id, declaration_date,declaration_date_start, declaration_date_end, declaration_status, declaration_team_id)
	VALUES -- for team_mate 1
		   (1, '2023-02-20','2023-02-20','2023-02-20', 'on site', 1),
		   (1, '2023-02-19','2023-02-19','2023-02-19', 'on site', 1),
		   (1, '2023-02-18','2023-02-18','2023-02-18', 'remote', 1),
		   (1, '2023-02-17','2023-02-17','2023-02-17', 'on site', 1),
		   (1, '2023-02-16','2023-02-16','2023-02-16', 'remote', 1),
		   -- for team_mate 2
		   (2, '2023-02-20','2023-02-20','2023-02-20', 'on site', 2),
		   (2, '2023-02-19','2023-02-19','2023-02-19', 'remote', 2),
		   (2, '2023-02-18','2023-02-19','2023-02-19', 'remote', 2),
		   (2, '2023-02-17','2023-02-17','2023-02-17', 'on site', 2),
		   (2, '2023-02-16','2023-02-16','2023-02-16', 'on site', 2),
		   -- for team_mate 3
		   (3, '2023-02-20','2023-02-20','2023-02-20', 'vacation', 1),
		   (3, '2023-02-19','2023-02-19','2023-02-19', 'vacation', 1),
		   (3, '2023-02-18','2023-02-19','2023-02-19', 'vacation', 1),
		   (3, '2023-02-17','2023-02-17','2023-02-17', 'vacation', 1),
		   (3, '2023-02-16','2023-02-16','2023-02-16', 'vacation', 1),
		   -- for team_mate 4
		   (4, '2023-02-20','2023-02-20','2023-02-20', 'on site', 2),
		   (4, '2023-02-19','2023-02-19','2023-02-19', 'remote', 2),
		   (4, '2023-02-18','2023-02-19','2023-02-19', 'remote', 2),
		   (4, '2023-02-17','2023-02-17','2023-02-17', 'remote', 2),
		   (4, '2023-02-16','2023-02-16','2023-02-16', 'remote', 2);