
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
DELETE FROM hky_players
WHERE player_jersey_num = 35;

/* add Boston Bruins 2015 roster to database */
INSERT INTO hky_players
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
INSERT INTO hky_players
(player_jersey_num, player_firstname, player_lastname, player_position, player_height, player_weight, player_birthdate, team_id)
VALUES
(44, 'Nicolas', 'Deslauriers', 'LW', '6'' 1"', 212, '02/22/1991', 4),
(15, 'Jack', 'Eichel', 'C', '6'' 2"', 201, '10/28/1996', 4),
(

/* query the hky_players table to see if insert statement worked as intended */
SELECT CONCAT(player_firstname, ' ', player_lastname) AS Player, CONCAT(team_city, ' ', team_name) AS Team,
CASE player_position
WHEN 'D'	THEN 'Defenseman'
WHEN 'G'	THEN 'Goalie'
WHEN 'LW'	THEN 'Left Winger'
WHEN 'RW'	THEN 'Right Winger'
WHEN 'C'	THEN 'Center'
END AS Position
FROM hky_players AS p
INNER JOIN hky_teams AS t
ON p.team_id = t.team_id;