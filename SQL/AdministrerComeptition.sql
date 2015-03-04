CREATE TABLE LesDiciplines (
nomDisciplne VARCHAR(30),
Constraint LDi_PK PRIMARY KEY nomDiscipline
);

CREATE TABLE LesEpreuves (
idEpreuve INTEGER,
nomEpreuve VARCHAR(30),
nomDiscipline VARCHAR(30),
categorie VARCHAR(30),
dateDebut date,
dateFin date,
urlVideo VARCHAR(100),
tarif NUMBER(5,2),
nombreDePlace INTEGER,
Constraint LEp_PK PRIMARY KEY idEpreuve,
Constraint LEp_FK1 FOREIGN KEY nomDiscipline REFERENCES LesDisciplines(nomDiscipline),
Constraint LEp_C1 unique urlVideo,
Constraint LEp_C3 CHECK dateDebut < DateFin)
);