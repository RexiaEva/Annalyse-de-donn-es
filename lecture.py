Code la procédure
# DELIMITER $$
# CREATE DEFINER=`root`@`localhost` PROCEDURE `remplirBase`(IN `ID` INT, IN `Name` VARCHAR(26), IN `Sex` CHAR(1), IN `Age` INT, IN `Height` INT, IN `Weight` INT, IN `Team` VARCHAR(26), IN `NOC` CHAR(3), IN `Games` VARCHAR(26), IN `Year_games` SMALLINT(4), IN `Season` VARCHAR(26), IN `City` VARCHAR(26), IN `Sport` VARCHAR(26), IN `Event` VARCHAR(35), IN `Medal` VARCHAR(26))
# BEGIN
#     INSERT IGNORE INTO `athletes`(`id_athlete`, `nom`, `sexe`) VALUES (ID, Name, Sex);

#     INSERT IGNORE INTO `jeux`(jeux, `ville`, `saison`, `an`) VALUES (Games, City, Season, Year_games);

#     INSERT IGNORE INTO `sport`(`sport`) VALUES (Sport);

#     INSERT IGNORE INTO `evenements`(`evenement`, `sport_id`, `jeux_id`)
#     SELECT Event, id_sport, id_jeux
#     FROM sport, jeux
#     WHERE sport.sport = Sport AND jeux.jeux = Games;

#     INSERT IGNORE INTO `team`(`nom`, `noc_id`)
#     SELECT Team, id_noc
#     FROM noc
#     WHERE noc.NOC = NOC;

#     INSERT IGNORE INTO `team_athlete`(`team_id`, `athlete_id`)
#     SELECT id_team, ID
#     FROM team, athletes
#     WHERE team.nom = Team;

#     INSERT IGNORE INTO `pratique`(`sport_id`, `athlete_id`)
#     SELECT id_sport, ID
#     FROM sport, athletes
#     WHERE sport.sport = Sport;

#     INSERT INTO participation
#         (`age`, `weight`, `height`, `medaille`, `athlete_id`, `team_id`, `evenement_id`)
#     SELECT Age, Weight, Height, Medal, ID, id_team, id_evenement
#     FROM team, evenements
#     WHERE team.nom = Team AND evenements.evenement = Event;
# END$$
# DELIMITER ;

import pandas
import bdd

jo = bdd.BDD('jo','root','root', 'localhost', 8081)
df = pandas.read_csv('athlete_events.csv')
sql = """CALL remplirBase(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"""
var = []
i = 0
for x in df.itertuples():
    if i > 0:
        var.append(x)
    i+=1
print(i, "lignes lues")
jo.curseur.executemany(sql,var)
print("ça interprète")
