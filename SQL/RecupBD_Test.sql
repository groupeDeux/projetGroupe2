/*LesBatiments --> valide*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
    SELECT DISTINCT (NOMBAT),NUMERO,RUE,VILLE
    FROM INILOGEMENTSINIT;

select count(nomBatiment) from Lesbatiments;
Select count(distinct NomBat) from InilogementsInit;


/*LesChambres --> valide*/
INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
    SELECT DISTINCT NLOGEMENT,NOMBAT,CAPACITE
    FROM INILOGEMENTSINIT;

Select count(distinct(Nlogement)) from IniLogementsInit;
Select count (distinct (numChambre)) from LesChambres;


/*LesParticipants - Sportifs*/
INSERT INTO lesParticipants(idParticipant,pays)
    SELECT NS,pays
    FROM INISPORTIFS;

Select count(*) from IniSportifs;
Select count(*) from LesParticipants;

Select pays,NbSportifsParPaysIni,NbSportifsParPays 
from (Select pays, count(NS) as NbSportifsParPaysIni 
        from IniSportifs
        group by pays)R1
join (Select pays, count(idParticipant) as NbSportifsParPays
        from LesParticipants
        where (idParticipant > 1000)
        group by pays)R2
using (pays)
where (NbSportifsParPaysIni<>NbSportifsParPays);


/*LesParticipants - Equipe*/
INSERT INTO lesParticipants(idParticipant,pays)
    SELECT DISTINCT (NEquipe),pays
    FROM INISPORTIFSEQ
    WHERE NEquipe is not null;

select count( distinct Nequipe) from iniSportifsEq;
select count(idParticipant) from lesParticipants where (idParticipant<1000);


 
/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
    SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
    FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM)
    WHERE categorie is not null;

select count(*) from lesSportifs;
select count(*) from IniSportifs where categorie is not null;   


/*LesEquipes*/

/* insert des equipe mixte count(distinct categorie) = 1 
R1: recuperation nequipe et categorie par nequipe et categorie 
R2: recuperation nequipe des equipe qui contiennent des sportifs de meme categorie*/
INSERT INTO LesEquipes(idEquipe,categorie)  
SELECT Nequipe,categorie 
    FROM  (SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            WHERE (NEquipe is not null and Categorie is not null)
            GROUP BY Nequipe,categorie)R1
    JOIN   (SELECT NEQUIPE
            FROM INISPORTIFSEQ
            WHERE (NEquipe is not null and Categorie is not null)
            GROUP BY Nequipe
            HAVING COUNT( distinct categorie)=1)R2
    USING (Nequipe);

/* insert des equipe mixte count(distinct categorie) = 2 */
INSERT INTO LesEquipes(idEquipe,categorie) 
SELECT DISTINCT Nequipe,'mixte' as categorie
    FROM  (SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            WHERE (NEquipe is not null and Categorie is not null)
            GROUP BY Nequipe,categorie)R1
    JOIN   (SELECT NEQUIPE
            FROM INISPORTIFSEQ
            WHERE (NEquipe is not null and Categorie is not null)
            GROUP BY Nequipe
            HAVING COUNT(distinct categorie)=2)R2
    USING (Nequipe);


select count(*) from lesEquipes;

select count(distinct nequipe) 
from IniSportifsEq 
where nequipe is not null; 


/*LesConstitutionEquipes*/
INSERT INTO LesConstitutionsEquipe(idEquipe, idSportif)
    SELECT NEquipe, NS
    FROM iniSportifs
    JOIN iniSportifsEq
    USING (nom,prenom)
    WHERE (Nequipe is not null);

select count(*) from lesConstitutionsEquipe;

select count(*) 
from IniSportifsEq 
where nequipe is not null and categorie is not null;
