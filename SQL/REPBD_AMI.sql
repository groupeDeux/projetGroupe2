INSERT INTO  LesSportifs 
SELECT NS, NOM, PRENOM, DATENAIS, CATEGORIE
FROM JO.LESSPORTIFS;

INSERT INTO LesEquipes  
SELECT NEQUIPE,CATEGORIE
FROM JO.LESSPORTIFSEQ;






