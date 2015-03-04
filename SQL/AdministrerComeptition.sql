--DROP TABLE LesDisciplines;
--DROP TABLE LesEpreuves

/**CREATE TABLE LesDisciplines (
nomDiscipline varchar(30),
Constraint LDi_PK PRIMARY KEY (nomDiscipline)
); 

CREATE TABLE LesEpreuves(
idEpreuve INTEGER,
nomEpreuve VARCHAR(30) NOT NULL,
nomDiscipline VARCHAR(30) NOT NULL,
categorie VARCHAR(30) NOT NULL,
dateDebut date,
dateFin date,
urlVideo VARCHAR(100),
tarif NUMBER(5,2),
nombreDePlace INTEGER,
Constraint LEp_PK PRIMARY KEY (idEpreuve),
Constraint LEp_FK1 FOREIGN KEY (nomDiscipline) REFERENCES LesDisciplines(nomDiscipline),
Constraint LEp_C1 unique (urlVideo),
Constraint LEp_C3 CHECK (dateDebut < DateFin)
);

CREATE TABLE LesEpreuvesIndividuelles (
idEpreuve INTEGER,
Constraint LEpInd_PK PRIMARY KEY (idEpreuve),
Constraint LEpInd_FK1 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve)
); 

CREATE TABLE LesEpreuvesParEquipe (
idEpreuve INTEGER,
nbPersonneFixe INTEGER,
Constraint LEpEq_PK PRIMARY KEY (idEpreuve),
Constraint LEpEq_FK1 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve)
); */

CREATE TABLE LesDelegations (
idDelegation INTEGER,
pays VARCHAR(30) NOT NULL,
Constraint LDe_PK PRIMARY KEY (idDelegation)
);

CREATE TABLE LesParticipants (
idParticipant INTEGER,
idDelegation INTEGER,
Constraint LPa_PK PRIMARY KEY (idParticipant),
Constraint LPa_FK1 FOREIGN KEY (idDelegation) REFERENCES LesDelegations(idDelegation)
); 

CREATE TABLE LesBatiments (
nomBatiment VARCHAR(30),
numRue INTEGER,
rue VARCHAR(30),
ville VARCHAR(30),
Constraint LBa_PK PRIMARY KEY (nomBatiment) 
);

CREATE TABLE LesChambres (
numChambre INTEGER,
nomBatiment VARCHAR(30), 
capacite INTEGER,
Constraint LCh_PK PRIMARY KEY (numChambre)
Constraint LCh_FK1 FOREIGN KEY (nomBatiment) REFERENCES LesBatiments(nomBatiment)
);

CREATE TABLE LesSportifs (
idSportif INTEGER,
nom VARCHAR(30),
prenom VARCHAR(30), 
dateNaissance date,
genre VARCHAR(30),
descriptionHandicap VARCHAR(30),
numChambre INTEGER,
Constraint LSp_PK PRIMARY KEY (idSportif),
Constraint LSp_FK1 FOREIGN KEY (idSportif) REFERENCES LesParticipants(idParticipant),  )
Constraint LSp_FK2 FOREIGN KEY (numChambre) REFERENCES LesChambres(numChambre)
);

CREATE TABLE LesEquipes (
idEquipe INTEGER,
nomEquipe VARCHAR(30),
categorie VARCHAR(30),
Constraint LEq_PK PRIMARY KEY (idEquipe),
Constraint LEq_FK1 FOREIGN KEY (idEquipe) REFERENCES LesParticipants(idParticipant)
);

