/* LesDelegations*/
SELECT INTO LesDelegations (pays)
select distinct PAYS
FROM INISPORTIFS;

/*LesDelegations(NBSPORTIF)
SELECT INTO ViewLesDelegations (nbSportif,pays)
select COUNT (DISTINCT NS) AS NBSPORTIF,PAYS
FROM JO.LESSPORTIFS
GROUP BY PAYS ; */

/*LesBatiments*/
SELECT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

/* LesChambres*/
SELECT INTO LesChambres (numChambre,nomBatiment, capacite)
select NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

/*LesSportifs*/
INSERT INTO  LesSportifs(numSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);

/*LesEquipes*/
INSERT INTO LesEquipes(nomEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;


/*LesParticipants*//
INSERT INTO lesParticipants(idDelegation)
select idDelegation
from INISPORTIFS
JOIN LesDelegations
USING (pays); 
