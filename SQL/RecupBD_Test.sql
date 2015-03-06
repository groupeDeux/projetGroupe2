/*LesBatiments --> valide*/
INSERT INTO LesBatiments (nomBatiment, numRue,rue,ville)
select distinct (NOMBAT),NUMERO,RUE,VILLE
FROM INILOGEMENTSINIT;

select count(nomBatiment) from Lesbatiments;
Select count(distinct NomBat) from InilogementsInit;


/*LesChambres --> valide*/

INSERT INTO LesChambres (numChambre,nomBatiment, capacite)
select distinct NLOGEMENT,NOMBAT,CAPACITE
FROM INILOGEMENTSINIT;


Select count(distinct(Nlogement)) from IniLogementsInit;
Select count (distinct (numChambre)) from LesChambres;

select sum(nbChambre) from 
    (select count(numChambre) as nbChambre from LesChambres group by nomBatiment)R1;

select sum(nbChambre) from 
    (select count(distinct Nlogement) as nbChambre from InilogementsInit group by nomBat)R1;



/*LesParticipants - Sportifs*/


INSERT INTO lesParticipants(idParticipant,pays)
select NS,pays
from INISPORTIFS; 


Select count(distinct(NS)) from IniSportifs;
Select count(NS) from IniSportifs;

Select count(*) from IniSportifs;
Select count(*) from LesParticipants;

Select pays,NbSportifsParPaysIni,NbSportifsParPays 
from (Select pays, count(NS) as NbSportifsParPaysIni 
        from IniSportifs
        group by pays)R1
join (Select pays, count(idParticipant) as NbSportifsParPays
        from LesParticipants
        group by pays)R2
using (pays)
where (NbSportifsParPaysIni<>NbSportifsParPays);


/*LesParticipants - Equipe*/

INSERT INTO lesParticipants(idParticipant,pays)
    select distinct (NEquipe),pays
    from INISPORTIFSEQ
    where NEquipe is not null;

select count(idParticipant) from lesParticipants where (idParticipant<1000);
select count( distinct Nequipe) from iniSportifsEq where Nequipe is not null;

 
/*LesSportifs*/
INSERT INTO  LesSportifs(idSportif,nom, prenom,dateNaissance,genre,numChambre,nomBatiment) 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE, NLOGEMENT, NOMBAT
FROM INISPORTIFS
    JOIN INILOGEMENTSINIT
    USING(NOM,PRENOM)
where categorie is not null;

select count(*) from lesSportifs;
select count(*) from IniSportifs;   




/*LesEquipes*/



/*
Create view viewCategorie as
    SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe,categorie

    Select Nequipe,categorie 
    from    (SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe,categorie
            having (1 in (select count(categorie) 
                        from (SELECT NEQUIPE,CATEGORIE
                                FROM INISPORTIFSEQ
                                where (NEquipe is not null and Categorie is not null)
                                group by Nequipe,categorie)R1
                        group by(Nequipe))R2)
            order by nequipe)R3; */

/* insert des equipe mixte count(distinct categorie) = 1 
R1: recuperation nequipe et categorie par nequipe et categorie 
R2: recuperation nequipe des equipe qui contiennent des sportifs de meme categorie*/
INSERT INTO LesEquipes(idEquipe,categorie)  
Select Nequipe,categorie 
    from  (SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe,categorie)R1
    join   (SELECT NEQUIPE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe
            having count( distinct categorie)=1)R2
    using (Nequipe);

/* insert des equipe mixte count(distinct categorie) = 2 */
INSERT INTO LesEquipes(idEquipe,categorie) 
Select distinct Nequipe,'mixte' as categorie
    from  (SELECT NEQUIPE,CATEGORIE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe,categorie)R1
    join   (SELECT NEQUIPE
            FROM INISPORTIFSEQ
            where (NEquipe is not null and Categorie is not null)
            group by Nequipe
            having count(distinct categorie)=2)R2
    using (Nequipe);


select count(*) from lesEquipes;

select count(distinct nequipe) 
from IniSportifsEq 
where nequipe is not null and categorie is not null; 

/*LesConstitutionEquipes*/

INSERT INTO LesConstitutionsEquipe(idEquipe, idSportif)
    Select NEquipe, NS
    from iniSportifs
    join iniSportifsEq
    using (nom,prenom)
    where (Nequipe is not null and inisportifs.categorie is not null);

/* VERIF AVEC SELECT*/
