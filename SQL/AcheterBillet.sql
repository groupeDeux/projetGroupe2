CREATE TABLE LesComptes
(
identifiant VARCHAR(30),
nom VARCHAR(30) NOT NULL,
prenom VARCHAR(30) NOT NULL,
numeroRue INTEGER,
rue VARCHAR(30),
ville VARCHAR(30),
numeroTelephone VARCHAR(30),
mail VARCHAR(50) NOT NULL,
Constraint LCo_PK PRIMARY KEY (identifiant),
Constraint LCo_C1 UNIQUE (mail)
);


CREATE TABLE LesTransactions
(
idTransaction INTEGER ,
identifiant VARCHAR(30) NOT NULL,
Constraint LTr_PK PRIMARY KEY (idTransaction),
Constraint LTr_FK1 FOREIGN KEY (identifiant) REFERENCES LesComptes(identifiant)
);


CREATE TABLE LesTickets
(
idTicket INTEGER,
idTransaction INTEGER NOT NULL,
idEpreuve INTEGER NOT NULL,
Constraint LTi_PK PRIMARY KEY (idTicket)
Constraint LTi_FK1 FOREIGN KEY (idTransaction) REFERENCES LesTransactions(idTransaction),
Constraint LTi_FK2 FOREIGN KEY (idEpreuve) REFERENCES LesEpreuves(idEpreuve)**/
);
