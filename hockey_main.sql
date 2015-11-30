
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
ALTER TABLE hky_teams
ADD CONSTRAINT PK_hky_teams 
PRIMARY KEY (team_id);

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
(89,	'MIKKEL',	'BOEDKER',  	'LW',	'6'' 0"',	211, '12/16/1989', 2),
(24,	'KYLE',		'CHIPCHURA',  	'C',	'6'' 2"',	203, '02/19/1986', 2),
(22,	'CRAIG',	'CUNNINGHAM',  	'Lw',	'5'' 10"',	184, '09/13/1990', 2),
19	SHANE DOAN "C" 	R	6' 1"	223	OCT 10, 1976	39	HALKIRK, AB, CAN
16	MAX DOMI  	L	5' 10"	198	MAR 2, 1995	20	WINNIPEG, MB, CAN
17	STEVE DOWNIE  	R	5' 11"	191	APR 3, 1987	28	NEWMARKET, ON, CAN
10	ANTHONY DUCLAIR  	L	5' 11"	185	AUG 26, 1995	20	POINTE-CLAIRE, QC, CAN
15	BOYD GORDON  	C	6' 0"	200	OCT 19, 1983	32	UNITY, SK, CAN
11	MARTIN HANZAL "A" 	C	6' 6"	226	FEB 20, 1987	28	PISEK, CZE
48	JORDAN MARTINOOK  	L	6' 0"	202	JUL 25, 1992	23	BRANDON, MB, CAN
12	BRAD RICHARDSON  	R	6' 0"	197	FEB 4, 1985	30	BELLEVILLE, ON, CAN
8	TOBIAS RIEDER  	R	5' 11"	185	JAN 10, 1993	22	LANDSHUT, DEU
28	JOHN SCOTT  	L	6' 8"	260	SEP 26, 1982	33	EDMONTON, AB, CAN
50	ANTOINE VERMETTE  	C	6' 1"	198	JUL 20, 1982	33	ST. AGAPIT, QC, CAN
14	JOE VITALE  	C	5' 11"	205	AUG 20, 1985	30	ST. LOUIS, MO, USA
34	KLAS DAHLBECK  	6' 3"	207	JUL 6, 1991	24	KATRINEHOLM, SWE
23	OLIVER EKMAN-LARSSON "A" 	6' 2"	200	JUL 17, 1991	24	KARLSKRONA, SWE
45	STEFAN ELLIOTT  	6' 1"	190	JAN 30, 1991	24	VANCOUVER, BC, CAN
2	NICKLAS GROSSMANN  	6' 4"	230	JAN 22, 1985	30	STOCKHOLM, SWE
4	ZBYNEK MICHALEK  	6' 2"	210	DEC 23, 1982	32	JINDRICHUV HRADEC, CZE
5	CONNOR MURPHY  	6' 4"	212	MAR 26, 1993	22	DUBLIN, OH, USA
25	PHILIP SAMUELSSON  	6' 2"	194	JUL 26, 1991	24	LEKSAND, SWE
26	MICHAEL STONE  	6' 3"	210	JUN 7, 1990	25	WINNIPEG, MB, CAN
35	LOUIS DOMINGUE  	6' 3"	210	MAR 6, 1992	23	ST-HYACINTHE, QC, CAN
29	ANDERS LINDBACK  	6' 6"	215	MAY 3, 1988	27	GÄVLE, SWE
41	MIKE SMITH  	6' 4"	215	MAR 22, 1982	33	KINGSTON, ON, CAN);

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