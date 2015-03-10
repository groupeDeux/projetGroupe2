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


/*---------- En attente données correctes pour les dates de naissances ----
/*LesParticipants - Sportifs
Présents dans IniInscriptionsSportifs et IniLogementsInit et pas dans IniSportifs*/

/*recup données*/
select nom, prenom, I2.datenais, I2.categorie, L.nLogement, L.nombat
from 
    (select nom, prenom
    from IniInscriptionsSportifs I
        minus
    select nom, prenom
    from INiSportifs S)R1
join IniInscriptionsSportifs I2
using(nom,prenom)
join IniLogementsInit L
using(nom,prenom);
/* max id de la tables les Sportifs pour connaitre l'identifiant à donner*/
Select max(idSportif)
from LesSportifs;
/* insert n-uplet par n-uplet avec info requete et max(id)*/
INSERT INTO LesSportifs 
VALUES (1309,'GRENIER','Thierry','2071-10-15 00:00:00.000','masculin','null','102','Rembrandt');
/*-----------------------------------------------------------------------------------------------*/


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

/*LesConstitutionsEquipes*/
INSERT INTO LesConstitutionsEquipe(idEquipe,idSportif)
    SELECT nequipe, NS
    FROM iniSportifsEq E
    JOIN iniSportifs S
    ON (E.nom=S.nom and E.prenom=S.prenom)
    WHERE (NEquipe is not null);

/*LesEpreuves*/
INSERT INTO LesEpreuves(idEpreuve,nomEpreuve,nomDiscipline,categorie,dateDebut,dateFin)
    SELECT nEpreuve,nomE,discipline,categorie,(dateEpr+(8/24)),(dateEpr+(17/24))
    FROM IniEpreuves
    WHERE categorie is not null;

INSERT INTO LesEpreuves(idEpreuve,nomEpreuve,nomDiscipline,categorie,dateDebut,dateFin)
    SELECT nEpreuve,nomE,discipline,'mixte',(dateEpr+(8/24)),(dateEpr+(17/24))
    FROM IniEpreuves
    WHERE categorie is null;

/*LesEpreuvesIndividuelles*/        
INSERT INTO LesEpreuvesIndividuelles(idEpreuve)
    SELECT nepreuve 
    FROM iniEpreuves
    WHERE (forme='individuelle');

/*LesEpreuvesParEquipe*/
INSERT INTO LesEpreuvesParEquipe(idEpreuve,nbPersonneFixe)
    SELECT nepreuve, NBS
    FROM iniEpreuves
    WHERE ((forme='par equipe') and NBS is not null);

/*LesParticipations*/
/* participations-sportifs (que si nepreuve non null)*/
INSERT INTO LesParticipations(idEpreuve,idParticipant)
    SELECT nepreuve,NS
    FROM IniInscriptionsSportifs I
    JOIN IniSportifs S
    ON(I.nom=S.nom and I.prenom=S.prenom)
    WHERE nEpreuve is not null;

/* participations-equipe (que si nepreuve non null)*/
INSERT INTO LesParticipations(idEpreuve,idParticipant)
    SELECT nepreuve,Ni
    FROM IniInscriptionsEquipes
    WHERE nEpreuve is not null;

/*LesMedailles - Equipes*/
INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nepreuve,gold,'or'
    FROM IniResultatsEquipes;

INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nepreuve,silver,'argent'
    FROM IniResultatsEquipes;

INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nepreuve,bronze,'bronze'
    FROM IniResultatsEquipes;


/*LesMedailles - Sportifs*/
INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nEpreuve,NS,'or'
    FROM IniResultatsSportifs R
    JOIN IniSportifs S
    ON (R.nomOr=S.nom and R.prenomOr=S.prenom);

INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nEpreuve,NS,'argent'
    FROM IniResultatsSportifs R
    JOIN IniSportifs S
    ON (R.nomAr=S.nom and R.prenomAr=S.prenom);

INSERT INTO LesMedailles(idEpreuve,idParticipant,valeur)
    SELECT nEpreuve,NS,'bronze'
    FROM IniResultatsSportifs R
    JOIN IniSportifs S
    ON (R.nomBr=S.nom and R.prenomBr=S.prenom);