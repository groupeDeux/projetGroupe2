/* LesDelegations*/
/*
Insert INTO LesDelegations (pays)
select distinct PAYS
FROM INISPORTIFS;*/

/*LesBatiments*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

/* LesChambres*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

/*LesParticipants - Sportifs*/
INSERT INTO lesParticipants(idParticipant,pays)
select NS,pays
from INISPORTIFS; 

/*LesParticipants - Equipe*/
INSERT INTO lesParticipants(idParticipant,pays)
select Nequipe,pays
from INISPORTIFSEQ;

/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);

/*LesEquipes*/
INSERT INTO LesEquipes(idEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;



        
