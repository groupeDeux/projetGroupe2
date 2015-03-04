/*LesSportifs*/
INSERT INTO  LesSportifs(numSportif,nom, prenom,dateNaissance,genre) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE
FROM INILESSPORTIFS;

/*LesEquipes*/
INSERT INTO LesEquipes(numEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INILESSPORTIFSEQ;

/*LesBatiments*/
SELECT INTO LesBatiments (nomBatiment, numeroRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILESLOGEMENTSINIT;

/* LesChambres*/
SELECT INTO LesChambres (numChambre, capacite)
select NLOGEMENT,CAPACITE
FROM INILESLOGEMENTSINIT;

/* LesDelegations*/
SELECT INTO LesDelegations (pays)
select distinct PAYS
FROM INILESSPORTIFS;


/*LesDelegations(NBSPORTIF)*/
SELECT INTO ViewLesDelegations (nbSportif,pays)
select COUNT (DISTINCT NS) AS NBSPORTIF,PAYS
FROM JO.LESSPORTIFS
GROUP BY PAYS ;

/*LesParticipants*/
INSERT INTO lesParticipants(idParticipant, idDelegation)
select NS, idDelegation
from INILESSPORTIFS
JOIN LesDelegations
USING (pays); 
