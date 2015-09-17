-- Football Competition Coordination SQL to create and populate tables

/* Drop Table statements are included for each table to ensure that
when you create the tables no tables with the same name exist. */
DROP TABLE Match CASCADE CONSTRAINTS PURGE;
DROP TABLE Referee CASCADE CONSTRAINTS PURGE;
DROP TABLE Player CASCADE CONSTRAINTS PURGE;
DROP TABLE Team CASCADE CONSTRAINTS PURGE;
DROP TABLE Manager CASCADE CONSTRAINTS PURGE;
DROP TABLE Club CASCADE CONSTRAINTS PURGE;
DROP TABLE Sponsor CASCADE CONSTRAINTS PURGE;
DROP TABLE Competition CASCADE CONSTRAINTS PURGE;

/* Create table statements
Tables are created in 2 layers following a given order:
1st: Those with no foreign keys are created first
2nd: Tables depending only on these tables i.e. have foreign key relationships to 1st layer
3rd: Tables depending on 2nd layer or combination of 1st and 2nd layer
*/
-- Create table Sponsor - holds data on the Sponsors for each competition
CREATE TABLE Sponsor
(
    SponsorID            NUMBER(6) NOT NULL ,
    SponsorName          VARCHAR2(30) NULL ,
CONSTRAINT Sponsor_PK PRIMARY KEY (SponsorID)
);

-- Create table Manager - holds data on the Managers for each team
CREATE TABLE Manager
(
    ManagerID            NUMBER(6) NOT NULL ,
    MAddress             VARCHAR2(30) NULL ,
    MPhoneNumber         VARCHAR2(10) NULL ,
    ManagerName          VARCHAR2(30) NULL ,
CONSTRAINT  Manager_PK PRIMARY KEY (ManagerID)
);

-- Create table Referee - holds data on all referees available
CREATE TABLE Referee
(
    RefereeID            NUMBER(6) NOT NULL ,
    RName                VARCHAR2(30) NULL ,
    Address              VARCHAR2(30) NULL ,
    DateOfBirth          DATE NULL ,
CONSTRAINT Referee_PK PRIMARY KEY (RefereeID)
);


-- Create table Competition - holds details of all Competitions taking place
CREATE TABLE Competition
(
    CompetitionID        NUMBER(6) NOT NULL ,
    CompetitionName      VARCHAR2(30) NULL ,
    Prize                NUMBER(5,2) NULL ,
    CompetitionFee       NUMBER(5,2) NULL ,
    OrganizersName       VARCHAR2(30) NULL ,
    ContactNumber        VARCHAR2(10) NULL ,
    Age                  NUMBER(2) NULL ,
    SponsorName          VARCHAR2(30) NULL ,
    SponsorID            NUMBER(6) NULL ,
CONSTRAINT Competition_PK PRIMARY KEY (CompetitionID),
CONSTRAINT Sponsor_competition_FK FOREIGN KEY (SponsorID) REFERENCES Sponsor (SponsorID)
);

-- Create table Club - holds details of all Clubs involved in the competitions
CREATE TABLE Club
(
    ClubID               NUMBER(6) NOT NULL ,
    Address              VARCHAR2(30) NULL ,
    ClubMName            VARCHAR2(20) NULL ,
    HomeGrounds          VARCHAR2(20) NULL ,
    Directions           VARCHAR2(30) NULL ,
    ClubName             VARCHAR2(30) NULL ,
    CompetitionID        NUMBER(6) NULL ,
CONSTRAINT Club_PK PRIMARY KEY (ClubID),
CONSTRAINT Competition_Club_FK FOREIGN KEY (CompetitionID) REFERENCES Competition (CompetitionID)
);

-- Create table team - holds details of all teams in each club
CREATE TABLE Team
(
    TeamID               VARCHAR2(20) NOT NULL ,
    TeamName             VARCHAR2(20) NOT NULL ,
    AgeGroup             NUMBER(2) NULL ,
    Prize                NUMBER(5,2) NULL ,
    ClubID               NUMBER(6) NULL ,
    ManagerID            NUMBER(6) NULL ,
    CompetitionID        NUMBER(6) NULL ,
CONSTRAINT Team_PK PRIMARY KEY (TeamID),
CONSTRAINT Club_Team_FK FOREIGN KEY (ClubID) REFERENCES Club (ClubID),
CONSTRAINT Manager_Team_FK FOREIGN KEY (ManagerID) REFERENCES Manager (ManagerID),
CONSTRAINT Competition_Team_FK FOREIGN KEY (CompetitionID) REFERENCES Competition (CompetitionID)
);

-- Create table Player - holds data on the Players in each team
CREATE TABLE Player
(
    PlayerID             NUMBER(6) NOT NULL ,
    PName                VARCHAR2(30) NULL ,
    Address              VARCHAR2(30) NULL ,
    GuardianName         VARCHAR2(30) NULL ,
    DateOfBirth          DATE NULL ,
    TeamID               VARCHAR2(20) NULL ,
CONSTRAINT Player_PK PRIMARY KEY (PlayerID),
CONSTRAINT Team_Player_FK FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
);

-- Create table Matches - holds data on each Match for each competition
CREATE TABLE Match
(
    MatchID              NUMBER(6) NOT NULL ,
    Venue                VARCHAR2(20) NULL ,
    MDate                DATE NULL ,
    MTime                TIME NULL ,
    RefereeID            NUMBER(6) NULL ,
    CompetitionID        NUMBER(6) NULL ,
    HomeTeam             VARCHAR2(20) NULL ,
    AwayTeam             VARCHAR2(20) NULL ,
CONSTRAINT Match_PK PRIMARY KEY (MatchID),
CONSTRAINT Referee_Match_FK FOREIGN KEY (RefereeID) REFERENCES Referee (RefereeID),
CONSTRAINT Comp_Match_FK FOREIGN KEY (CompetitionID) REFERENCES Competition (CompetitionID),
CONSTRAINT HTeam_Match_FK FOREIGN KEY (HomeTeam) REFERENCES Team (TeamID),
CONSTRAINT ATeam_Match_FK FOREIGN KEY (AwayTeam) REFERENCES Team (TeamID)
);

-- Insert statements to populate the tables

-- Sponsor inserted first
--insert into Sponsor values(SponsorID, 'SponsorName');
insert into Sponsor values(1, 'Dundrum Credit Union');
insert into Sponsor values(2, 'SuperValue');
insert into Sponsor values(3, 'Kenwoods');
insert into Sponsor values(4, 'Panasonic');
insert into Sponsor values(5, 'Philips');
insert into Sponsor values(6, 'Tesco');
insert into Sponsor values(7, 'Smyths');
insert into Sponsor values(8, 'Canon');
-- Manager inserted next
--insert into Manager values(ManagerID, MAddress, MPhoneNumber, ManagerName);
insert into Manager values(20, '20 Grange Manor', '086876349', 'Mike Green');
insert into Manager values(21, '37 Grange Manor Avenue', '0863140678', 'Paul Kerry');
insert into Manager values(22, '21 Marley Court', '0875673029', 'Mike Black');
insert into Manager values(23, '102 White Church', '0864100677', 'April Smith');
insert into Manager values(24, '47 Grange Road', '0863740697', 'Ross Doyle');
insert into Manager values(25, '55 Church Bay Road', '0870699429', 'Tom McKenna');
insert into Manager values(26, '8 Water Crescent Road', '0868140678', 'Joseph Behan');
insert into Manager values(27, '12 Windy Arbour', '0876672129', 'Anika Babel');
insert into Manager values(28, '17 St Johns Road', '0876443099', 'Aisling OKeirsey');
insert into Manager values(29, '90 Rathfarnham Road', '0863540678', 'Nick Kenny');
-- Referee inserted next
--insert into Referee values(RefereeID, RName, Address, DateOfBirth);
insert into Referee values(11, 'Joe Smith', '13 Simmons Court', '24-Jan-1990');
insert into Referee values(12, 'Frank Sweeney', '35 Kilakee Green', '24-Jan-1992');
insert into Referee values(13, 'Alan Garvin', '70 Cedarbrook Avenue', '24-Jan-1985');
insert into Referee values(14, 'Cian Dignan', '1 York Court', '24-Jan-1997');
insert into Referee values(15, 'Gavin Fahy', '123 Walkinstown Ave', '24-Jan-1991');
insert into Referee values(16, 'Niamh Keogh', '39 Cooldriona Court', '24-Jan-1995');
insert into Referee values(17, 'Ruth OHara', '4 Belfry Downs', '24-Jan-1987');
insert into Referee values(18, 'Alison McHugo', '70 Foxrock', '24-Jan-1992');
insert into Referee values(19, 'Cian Barry', '23 Grange Manor Drive', '24-Jan-1994');
-- Competition inserted next
-- insert into Competition values(CompetitionID, CompetitionName, Prize, CompetitionFee, OrganizersName, ContactNumber, Age, SponsorName, SponsorID);
insert into Competition values(220, 'All Stars', 800.00, 15.00, 'Fiona Kerry', '0864540913', 16, 'Dundrum Credit Union', 1);
insert into Competition values(221, 'Under.16', 900.00, 10.00, 'Helena Pembroke', '0863724087', 15, 'SuperValue', 2);
insert into Competition values(222, 'Open Comp', 950.00, 20.00, 'Aidan Doyle', '0873451032', 19, 'Kenwoods', 3);
insert into Competition values(223, 'Football Fest', 400.00, 0.00, 'Joe Keegan', '0863240174', 10, 'Panasonic', 4);
insert into Competition values(224, 'FAI Qualifier', 600.00, 10.00, 'Jack Smith', '0863121668', 12, 'Philips', 5);
insert into Competition values(225, 'Mini Cup', 100.00, 05.00, 'Jake Fahey', '0874562093', 6, 'Tesco', 6);
-- Club inserted next
--insert into Club values(ClubID, Address, ClubMName, HomeGrounds, Directions, ClubName, CompetitionID);
insert into Club values(40, 'Bushy Park', 'Keith Walsh', 'Cherry Wood', '53.286498, -6.274824', 'Cherry Wood FC', 220);
insert into Club values(41, 'Tymon Park', 'Tony Pierce', 'Tymon', '53.273442, -6.268843', 'Ael Rovers', 221);
insert into Club values(42, 'Marlay Park', 'Mary Jordan', 'Marlay', '53.329027, -6.230491', 'BarnX AFC', 224);
insert into Club values(43, 'Corkag Park', 'Emmet Byrne', 'Corkag', '53.257183, -6.139275', 'Corkag Park', 222);
insert into Club values(44, 'Marley Park', 'Aaron Gibbins', 'Marley', '53.285614, -6.294864', 'St Johns FC', 220);
insert into Club values(45, 'Broadford Park', 'Nora ONeill', 'Broadford', '53.360882, -6.251177', 'Broadford Rovers', 223);
insert into Club values(46, 'Mountain Park', 'Kieran Murphy', 'Tallaght', '53.322197, -6.265792', 'Tallaght FC', 221);
insert into Club values(47, 'Foxrock Park', 'Laura Walsh', 'Foxrock', '53.301889, -6.339938', 'Foxrock FC', 224);
insert into Club values(48, 'Ballybodan Park', 'Charlie Brown', 'Ballybodan', '53.303040, -6.178929', 'Ballybodan st Endas', 222);
insert into Club values(49, 'St Endas Park', 'Maria Black', 'Endas', '53.243127, -6.143867', 'Leister Celic', 220);
-- Team inserted first
--insert into Team values(TeamID, TeamName, AgeGroup, ManagerName, MPhoneNumber, MAddress, Prize, ClubID, ManagerID, CompetitionID);
insert into Team values(10, 'Tiny Strikers', 10, 200.00, 40, 20, 223);
insert into Team values(11, 'Golden Eagles', 15, 900.00, 41, 21, 221);
insert into Team values(12, 'King Players', 12, 0.0, 42, 22, 224);
insert into Team values(13, 'Aces', 19, 0.0, 43, 23, 222);
insert into Team values(14, 'All Whites', 16, 0.0, 44, 24, 220);
insert into Team values(15, 'Fighting Lizards', 10, 400.00, 45, 25, 223);
insert into Team values(16, 'All Stars', 15, 0.0, 46, 26, 221);
insert into Team values(17, 'Strikers', 12, 600.00 , 47, 27, 224);
insert into Team values(18, 'Force', 19, 950.00, 48, 28, 222);
insert into Team values(19, 'Bandits', 16, 800.00, 49, 29, 220);
-- Player inserted next
--insert into Player values(PlayerID, PName, Address, GuardianName, DateOfBirth, TeamID);
insert into Player values(50, 'Bryan Mckeever', '37 Grange Manor', 'Sean Smith', '24-Jan-2005', 10);
insert into Player values(51, 'Josh Casey', '4 Donnybrook Way', 'Orla Casey', '24-Jan-2000', 11);
insert into Player values(52, 'Stephen Keogh', '9 Dolphins Barn Road', 'Ronan Keogh', '24-Jan-2003', 12);
insert into Player values(53, 'Connor Seery', '21 Cherry Orchard', 'Jennifer Seery', '24-Jan-1994', 13);
insert into Player values(54, 'Alex Green', '2 Enniskerry Road', 'Ciara Green', '24-Jan-1999', 14);
insert into Player values(55, 'Aaron Fox', '28 Taney Crescent', 'Dylan Fox', '24-Jan-2005', 15);
insert into Player values(56, 'Shane OConnor', '199 Old Bawn Road', 'Shauna OConnor', '24-Jan-2000', 16);
insert into Player values(57, 'Mark Malin', '30 Hillsbrook Grove', 'Cliodhna Malin', '24-Jan-2003', 17);
insert into Player values(58, 'Gerrard Morris', '8 Redwood Avenue', 'James Morris', '24-Jan-1994', 18);
insert into Player values(59, 'Tom Collins', '23 McKee Road', 'John Collins', '24-Jan-1999', 19);
-- Match inserted finally
--insert into Match values(MatchID, Venue, MDate, MTime, RefereeID, CompetitionID, HomeTeam, AwayTeam);
insert into Match values(30, 'Marley Park', '18-Jan-2014', '14:00:00', 11, 220, 14, 19);
insert into Match values(31, 'Tymon Park Park', '24-Jan-2014', '12:00:00', 19, 221, 11, 16);
insert into Match values(32, 'Ballybodan Park', '04-Feb-2014', '15:00:00', 12, 222, 18, 13);
insert into Match values(33, 'Broadford Park', '11-Feb-2014', '11:00:00', 13, 223, 15, 10);
insert into Match values(34, 'Foxrock Park', '14-Feb-2014', '15:00:00', 14, 224, 17, 12);
insert into Match values(35, 'St Endas Park', '16-Feb-2014', '11:00:00', 15, 220, 19, 14);
insert into Match values(36, 'Mountain Park', '12-Feb-2014', '10:30:00', 16, 221, 16, 11);
insert into Match values(37, 'Corkag Park', '10-Mar-2014', '13:00:00', 17, 222, 13, 18);
insert into Match values(38, 'Bushy Park', '18-Mar-2014', '12:00:00', 18, 223, 10, 15);
insert into Match values(39, 'Marley Park', '23-Mar-2014', '16:00:00', 19, 224, 12, 17);
-- Commit included to persist the data
commit;

--Queries that are to be created
--[SINGLE ROW] Select all information on matches taking part in February 2014
SELECT * from Match WHERE MDate BETWEEN '01-Feb-2014' AND '28-Feb-2014';

--[AGGREGATE] Count the number of teams under the age of 15
SELECT COUNT(TeamID) FROM Team WHERE AgeGroup >= 15;

--[INNER JOIN; 2] Select the winners of each competition and get the managers names and addresses
SELECT ManagerName, MAddress, MPhoneNumber FROM Manager INNER JOIN Team ON Manager.ManagerID = Team.ManagerID WHERE Prize <> 0;

--[INNER JOIN; 3] Display the referees names involved in the 'All Stars Competition'
SELECT RNAME FROM Referee INNER JOIN Match ON Referee.RefereeID = Match.RefereeID JOIN Competition ON Match.CompetitionID = Competition.CompetitionID WHERE CompetitionName = 'All Stars';

--[LEFT OUTER JOIN] Select all competitions, and show which are sponsored by Supervalue and Tesco
SELECT CompetitionName FROM Competition LEFT OUTER JOIN Sponsor ON Competition.SponsorID = Sponsor.SponsorID WHERE CompetitionName = 'SuperValue' OR 'Tesco';

--[RIGHT OUTER JOIN] Select All team names, and the players for 'Tiny Strikers'
SELECT p.PName, t.TeamNames FROM Player AS p RIGHT OUTER JOIN Team AS t ON p.TeamID = t.TeamID WHERE t.TeamName = 'Tiny Strikers';


--Details that are to be created 
--[UPDATE] Change the Name and address details for the referee 'Alan Garvin'
UPDATE Referee SET RName='Alex Garvin', Address='69 Cedarbrook Avenue' WHERE RName='Alan Garvin'; 

--[ADD COLUMN] Add the column 'JerseyNumber' to the player table with data type VARCHAR
ALTER TABLE Player ADD JerseyNumber VARCHAR2(2);

--[ADD VALUE] Make that the players addresses must be unique 
ALTER TABLE Player ADD CONSTRAINT Constraint_1 UNIQUE (Address);

--[DROP] DROP the column 'JerseyNumber' to the player table
ALTER TABLE Player DROP JerseyNumber;

--[MODIFY] Change the data type in column 'JerseyNumber' in the player table to NUMBER
ALTER TABLE Player MODIFY JerseyNumber NUMBER(2);

--[DROP VALUE] Drop the unique constraint that has been placed on the address in the player table
ALTER TABLE Player DROP INDEX Constraint_1;
