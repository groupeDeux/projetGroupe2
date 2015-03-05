/**View**/
DROP VIEW viewDelegation;
DROP VIEW viewChambre;
DROP VIEW viewEpreuve;
DROP VIEW viewEquipe;

/** AchatBillet**/
DROP TABLE LesBillets;
DROP TABLE LesTicketsVideo;
DROP TABLE LesTickets;
DROP TABLE LesTransactions;
DROP TABLE LesComptes;

/**AdministrerCompetition**/
DROP TABLE LesEpreuvesIndividuelles;
DROP TABLE LesEpreuvesParEquipe;
DROP TABLE LesMedailles;
DROP TABLE LesParticipations;
DROP TABLE LesEpreuves;
DROP TABLE LesDisciplines;

DROP TABLE LesConstitutionsEquipe;
DROP TABLE LesEquipes;
DROP TABLE LesSportifs;
DROP TABLE LesParticipants;
DROP TABLE LesDelegations;
DROP TABLE LesChambres;
DROP TABLE LesBatiments;

/*Sequence*/
DROP SEQUENCE seqIdParticipant;
DROP SEQUENCE seqIdEpreuve;
CREATE SEQUENCE seqIdBillet;