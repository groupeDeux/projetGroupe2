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
where nequipe is not null and categorie is not null;




/*------------------------------------------------------------------*/
/*----- Test contraintes d'integrite*/

/* L'attribut NS de la table IniSportifs est clé? */
Select count(distinct(NS)) from IniSportifs;
Select count(NS) from IniSportifs;

/* Les sportifs ont tous une categorie? */
Select count(*) 
from IniSportifs 
where categorie is null;

/* Les Sportifs de IniSportifsEq sont tous associes a une equipe?*/
select count(*) 
from iniSportifsEq 
where Nequipe is null;

/* Les Sportifs d'une meme equipe sont du meme pays? */
select (Nequipe) 
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
    group by NLogement,capacite) R1
where (nbPersonnes>capacite);


/* Un sportif n'est attribue qu a une seule chambre? */

select count(*)
from IniLogementsInit L1
join IniLogementsInit L2
on (L1.nom=L2.nom and L1.prenom=L2.prenom)
where (L1.Nlogement<>L2.nLogement);




/*---------------------------------------------------------------------------*/
/* ----- Recuparation des donnees exclues lors du chargement dans nos tables */ 

SELECT nom, prenom,pays,categorie,datenais,nequipe
FROM iniSportifsEq
WHERE Nequipe is null
ORDER BY PAYS, NOM;

Select *
from IniLogementsInit
where (Nlogement=104 or nlogement=105 or nlogement=211)
order by nlogement;