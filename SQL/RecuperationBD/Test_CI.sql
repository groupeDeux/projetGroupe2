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

/*LesMedailles - sportifs*/
select count(*)
from IniResultatsSportifs;
Select count(*)/3
from LesMedailles
where idParticipant>1000;

/*LesMedailles - equipes*/
select count(*)
from IniResultatsEquipes;
Select count(*)/3
from LesMedailles
where idParticipant<1000;
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

/* Les Sportifs d'une meme chambre sont de meme genre? */
select count(S1.NS) 
from IniLogementsInit L1
join IniSportifs S1
using (nom,prenom)
join IniSportifs S2
using(nom,prenom)
where (S1.categorie<>S2.categorie);

/* Les Sportifs d'une meme chambre sont du meme pays? */
select count(S1.NS) 
from IniLogementsInit L1
join IniSportifs S1
using (nom,prenom)
join IniSportifs S2
using(nom,prenom)
where (S1.pays<>S2.pays);

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


/* Les Sportifs de IniSportifsEq sont tous associes a une equipe?*/
select count(*) 
from iniSportifsEq 
where Nequipe is null;

/* Les Equipes non vides contiennent au moins deux sportifs ?*/
select count(*)
from (select count(*) as nbInscrits
    from iniSportifsEq 
    where Nequipe is not null
    group by Nequipe)R1
where nbInscrits<2;

/* Les Sportifs d'une meme equipe sont du meme pays? */
select count(Nequipe) 
from IniSportifsEq S1
join IniSportifsEq S2
using (Nequipe)
where (S1.pays <> S2.pays);


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

/* Les sportifs ne sont inscrits qu'une seule fois à une même épreuve? */
Select count(*)
from (select nepreuve,count(*) as nbI
        from IniInscriptionsSportifs
        group by(nom,prenom,Nepreuve))R1
where nbI>1;

/* Les équipes ne sont inscrites qu'une seule fois à une même épreuve? */
Select count(*)
from (select nepreuve,count(*) as nbI
        from IniInscriptionsEquipes
        group by(ni,Nepreuve))R1
where nbI>1;

/* Lorsque NBS est non null le nombre de sportifs participant à cette épreuve est le meme? */

select count(*)
from IniEpreuves Epreuves
join
    (Select count(*) as NbInscritEquipe, Ep.NEPREUVE, S.NEQUIPE
    from IniEpreuves Ep
    join IniInscriptionsEquipes Eq
    on (Ep.NEPREUVE=Eq.Nepreuve)
    join IniSportifsEq S
    on (S.Nequipe=Eq.Ni)
    where NBS is not null
    group by S.Nequipe, Ep.Nepreuve)R1
on(R1.Nepreuve=Epreuves.Nepreuve)
where NbInscritEquipe <> NBS;

select count (*)
from IniEpreuves E
join IniInscriptionsEquipes I
on (E.nepreuve=I.nepreuve)
where nBS is not null;

/* Les sportifs qui recoivent une médaille pour une épreuve sont inscrit à cette épreuve? */  
Select I.nom, I.prenom, I.nepreuve
from IniInscriptionsSportifs I
LEFT OUTER join IniResultatsSportifs R
on ((I.nom=R.nomOr and I.prenom=R.prenomOr) or (I.nom=R.nomAr and I.prenom=R.prenomAr) or (I.nom=R.nomBr and I.prenom=R.prenomBr))
    minus
select nom, prenom, nepreuve
from iniInscriptionsSportifs;


/* Les equipes qui recoivent une médaille pour une épreuve sont inscrit à cette épreuve? */  
Select E.ni,E.nepreuve
from IniInscriptionsEquipes E
LEFT OUTER join IniResultatsEquipes R
on (E.NI=R.Gold or E.Ni=R.Silver or E.ni=R.bronze)
    minus
select ni, nepreuve
from iniInscriptionsEquipes;


/* Les sportifs qui recoivent une médaille pour une épreuve donnée sont distinct deux à deux? */ 
select count(*)
from IniResultatsSportifs R1
join IniResultatsSportifs R2
on (R1.Nepreuve=R2.nepreuve)
where((R1.nomOr=R2.nomAr and R1.prenomOr=R2.prenomAr) or (R1.nomAr=R2.nomBr and R1.prenomAr=R2.prenomBr) or (R1.nomBr=R2.nomOr and R1.prenomBr=R2.prenomOr));

/* Les sportifs qui recoivent une médaille pour une épreuve donnée sont distinct deux à deux? */ 
select count(*)
from IniResultatsEquipes R1
join IniResultatsEquipes R2
on (R1.Nepreuve=R2.nepreuve)
where(R1.Gold=R2.Silver or R1.Gold=R2.Bronze or R1.silver=R2.bronze);

/* Une seule médaille de chaque valeur est attribuée pour une épreuve individuelle */ 
select count(nepreuve)from IniResultatsSportifs;
select count(distinct nepreuve) from IniResultatsSportifs;

/* Une seule médaille de chaque valeur est attribuée pour une épreuve par equipe */ 
select count(nepreuve)from IniResultatsEquipes;
select count(distinct nepreuve) from IniResultatsEquipes;


/*---------------------------------------------------------------------------*/
/* ----- Recuperation des donnees exclues lors du chargement dans nos tables */ 

/* Les sportifs dans IniSportifsEq pour lesquels l'équipe n'est pas renseignée*/
SELECT nom, prenom,pays,categorie,datenais,nequipe
FROM iniSportifsEq
WHERE Nequipe is null
ORDER BY PAYS, NOM;

/* Les épreuves pour lesquelles la catégorie n'est pas renseignée*/
select * from iniEpreuves where categorie is null;

/* Les sportifs dans IniInscriptionsSportifs pour lesquels l épreuve n'est pas renseignée */
SELECT *
FROM IniInscriptionsSportifs
WHERE nEpreuve is null;

/*Les sportifs dans IniInscriptionSportifs qui ne sont pas inscrits dans IniSportifs*/
/*--> ils sont cependant inscrits dans IniLogementsInit voir requete suivante*/
select *
from
    (select nom, prenom
    from IniInscriptionsSportifs I
        minus
    select nom, prenom
    from INiSportifs S)R1
join IniInscriptionsSportifs
using(nom,prenom);

/*Les sportifs dans IniInscriptionSportifs qui ne sont pas inscrits dans IniLogementInit*/
/* On peut les inscrire manuellement dans lesSportifs*/
select *
from
    (select nom, prenom
    from IniInscriptionsSportifs I
        minus
    select nom, prenom
    from INiLogementsInit L)R1
    join IniInscriptionsSportifs
using(nom,prenom);
				