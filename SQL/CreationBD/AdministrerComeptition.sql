

CREATE TABLE LesDisciplines (
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
nbDePlace INTEGER,
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
Constraint LEpEq_PK PRIMARY KEY (nidEpreuve),
Constraint LEpEq_FK1 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve)
); 

CREATE TABLE LesDelegations (
idDelegation INTEGER,
pays VARCHAR(30) NOT NULL,
Constraint LDe_PK PRIMARY KEY (idDelegation)
);

CREATE TABLE LesParticipants (
idParticipant INTEGER,
idDelegation INTEGER NOT NULL,
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
numChambre VARCHAR(30),
nomBatiment VARCHAR(30), 
capacite INTEGER,
Constraint LCh_PK PRIMARY KEY (numChambre,nomBatiment),
Constraint LCh_FK1 FOREIGN KEY (nomBatiment) REFERENCES LesBatiments(nomBatiment)
);

CREATE TABLE LesSportifs (
idSportif INTEGER,
nom VARCHAR(30) NOT NULL,
prenom VARCHAR(30) NOT NULL, 
dateNaissance date NOT NULL,
genre VARCHAR(30),
descriptionHandicap VARCHAR(30),
numChambre VARCHAR(30),
nomBatiment VARCHAR(30),
Constraint LSp_PK PRIMARY KEY (idSportif),
Constraint LSp_FK1 FOREIGN KEY (idSportif) REFERENCES LesParticipants(idParticipant),  
Constraint LSp_FK2 FOREIGN KEY (numChambre,nomBatiment) REFERENCES LesChambres(numChambre, nomBatiment)
);

CREATE TABLE LesEquipes (
idEquipe INTEGER,
nomEquipe VARCHAR(30),
categorie VARCHAR(30) NOT NULL,
Constraint LEq_PK PRIMARY KEY (idEquipe),
Constraint LEq_FK1 FOREIGN KEY (idEquipe) REFERENCES LesParticipants(idParticipant)
);

CREATE TABLE LesConstitutionsEquipe (
idEquipe INTEGER, 
idSportif INTEGER,
Constraint CEq_PK PRIMARY KEY (idEquipe,idSportif),
Constraint CEq_FK1 FOREIGN KEY (idEquipe) REFERENCES LesEquipes(idEquipe),
Constraint CEq_FK2 FOREIGN KEY (idSportif) REFERENCES LesSportifs(idSportif)
); 

CREATE TABLE LesMedailles (
idEpreuve INTEGER,
idParticipant INTEGER,
valeur VARCHAR(30) NOT NULL,
Constraint LMe_PK PRIMARY KEY (idEpreuve, idParticipant),
Constraint LMe_FK1 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve),
Constraint LMe_FK2 FOREIGN KEY (idParticipant) REFERENCES LesParticipants(idParticipant),
Constraint LMe_C1 UNIQUE (idEpreuve, valeur)
);

CREATE TABLE LesParticipations (
idEpreuve INTEGER,
idParticipant INTEGER,
Constraint Pa_PK PRIMARY KEY (idEpreuve, idParticipant),
Constraint Pa_FK1 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve),
Constraint Pa_FK2 FOREIGN KEY (idParticipant) REFERENCES LesParticipants(idParticipant)
);

/**Creation des views**/
CREATE VIEW viewDelegation as 
    SELECT idDelegation,pays,COUNT(idPArticipant) as nbSportif
    FROM LesParticipants
    JOIN LesDelegations USING(idDelegation)
    GROUP BY(idDelegation,pays);

CREATE VIEW viewEquipe as
    SELECT idEquipe,nomEquipe,categorie,count(idSportif) as nbMembre
    FROM LesEquipes
    JOIN LesConstitutionsEquipe USING(numEquipe)
    GROUP BY (idEquipe,nomEquipe,categorie);

/**A Faire**/
CREATE VIEW viewChambre as
CREATE VIEW viewEpreuve as
  