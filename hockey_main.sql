
/* HOW TO CHECK IF A TABLE ALREADY EXISTS IN MS SQL SERVER */
/*
IF (EXISTS (SELECT * 
				FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'dbo'
				AND TABLE_NAME = 'hky_teams'))
BEGIN
	-- create the hockey teams table
	CREATE TABLE hky_teams
	(
		team_id INT NOT NULL IDENTITY(1,1),
		team_city VARCHAR(35) NOT NULL,
		team_name VARCHAR(35) NOT NULL
	);
END
*/

/* create table for hockey leagues */
IF NOT EXISTS (SELECT *
                   FROM INFORMATION_SCHEMA.TABLES
				   WHERE TABLE_SCHEMA = 'dbo'
				   AND TABLE_NAME = 'hky_leagues'))
BEGIN
  -- create the hockey leagues table
  CREATE TABLE hockey_main.dbo.hky_leagues
  (
      league_id INT NOT NULL IDENTITY(1,1),
	  league_name VARCHAR(35) NOT NULL,
	  league_start_date DATE,
	  league_end_date DATE,
	  CONSTRAINT PK_league_id PRIMARY KEY (league_id),
	  CONSTRAINT CHK_league_start_end CHECK (league_start_date < league_end_date)
  );
END

/* create table for hockey conferences */
IF NOT EXISTS (SELECT * 
                   FROM INFORMATION_SCHEMA.TABLES
				   WHERE TABLE_SCHEMA = 'dbo'
				   AND TABLE_NAME = 'hky_conferences'))
BEGIN
   -- create the hockey conferences table
   CREATE TABLE hky_conferences
   (
       conference_id INT NOT NULL IDENTITY(1,1),
	   conference_name VARCHAR(35) NOT NULL,
	   league_id INT,
	   CONSTRAINT FK_league_id
END

/* create table for hockey divisions */
IF NOT EXISTS (SELECT * 
                   FROM INFORMATION_SCHEMA.TABLES 
				   WHERE TABLE_SCHEMA = 'dbo'
				   AND TABLE_NAME = 'hky_divisions'))
BEGIN
   -- create the 





/* create hockey teams table */
CREATE TABLE hky_teams
(
team_id INT NOT NULL IDENTITY(1,1),
team_city VARCHAR(35) NOT NULL,
team_name VARCHAR(35) NOT NULL,
CONSTRAINT PK_hky_teams PRIMARY KEY (team_id)
);

/* add primary key to hockey teams table */
/*
ALTER TABLE hky_teams
ADD CONSTRAINT PK_hky_teams 
PRIMARY KEY (team_id);*/

/* add column to hky_teams with division_id */

/* create hockey players table */
CREATE TABLE hky_players
(
player_id INT NOT NULL IDENTITY(1,1),
player_lastname VARCHAR(35) NOT NULL,
player_firstname VARCHAR(35) NOT NULL,
player_position CHAR(2),
CONSTRAINT CHK_player_position CHECK ( player_position IN ('G', 'LW', 'C', 'RW', 'D') ),
player_birthdate DATE DEFAULT '01/01/1900',
team_id INT,
CONSTRAINT FK_team_id FOREIGN KEY (team_id) REFERENCES dbo.hky_teams (team_id)
ON DELETE SET NULL
ON UPDATE CASCADE,
CONSTRAINT PK_player_id PRIMARY KEY (player_id)
); 

/* alter hockey players table to add player jersey number, height, weight, birth place (actually birth place will be put in a separate table later on). */
ALTER TABLE hky_players
ADD player_jersey_num TINYINT
CONSTRAINT CHK_player_jersey_num CHECK (player_jersey_num LIKE '[0-9][0-9]' OR player_jersey_num LIKE '[0-9]'),
player_height CHAR(6), /* FORM 5' 10" */
player_weight TINYINT;

/* change the player_weight column data type from tinyint to int */
ALTER TABLE hky_players
ALTER COLUMN player_weight INT;

/* insert teams into hockey teams table */
INSERT INTO hky_teams
(team_city, team_name)
VALUES
('Anaheim', 'Ducks'),
('Arizona', 'Coyotes'),
('Boston', 'Bruins'),
('Buffalo', 'Sabres'),
('Calgary', 'Flames'),
('Carolina', 'Hurricanes'),
('Chicago', 'Blackhawks'),
('Colorado', 'Avalanche'),
('Columbus', 'Blue Jackets'),
('Dallas', 'Stars'),
('Detroit', 'Red Wings'),
('Edmonton', 'Oilers'),
('Florida', 'Panthers'),
('Los Angeles', 'Kings'),
('Minnesota', 'Wild'),
('Montreal', 'Canadiens'),
('Nashville', 'Predators'),
('New Jersey', 'Devils'),
('New York', 'Islanders'),
('New York', 'Rangers'),
('Ottawa', 'Senators'), 
('Philadelphia', 'Flyers'),
('Pittsburgh', 'Penguins'), 
('San Jose', 'Sharks'),
('St. Louis', 'Blues'),
('Tampa Bay', 'Lightning'),
('Toronto', 'Maple Leafs'),
('Vancouver', 'Canucks'),
('Washington', 'Capitals'),
('Winnipeg', 'Jets');

/* query hockey teams table to see inserted data */
SELECT *
FROM hky_teams;

/* clear out data from hockey players table */
DELETE FROM hky_players;

/* insert anaheim ducks 2015 roster players into hockey players table */
INSERT INTO hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(7,		'Andrew',	'Cogliano',		'LW',	'5'' 10"',	184, '06/14/1987', 1),
(15,	'Ryan',		'Getzlaf',		'C',	'6'' 4"',	221, '05/10/1985', 1),
(26,	'Carl',		'Hagelin',		'LW',	'5'' 11"',	186, '08/23/1988', 1),
(22,	'Shawn',	'Horcoff',		'C',	'6'' 1"',	210, '09/17/1978', 1),
(17,	'Ryan',		'Kessler',		'C',	'6'' 2"',	202, '08/31/1984', 1),
(19,	'Patrick',	'Maroon',		'LW',	'6'' 3"',	230, '04/23/1988', 1),
(10,	'Corey',	'Perry',		'RW',	'6'' 3"',	210, '05/16/1985', 1),
(67,	'Rickard',	'Rakell',		'C',	'6'' 2"',	201, '05/05/1993', 1),
(37,	'Nick',		'Ritchie',		'LW',	'6'' 2"',	232, '12/05/1995', 1),
(25,	'Mike',		'Santorelli',	'C',	'6'' 2"',	189, '12/14/1985', 1),
(46,	'Jiri',		'Sekac',		'LW',	'6'' 1"',	185, '06/10/1992', 1),
(77,	'Michael',  'Sgarbossa',  	'C',	'6'' 0"',	186, '07/25/1992', 1),
(33,	'Jakob',	'Silfverberg',  'RW',	'6'' 2"',	196, '10/13/1990', 1),
(29,	'Chris',	'Stewart',  	'RW',	'6'' 2"',	231, '10/30/1990', 1),
(44,	'Nate',		'Thompson',  	'C',	'6'' 0"',	212, '10/05/1984', 1),
(2,		'Kevin',	'Bieksa',  		'D',	'6'' 1"',	200, '06/16/1981', 1),
(24,	'Simon',	'Despres',		'D',	'6'' 4"',	218, '07/27/1991', 1),
(4,		'Cam',		'Fowler',	  	'D',	'6'' 1"',	207, '12/05/1991', 1),
(5,		'Korbinian', 'Holzer',  	'D',	'6'' 3"',	215, '02/16/1988', 1),
(47,	'Hampus',	'Lindholm',  	'D',	'6'' 3"',	205, '01/20/1994', 1),
(42,	'Josh',		'Manson',  		'D',	'6'' 3"',	215, '10/07/1991', 1),
(34,	'Shane',	'O''Brien',  	'D',	'6'' 3"',	230, '08/09/1983', 1),
(3,		'Clayton',	'Stoner',  		'D',	'6'' 4"',	216, '02/19/1985', 1),
(45,	'Sami',		'Vatanen',  	'D',	'5'' 10"',	183, '06/03/1991', 1),
(31,	'Frederik', 'Andersen',  	'G',	'6'' 4"', 	220, '10/02/1989', 1),
(30, 	'Anton',	'Khudobin',  	'G',	'5'' 11"',	203, '05/07/1986', 1);

/* insert arizona coyotes 2015 roster */
INSERT INTO hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(89,	'Mikkel',	'Boedker',  	'LW',	'6'' 0"',	211, '12/16/1989', 2),
(24,	'Kyle',		'Chipchura',  	'C',	'6'' 2"',	203, '02/19/1986', 2),
(22,	'Craig',	'Cunningham',  	'LW',	'5'' 10"',	184, '09/13/1990', 2),
(19, 	'Shane',	'Doan', 		'RW',	'6'' 1"',	223, '10/10/1976', 2),	
(16,	'Max',		'Domi',  		'LW',	'5'' 10"',	198, '03/02/1995', 2),
(17,	'Steve',	'Downie',  		'RW',	'5'' 11"',	191, '04/03/1987', 2),
(10,	'Anthony',	'Duclair',		'LW',   '5'' 11"',	185, '08/25/1995', 2),
(15,	'Boyd',		'Gordon',		'C',	'6'' 0"',	200, '10/19/1983', 2),
(11,	'Martin',	'Hanzal',		'C',	'6'' 6"',	226, '02/20/1987', 2),
(48,	'Jordan',	'Martinook',	'LW',	'6'' 0"',	202, '07/25/1992', 2),
(12,	'Brad',		'Richardson',	'RW',	'6'' 0"',	197, '02/04/1985', 2),
(8,		'Tobias',	'Rieder',		'RW',	'5'' 11"',  185, '01/10/1993', 2),
(28,	'John',		'Scott',		'LW',	'6'' 8"',	260, '09/26/1982', 2),
(50,	'Antoine',  'Vermette',		'C',	'6'' 1"',	198, '07/20/1982', 2),
(14,	'Joe',		'Vitale',		'C',	'5'' 11"',  205, '08/20/1985', 2),
(34,	'Klas',		'Dahlbeck',		'D',	'6'' 3"',	207, '07/06/1991', 2),
(23,	'Oliver',	'Ekman-Larsson','D',  	'6'' 2"',	200, '07/17/1991', 2),
(45,	'Stefan',	'Elliott',		'D',	'6'' 1"',	190, '01/30/1991', 2),
(2,		'Nicklas',	'Grossman',		'D',	'6'' 4"',	230, '01/22/1985', 2),
(4,		'Zbynek',	'Michalek',		'D',	'6'' 2"',	210, '12/23/1982', 2),
(5,		'Connor',	'Murphy',		'D',	'6'' 4"',	212, '03/26/1993', 2),
(25,	'Philip',	'Samuelsson',	'D',	'6'' 2"',	194, '07/26/1991', 2),
(26,	'Michael',	'Stone',		'D',	'6'' 3"',	210, '07/07/1990', 2),
(35,	'Louis',	'Domingue',		'D',	'6'' 3"',	210, '03/06/1992', 2),
(29,	'Anders',	'Lindback',		'G',	'6'' 6"',	215, '05/03/1988', 2),
(41,	'Mike',		'Smith',		'G',	'6'' 4"',	215, '03/22/1982', 2);

/* remove Louis Domingue from Arizona Coyotes' roster */
DELETE FROM hockey_main.dbo.hky_players
WHERE hockey_main.dbo.hky_players.player_jersey_num = 35;

/* add Boston Bruins 2015 roster to database */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(39, 'Matt', 'Beleskey', 'LW', '6'' 0"', 203, '06/07/1988', 3),
(37, 'Patrice', 'Bergeron', 'C', '6'' 1"', 195, '07/24/1985', 3),
(14, 'Brett', 'Connolly', 'RW', '6'' 2"', 193, '05/02/1992', 3),
(21, 'Loui', 'Eriksson', 'RW', '6'' 2"', 183, '07/17/1985', 3),
(29, 'Landon', 'Ferraro', 'C', '6'' 0"', 186, '08/08/1991', 3),
(11, 'Jimmy', 'Hayes', 'RW', '6'' 5"', 215, '11/21/1989', 3),
(23, 'Chris', 'Kelly', 'C', '6'' 0"', 193, '11/11/1980', 3),
(41, 'Joonas', 'Kemppainen', 'C', '6'' 3"', 223, '04/07/1988', 3),
(46, 'David', 'Krejci', 'C', '6'' 0"', 186, '04/28/1986', 3),
(63, 'Brad', 'Marchand', 'LW', '5'' 9"', 181, '05/11/1988', 3),
(88, 'David', 'Pastrnak', 'RW', '6'' 0"', 181, '05/25/1996', 3),
(64, 'Tyler', 'Randell', 'RW', '6'' 1"', 198, '06/15/1991', 3),
(36, 'Zac', 'Rinaldo', 'C', '5'' 10"', 188, '06/15/1990', 3),
(51, 'Ryan', 'Spooner', 'C', '5'' 10"', 184, '01/30/1992', 3),
(25, 'Max', 'Talbot', 'C', '5'' 11"', 186, '02/11/1984', 3),
(72, 'Frank', 'Vatrano', 'C', '5'' 9"', 201, '03/14/1994', 3),
(33, 'Zdeno', 'Chara', 'D', '6'' 9"', 250, '03/18/1977', 3),
(47, 'Torey', 'Krug', 'D', '5'' 9"', 186, '04/12/1991', 3),
(54, 'Adam', 'McQuaid', 'D', '6'' 4"', 212, '10/12/1986', 3),
(48, 'Colin', 'Miller', 'D', '6'' 1"', 196, '10/29/1992', 3),
(86, 'Kevan', 'Miller', 'D', '6'' 2"', 210, '11/15/1987', 3),
(45, 'Joe', 'Morrow', 'D', '6'' 0"', 199, '12/09/1992', 3),
(44, 'Dennis', 'Seidenberg', 'D', '6'' 0"', 198, '07/18/1981', 3),
(62, 'Zach', 'Trotman', 'D', '6'' 3"', 217, '08/26/1990', 3),
(50, 'Jonas', 'Gustavsson', 'G', '6'' 4"', 201, '10/24/1984', 3),
(40, 'Tuukka', 'Rask', 'G', '6'' 3"', 176, '03/10/1987', 3);

/* Buffalo Sabres 2015 roster */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(44, 'Nicolas', 'Deslauriers', 'LW', '6'' 1"', 212, '02/22/1991', 4),
(15, 'Jack', 'Eichel', 'C', '6'' 2"', 201, '10/28/1996', 4),
(63, 'Tyler', 'Ennis', 'C', '5'' 9"', 160, '10/06/1989', 4),
(82, 'Marcus', 'Foligno', 'LW', '6'' 3"', 226, '08/10/1991', 4),
(12, 'Brian', 'Gionta', 'RW', '5'' 7"', 178, '01/18/1979', 4),
(28, 'Zemgus', 'Girgensons', 'C', '6'' 1"', 203, '01/05/1994', 4),
(9, 'Evander', 'Kane', 'LW', '6'' 2"', 204, '08/02/1991', 4),
(22, 'Johan', 'Larsson', 'LW', '5'' 11"', 200, '07/25/1992', 4),
(17, 'David', 'Legwand', 'C', '6'' 2"', 207, '08/17/1980', 4),
(8, 'Cody', 'McCormick', 'C', '6'' 2"', 228, '04/18/1983', 4),
(88, 'Jamie', 'McGinn', 'LW', '6'' 1"', 205, '08/05/1988', 4),
(26, 'Matt', 'Moulson', 'LW', '6'' 1"', 212, '11/01/1983', 4),
(90, 'Ryan', 'O''Reilly', 'C', '6'' 1"', 210, '02/07/1991', 4),
(23, 'Sam', 'Reinhart', 'C', '6'' 1"', 189, '11/06/1995', 4),
(59, 'Tim', 'Schaller', 'C', '6'' 2"', 219, '11/16/1990', 4),
(47, 'Zach', 'Bogosian', 'D', '6'' 3"', 219, '07/15/1990', 4),
(25, 'Carlo', 'Colaiacovo', 'D', '6'' 1"', 202, '01/27/1983', 4),
(46, 'Cody', 'Franson', 'D', '6'' 5"', 234, '08/08/1987', 4),
(4, 'Josh', 'Gorges', 'D', '6'' 1"', 203, '08/14/1987', 4),
(29, 'Jake', 'McCabe', 'D', '6'' 0"', 214, '10/12/1993', 4),
(3, 'Mark', 'Pysyk', 'D', '6'' 1"', 200, '01/11/1992', 4),
(55, 'Rasmus', 'Ristolainen', 'D', '6'' 4"', 207, '10/27/1994', 4),
(6, 'Mike', 'Weber', 'D', '6'' 2"', 217, '12/16/1987', 4),
(31, 'Chad', 'Johnson', 'G', '6'' 3"', 196, '06/10/1986', 4),
(40, 'Robin', 'Lehner', 'G', '6'' 5"', 240, '07/24/1991', 4),
(35, 'Linus', 'Ullmark', 'G', '6'' 4"', 212, '07/31/1993', 4);

/* Calgary Flames roster 2015 */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(11, 'Mikael', 'Backlund', 'C', '6'' 1"', 199, '03/15/1989', 5),
(93, 'Sam', 'Bennett', 'C', '6'' 1"', 186, '06/20/1996', 5),
(52, 'Brandon', 'Bollig', 'LW', '6'' 2"', 220, '01/31/1987', 5),
(17, 'Lance', 'Bouma', 'C', '6'' 2"', 208, '03/25/1990', 5),
(8, 'Joe', 'Coloborne', 'C', '6'' 5"', 221, '01/30/1990', 5),
(79, 'Michael', 'Ferland', 'LW', '6'' 2"', 208, '04/20/1992', 5),
(67, 'Michael', 'Frolik', 'RW', '6'' 1"', 194, '02/17/1988', 5),
(13, 'Johnny', 'Gaudreau', 'LW', '5'' 9"', 157, '08/13/1993', 5),
(60, 'Markus', 'Granlund', 'C', '6'' 0"', 178, '04/16/1993', 5),
(24, 'Jiri', 'Hudler', 'C', '5'' 10"', 183, '01/04/1984', 5),
(19, 'David', 'Jones', 'RW', '6'' 3"', 208, '08/10/1984', 5),
(16, 'Josh', 'Jooris', 'C', '6'' 1"', 187, '07/14/1990', 5),
(23, 'Sean', 'Monahan', 'C', '6'' 3"', 195, '10/12/1994', 5),
(21, 'Mason', 'Raymond', 'LW', '6'' 1"', 179, '09/17/1985', 5),
(18, 'Matt', 'Stajan', 'C', '6'' 1"', 195, '12/19/1983', 5),
(7, 'TJ', 'Brodie', 'D', '6'' 1"', 182, '06/07/1990', 5),
(29, 'Deryk', 'Engelland', 'D', '6'' 2"', 214, '04/03/1982', 5),
(5, 'Mark', 'Giordano', 'D', '6'' 0"', 198, '10/03/1983', 5),
(27, 'Dougie', 'Hamilton', 'D', '6'' 6"', 210, '06/17/1993', 5),
(33, 'Jakub', 'Nakladal', 'D', '6'' 2"', 212, '12/30/1987', 5),
(4, 'Kris', 'Russell', 'D', '5'' 10"', 170, '05/02/1987', 5),
(15, 'Ladislav', 'Smid', 'D', '6'' 4"', 210, '02/01/1986', 5),
(6, 'Dennis', 'Wideman', 'D', '6'' 0"', 202, '03/20/1983', 5),
(1, 'Jonas', 'Hiller', 'G', '6'' 2"', 191, '02/12/1982', 5),
(31, 'Karri', 'Ramo', 'G', '6'' 2"', 206, '07/01/1986', 5);

/* carolina hurricanes 2015 roster */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(34, 'Phillip', 'Di Giuseppe', 'LW', '6'' 0"', 200, '10/09/1993', 6),
(14, 'Nathan', 'Gerbe', 'LW', '5'' 5"', 178, '07/24/1987', 6),
(16, 'Elias', 'Lindholm', 'C', '6'' 1"', 192, '12/02/1994', 6),
(24, 'Brad', 'Malone', 'C', '6'' 2"', 207, '05/20/1989', 6),
(18, 'Jay', 'McClement', 'C', '6'' 1"', 205, '03/02/1983', 6),
(23, 'Brock', 'McGinn', 'LW', '6'' 0"', 185, '02/02/1994', 6),
(20, 'Riley', 'Nash', 'C', '6'' 1"', 200, '05/09/1989', 6),
(15, 'Andrej', 'Nestrasil', 'C', '6'' 3"', 200, '02/22/1991', 6),
(42, 'Joakim', 'Nordstrom', 'LW', '6'' 1"', 189, '02/25/1992', 6),
(49, 'Victor', 'Rask', 'C', '6'' 2"', 200, '03/01/1993', 6),
(53, 'Jeff', 'Skinner', 'LW', '5'' 11"', 200, '05/16/1992', 6),
(12, 'Eric', 'Staal', 'C', '6'' 4"', 205, '10/29/1984', 6),
(11, 'Jordan', 'Staal', 'C', '6'' 4"', 220, '09/10/1988', 6),
(25, 'Chris', 'Terry', 'LW', '5'' 10"', 195, '04/07/1989', 6),
(32, 'Kris', 'Versteeg', 'RW', '5'' 11"', 176, '05/13/1986', 6),
(27, 'Justin', 'Faulk', 'D', '6'' 0"', 215, '03/20/1992', 6),
(65, 'Ron', 'Hainsey', 'D', '6'' 3"', 210, '03/24/1981', 6),
(5, 'Noah', 'Hanifin', 'D', '6'' 3"', 206, '01/25/1997', 6),
(47, 'Michal', 'Jordan', 'D', '6'' 1"', 195, '07/17/1990', 6), 
(26, 'John-Michael', 'Liles', 'D', '5'' 10"', 185, '11/25/1980', 6),
(54, 'Brett', 'Pesce', 'D', '6'' 3"', 200, '11/15/1994', 6),
(74, 'Jaccob', 'Slavin', 'D', '6'' 2"', 205, '05/01/1994', 6),
(21, 'James', 'Wisniewski', 'D', '5'' 11"', 203, '02/21/1984', 6),
(31, 'Eddie', 'Lack', 'G', '6'' 4"', 187, '01/05/1988', 6),
(30, 'Cam', 'Ward', 'G', '6'' 1"', 185, '02/29/1984', 6);

/* chicago blackhawks 2015 roster */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(15, 'Artem', 'Anisimov', 'C', '6'' 4"', 198, '05/24/1988', 7),
(56, 'Marko', 'Dano', 'RW', '5'' 11"', 183, '11/30/1994', 7),
(11, 'Andrew', 'Desjardins', 'LW', '6'' 1"', 195, '07/27/1986', 7),
(28, 'Ryan', 'Garbutt', 'LW', '6'' 0"', 195, '08/12/1985', 7),
(81, 'Marian', 'Hossa', 'RW', '6'' 1"', 207, '01/12/1979', 7),
(88, 'Patrick', 'Kane', 'RW', '5'' 11"', 177, '11/19/1988', 7),
(67, 'Tanner', 'Kero', 'C', '6'' 0"', 185, '07/24/1992', 7),
(16, 'Marcus', 'Kruger', 'C', '6'' 0"', 186, '05/27/1990', 7),
(53, 'Brandon', 'Mashinter', 'LW', '6'' 4"', 212, '09/20/1988', 7),
(72, 'Artemi', 'Panarin', 'LW', '5'' 11"', 170, '10/30/1991', 7),
(65, 'Andrew', 'Shaw', 'RW', '5'' 11"', 179, '07/20/1991', 7),
(86, 'Teuvo', 'Teravainen', 'C', '5'' 11"', 178, '09/11/1994', 7),
(14, 'Viktor', 'Tikhonov', 'RW', '6'' 2"', 189, '09/12/1988', 7),
(19, 'Jonathan', 'Toews', 'C', '6'' 2"', 201, '04/29/1988', 7),
(6, 'Trevor', 'Daley', 'D', '5'' 11"', 195, '10/09/1983', 7),
(4, 'Niklas', 'Hjalmarsson', 'D', '6'' 3"', 197, '06/06/1987', 7),
(2, 'Duncan', 'Keith', 'D', '6'' 1"', 192, '07/16/1983', 7),
(32, 'Michal', 'Rozsival', 'D', '6'' 1"', 210, '09/03/1978', 7),
(5, 'David', 'Rundblad', 'D', '6'' 2"', 187, '10/08/1990', 7),
(7, 'Brent', 'Seabrook', 'D', '6'' 3"', 220, '04/20/1985', 7),
(57, 'Trevor', 'Van Riemsdyk', 'D', '6'' 2"', 188, '07/24/1991', 7),
(50, 'Corey', 'Crawford', 'G', '6'' 2"', 216, '12/31/1984', 7),
(33, 'Scott', 'Darling', 'G', '6'' 6"', 232, '12/22/1988', 7);

/* colorado avalanche 2015 roster */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(14, 'Blake', 'Comeau', 'LW', '6'' 1"', 202, '02/18/1986', 8),
(9, 'Matt', 'Duchene', 'C', '5'' 11"', 200, '01/16/1991', 8),
(25, 'Mikhail', 'Grigorenko', 'C', '6'' 3"', 209, '05/16/1994', 8),
(12, 'Jarome', 'Iginla', 'RW', '6'' 1"', 210, '07/01/1977', 8),
(92, 'Gabriel', 'Landeskog', 'LW', '6'' 1"', 210, '11/23/1992', 8),
(29, 'Nathan', 'MacKinnon', 'C', '6'' 0"', 195, '09/01/1995', 8),
(27, 'Andreas', 'Martinsen', 'LW', '6'' 3"', 220, '06/13/1990', 8),
(55, 'Cody', 'Mcleod', 'LW', '6'' 2"', 210, '06/26/1984', 8),
(7, 'John', 'Mitchell', 'C', '6'' 1"', 204, '01/22/1985', 8),
(8, 'Jack', 'Skille', 'RW', '6'' 1"', 216, '05/19/1987', 8),
(34, 'Carl', 'Soderberg', 'C', '6'' 3"', 216, '10/12/1985', 8),
(10, 'Ben', 'Street', 'C', '5'' 11"', 185, '02/13/1987', 8),
(40, 'Alex', 'Tanguay', 'LW', '6'' 1"', 194, '11/21/1979', 8),
(62, 'Chris', 'Wagner', 'RW', '6'' 0"', 195, '05/27/1991', 8),
(18, 'Jesse', 'Winchester', 'C', '6'' 1"', 205, '10/04/1983', 8),
(4, 'Tyson', 'Barrie', 'D', '5'' 10"', 190, '07/26/1991', 8),
(32, 'Francois', 'Beauchemin', 'D', '6'' 1"', 208, '06/04/1980', 8),
(46, 'Brandon', 'Gormley', 'D', '6'' 2"', 196, '02/18/1992', 8),
(5, 'Nate', 'Guenin', 'D', '6'' 3"', 207, '12/10/1982', 8),
(2, 'Nick', 'Holden', 'D', '6'' 4"', 210, '05/15/1987', 8),
(6, 'Erik', 'Johnson', 'D', '6'' 4"', 232, '03/21/1988', 8),
(22, 'Zach', 'Redmond', 'D', '6'' 2"', 205, '07/26/1988', 8),
(17, 'Brad', 'Stuart', 'D', '6'' 2"', 215, '11/06/1979', 8),
(20, 'Reto', 'Berra', 'G', '6'' 4"', 210, '01/03/1987', 8),
(1, 'Semyon', 'Varlamov', 'G', '6'' 2"', 209, '04/27/1988', 8);

/* change the last name of 
UPDATE hockey_main.dbo.hky_players
SET player_lastname = 'MacKinnon'
WHERE player_id = 1171;

/* columbus blue jackets 2015 roster */
INSERT INTO hockey_main.dbo.hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(13, 'Cam', 'Atkinson', 'RW', '5'' 8"', 180, '06/05/1989', 9),
(40, 'Jared', 'Boll', 'RW', '6'' 3"', 209, '05/13/1986', 9),
(18, 'Rene', 'Bourque', 'RW', '6'' 2"', 217, '12/10/1981', 9),
(11, 'Matt', 'Calvert', 'LW', '5'' 11"', 192, '12/24/1989', 9),
(9, 'Gregory', 'Campbell', 'C', '6'' 0"', 197, '12/17/1983', 9),
(23, 'David', 'Clarkson', 'RW', '6'' 0"', 207, '03/31/1987', 9),
(17, 'Brandon', 'Dubinsky', 'C', '6'' 2"', 216, '04/29/1986', 9),
(71, 'Nick', 'Foligno', 'LW', '6'' 0"', 210, '10/31/1987', 9),
(33, 'Markus', 'Hannikainen', 'LW', '6'' 2"', 189, '03/26/1993', 9),
(43, 'Scott', 'Hartnell', 'LW', '6'' 2"', 214, '04/18/1982', 9),
(38, 'Boone', 'Jenner', 'C', '6'' 2"', 215, '06/15/1993', 9),
(19, 'Ryan', 'Johansen', 'C', '6'' 3"', 218, '07/31/1992', 9),
(25, 'William', 'Karlsson', 'C', '6'' 1"', 188, '01/08/1993', 9),
(20, 'Brandon', 'Saad', 'LW', '6'' 1"', 202, '10/27/1992', 9),
(41, 'Alexander', 'Wennberg', 'C', '6'' 1"', 197, '09/22/1994', 9),
(2, 'Andrew', 'Bodnarchuk', 'D', '5'' 11"', 196, '07/11/1988', 9),
(4, 'Kevin', 'Connauton', 'D', '6'' 2"', 205, '02/23/1990', 9),
(44, 'Justin', 'Falk', 'D', '6'' 5"', 224, '10/11/1988', 9),
(29, 'Cody', 'Goloubef', 'D', '6'' 1"', 201, '11/30/1989', 9),
(7, 'Jack', 'Johnson', 'D', '6'' 1"', 230, '01/31/1987', 9),
(27, 'Ryan', 'Murray', 'D', '6'' 1"', 208, '09/27/1993', 9),
(47, 'Dalton', 'Prout', 'D', '6'' 3"', 230, '03/13/1990', 9),
(58, 'David', 'Savard', 'D', '6'' 2"', 227, '10/22/1990', 9),
(51, 'Fedor', 'Tyutin', 'D', '6'' 2"', 221, '07/19/1983', 9),
(72, 'Sergei', 'Bobrovsky', 'G', '6'' 2"', 199, '09/20/1988', 9),
(70, 'Joonas', 'Korpisalo', 'G', '6'' 3"', 182, '04/28/1994', 9),
(30, 'Curtis', 'McElhinney', 'G', '6'' 3"', 205, '05/23/1983', 9)



/* query the hky_players table to see if insert statement worked as intended */
SELECT player_id AS ID, CONCAT(player_firstname, ' ', player_lastname) AS Player, CONCAT(team_city, ' ', team_name) AS Team,
CASE player_position
WHEN 'D'	THEN 'Defenseman'
WHEN 'G'	THEN 'Goalie'
WHEN 'LW'	THEN 'Left Winger'
WHEN 'RW'	THEN 'Right Winger'
WHEN 'C'	THEN 'Center'
END AS Position
FROM hockey_main.dbo.hky_players AS p
INNER JOIN hockey_main.dbo.hky_teams AS t
ON p.team_id = t.team_id;

SELECT * FROM hky_players AS P
INNER JOIN hky_teams AS T
ON P.team_id = T.team_id 
WHERE player_lastname = 'Gaudreau';