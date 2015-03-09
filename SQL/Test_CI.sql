/*------------------------------------------------------------------*/
/*----- Comparaison nombre n-uplets initial nombre n-uplets charges*/
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
select count( distinct Nequipe) from iniSportifsEq;
select count(idParticipant) from lesParticipants where (idParticipant<1000);
 
/*LesSportifs*/
select count(*) from lesSportifs;
select count(*) from IniSportifs where categorie is not null;
 

/*LesEquipes*/
select count(*) from lesEquipes;
select count(distinct nequipe) 
from IniSportifsEq 
where nequipe is not null; 


/*LesConstitutionEquipes*/
select count(*) from lesConstitutionsEquipe;
select count(*) 
from IniSportifsEq 
where nequipe is not null;

/*LesEpreuves*/
select count(*) from IniEpreuves;
select count(*) from lesEpreuves;


/*LesEpreuvesIndividuelles*/
select count(*) from IniEpreuves where forme='individuelle';
select count(*) from lesEpreuvesIndividuelles;

/*LesEpreuvesParEquipe*/
select count(*) from IniEpreuves where forme='par equipe';
select count(*) from lesEpreuvesParEquipe;

/*LesParticipations - sportifs*/
select count(*) from IniInscriptionsSportifs where nepreuve is not null;
select count(*) from lesParticipations where idParticipant>1000;

/*LesParticipations - equipe*/
select count(*) from IniInscriptionsEquipes where nepreuve is not null;
select count(*) from lesParticipations where idParticipant<1000;

/*------------------------------------------------------------------*/
/*----- Test contraintes d'integrite*/

/* L'attribut NS de la table IniSportifs est clé? */
Select count(distinct(NS)) from IniSportifs;
Select count(NS) from IniSportifs;

/* nom, prenom est unique */
select count(*)
from IniSportifs S1
join IniSportifs S2
on (S1.nom=S2.nom and S1.prenom=S2.nom)
where(S1.NS<>S2.NS);

select distinct nom,prenom
from IniSportifs;
select nom,prenom
from Inisportifs;  

/* Les sportifs ont tous une categorie? */
Select count(*) 
from IniSportifs 
where categorie is null;

/* Les Sportifs de IniSportifsEq sont tous associes a une equipe?*/
select count(*) 
from iniSportifsEq 
where Nequipe is null;

/* Les Sportifs d'une meme equipe sont du meme pays? */
select count(Nequipe) 
from IniSportifsEq S1
join IniSportifsEq S2
using (Nequipe)
where (S1.pays <> S2.pays);

/* Les Sportifs d'une meme chambre sont de meme genre? */
select count(S1.NS) 
from IniLogementsInit L1
join IniSportifs S1
using (nom,prenom)
join IniSportifs S2
using(nom,prenom)
where (S1.categorie<>S2.categorie);


/* Le nombre de sportifs dans une chambre est inferieur a la capacite de celle-ci? */
Select NLogement,nbPersonnes,capacite
from (
    select NLogement, count (*) as nbPersonnes, capacite
    from IniLogementsInit
    group by NLogement,nomBat,capacite) R1
where (nbPersonnes>capacite);


/* Un sportif n'est attribue qu a une seule chambre? */
select count(*)
from IniLogementsInit L1
join IniLogementsInit L2
on (L1.nom=L2.nom and L1.prenom=L2.prenom)
where (L1.Nlogement<>L2.nLogement);


/*NEpreuves est clé?*/
select count(*) from IniEpreuves;
select count(distinct nepreuve) from IniEpreuves;

/*Attributs Nepreuves, nomE, discipline et categorie sont non null */
select count(nepreuve) from iniEpreuves where Nepreuve is null;
select count(nepreuve) from iniEpreuves where nomE is null;
select count(nepreuve) from iniEpreuves where Discipline is null;
select count(nepreuve) from iniEpreuves where categorie is null;

/*La forme des épreuves est soit 'individuelle' soit 'par equipe'?*/
select nepreuve 
from iniEpreuves 
where (forme<> 'individuelle' and forme <> 'par equipe');

/* Un sportif dans IniInscriptionsSpirtifs est toujours inscrit à une épreuve?*/
SELECT count(*)
FROM IniInscriptionsSportifs
WHERE nEpreuve is null;

/* Une équipe dans IniInscriptionsEquipes est toujours inscrite à une épreuve?*/
SELECT count(*)
FROM IniInscriptionsEquipes
WHERE nEpreuve is null;

/* Un sportif inscrit à une épreuve est de meme catégorie que l'épreuve?*/
 SELECT count(E.nepreuve)
    FROM IniInscriptionsSportifs I
    JOIN IniSportifs S
    ON(I.nom=S.nom and I.prenom=S.prenom)
    JOIN IniEpreuves E
    ON (I.NEpreuve=E.NEpreuve)
    WHERE (S.categorie<>E.categorie);

/* Une équipe inscrite à une épreuve est de meme catégorie que l'épreuve?*/
 SELECT count(E.NEPREUVE)
    FROM IniInscriptionsEquipes I
    JOIN LesEquipes Eq
    ON (I.NI=Eq.idEquipe)
    JOIN IniEpreuves E
    ON (I.NEpreuve=E.NEpreuve)
    WHERE (Eq.categorie<>E.categorie);

/* Les épreuves de IniInscriptionsSportifs sont de forme 'individuelle'? */
SELECT count(E.nepreuve)
    FROM IniInscriptionsSportifs I
    JOIN IniEpreuves E
    ON (I.NEpreuve=E.NEpreuve)
    WHERE (forme<>'individuelle');

/* Les épreuves de IniInscriptionsEquipes sont de forme 'par equipe'? */
SELECT count(E.nepreuve)
    FROM IniInscriptionsEquipes I
    JOIN IniEpreuves E
    ON (I.NEpreuve=E.NEpreuve)
    WHERE (forme<>'par equipe');

/* Les sportifs ne sont inscrit qu'une seule fois à une même épreuve? */
Select *
    from select count(nIniInscriptionsSportifs I1
    on (I1.Nepreuve=I2.Nepreuve)
    where (I1.nom=I2.nom and I1.prenom=I2.PRENOM); 
  

/*---------------------------------------------------------------------------*/
/* ----- Recuperation des donnees exclues lors du chargement dans nos tables */ 

SELECT nom, prenom,pays,categorie,datenais,nequipe
FROM iniSportifsEq
WHERE Nequipe is null
ORDER BY PAYS, NOM;

Select *
from IniLogementsInit
where (Nlogement=104 or nlogement=105 or nlogement=211)
order by nlogement;

select * from iniEpreuves where categorie is null;