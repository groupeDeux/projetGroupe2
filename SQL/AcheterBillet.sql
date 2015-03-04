CREATE TABLE LesComptes (
identifiant VARCHAR(30),
nom VARCHAR(30) NOT NULL,
prenom VARCHAR(30) NOT NULL,
numRue INTEGER,
rue VARCHAR(30),
ville VARCHAR(30),
numTelephone VARCHAR(30),
mail VARCHAR(50) NOT NULL,
Constraint LCo_PK PRIMARY KEY (identifiant),
Constraint LCo_C1 UNIQUE (mail)
);

CREATE TABLE LesTransactions (
idTransaction INTEGER ,
identifiant VARCHAR(30) NOT NULL,
Constraint LTr_PK PRIMARY KEY (idTransaction),
Constraint LTr_FK1 FOREIGN KEY (identifiant) REFERENCES LesComptes(identifiant)
);

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

CREATE TABLE LesTickets (
idTicket INTEGER,
idTransaction INTEGER NOT NULL,
idEpreuve INTEGER NOT NULL,
Constraint LTi_PK PRIMARY KEY (idTicket),
Constraint LTi_FK1 FOREIGN KEY (idTransaction) REFERENCES LesTransactions(idTransaction),
Constraint LTi_FK2 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve)
);

CREATE TABLE LesBillets (
idBillet INTEGER, 
Constraint LBi_PK PRIMARY KEY (idBillet)
);

CREATE TABLE LesTicketsVideo (
idTicketVideo INTEGER,
codeAcces VARCHAR(30),
Constraint LTiVid_PK PRIMARY KEY (idTicketVideo),
Constraint LTiVid_FK1 FOREIGN KEY (idTicketVideo) REFERENCES LesTickets(idTicket)
);


