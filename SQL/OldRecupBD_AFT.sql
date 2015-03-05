
/* -------------- COTE PARTICIPANTS ---------------

/* LesDelegations*/
Insert INTO LesDelegations (pays)
select distinct PAYS
FROM INISPORTIFS;

/*LesBatiments*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select NOMBAT,NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

/* LesChambres*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;

/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT SeqParticipants.next, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM);

/*LesEquipes*/
INSERT INTO LesEquipes(idEquipe,nomEquipe,categorie)  
SELECT SeqParticipant.next,NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;

/*LesParticipants*//
INSERT INTO lesParticipants(idParticipant,idDelegation)
select idSportifs,idDelegation
from INISPORTIFS
JOIN LesDelegations
USING (pays)
join LesSportifs
using(nom,prenom,dateNaissance);

/* -------------- COTE EPREUVES ---------------

/*LesEpreuvesIndividuelles*/
INSERT INTO LesEpreuvesIndividuelles(idEpreuve)  
SELECT SeqParticipant.next,NEQUIPE,CATEGORIE
FROM INISPORTIFSEQ;


/* Table LesSportif avec premier idParticipant disponible */
/*
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
        
