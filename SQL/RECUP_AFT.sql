/*LesBatiments*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
    SELECT DISTINCT (NOMBAT),NUMERO,RUE,VILLE
    FROM INILOGEMENTSINIT;

/* LesChambres*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
    SELECT DISTINCT NLOGEMENT,NOMBAT,CAPACITE
    FROM INILOGEMENTSINIT;

/*LesParticipants - Sportifs*/
INSERT INTO lesParticipants(idParticipant,pays)
    SELECT NS,pays
    FROM INISPORTIFS; 

/*LesParticipants - Equipe*/
INSERT INTO lesParticipants(idParticipant,pays)
    SELECT DISTINCT (NEquipe),pays
    FROM INISPORTIFSEQ
    WHERE NEquipe is not null;

/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
    SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
    FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM)
    WHERE categorie is not null;

/*LesEquipes*/
INSERT INTO LesEquipes(idEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;



        
