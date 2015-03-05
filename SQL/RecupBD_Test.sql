/*DROP TABLE LesBatiments;

CREATE TABLE LesBatiments (
nomBatiment VARCHAR(30),
numRue INTEGER,
rue VARCHAR(30),
ville VARCHAR(30),
Constraint LBa_PK PRIMARY KEY (nomBatiment) 
);

/*LesBatiments --> valide*/
/*INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select distinct (NOMBAT),NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

select count(nomBatiment) from Lesbatiments;
Select count(distinct NomBat) from InilogementsInit;*/

/*
DROP TABLE LesChambres;

CREATE TABLE LesChambres (
numChambre VARCHAR(30),
nomBatiment VARCHAR(30), 
capacite INTEGER,
Constraint LCh_PK PRIMARY KEY (numChambre,nomBatiment),
Constraint LCh_FK1 FOREIGN KEY (nomBatiment) REFERENCES LesBatiments(nomBatiment)
);

/*LesChambres --> valide*/
/*
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select distinct NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

select nomBatiment,count(numChambre) from LesChambres group by nomBatiment;
Select nomBat,count(distinct Nlogement) from InilogementsInit group by nomBat;

select sum(nbChambre) from 
    (select count(numChambre) as nbChambre from LesChambres group by nomBatiment)R1;

select sum(nbChambre) from 
    (select count(distinct Nlogement) as nbChambre from InilogementsInit group by nomBat)R1;*/



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

/*LesSportifs*/
/*
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);