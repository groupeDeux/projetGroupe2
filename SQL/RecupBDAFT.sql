Insert into Epreuve
    select nepreuve, nome, discipline, categorie,(dateepr+(8/24)), (dateepr+(17/24)), 'NULL',50,100
    from lesepreuves;

insert into EpreuveIndividuelle
    select numEpreuve

insert into delegation
    select distinct pays
    from lessportifs
    