/* LesDelegations*/
Insert INTO LesDelegations (pays)
select distinct PAYS
FROM INISPORTIFS;

/* viewDelegation

LesDelegations(NBSPORTIF)
SELECT INTO ViewLesDelegations (nbSportif,pays)
select COUNT (DISTINCT NS) AS NBSPORTIF,PAYS
FROM JO.LESSPORTIFS
GROUP BY PAYS ; */

/*LesBatiments*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

/* LesChambres*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

/*LesParticipants*//
INSERT INTO lesParticipants(idDelegation)
select idDelegation
from INISPORTIFS
JOIN LesDelegations
USING (pays); 

/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);



/* A REVOIR AVEC NUMSPORTIF*/


/*LesEquipes*/
INSERT INTO LesEquipes(nomEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;

/*
/* Table LesSportif avec premier idParticipant disponible */
INSERT INTO  LesSportifs(idSportif, nom,prenom, dateNaissance, genre,numChambre,nomBatiment)
SELECT idParticipant,nom,prenom,dateNaissance,genre,numChambre,nomBatiment
FROM inilogementinit
    JOIN inisportif 
    using(nom,prenom)
    join (Select idDelegation
            from IniSportifs
                join LesDelegations
                using pays) R1
    join (select min(idParticipant),idDelegation
            from LesParticipants
            minus (select idParticipant, idDelegation 
                    from LesParticipants P
                    join LesSportifs S
                    on P.idParticipant=S.idSportif);
        
