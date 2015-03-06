/* LesDelegations*/
/*
Insert INTO LesDelegations (pays)
select distinct PAYS
FROM INISPORTIFS;*/

/*LesBatiments*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

select count(nomBatiment) from Lesbatiments;
Select count(distinct NomBat) from InilogementsInit;

/* LesChambres*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

select nomBatiment,count(numChambre) from LesChambres group by nomBatiment;
Select nomBat,count(distinct Nlogement) from InilogementsInit group by nomBat;

select count(nbChambre)
    from (Select count(numChambre) as nbChambre from LesChambres group by nomBatiment;

/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);

/*LesParticipants - Sportifs*/
INSERT INTO lesParticipants(idParticiapant,pays)
select NS,pays
from INISPORTIFS
USING (pays); 

/*LesEquipes*/
INSERT INTO LesEquipes(idEquipe,categorie)  
SELECT NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;

/*LesParticipants - Equipe*/
INSERT INTO lesParticipants(idParticiapant,pays)
select NS,pays
from INISPORTIFSEQ
USING (pays);

        
