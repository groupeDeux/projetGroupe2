insert into lesParticipants values (1,'yemen');
insert into lesParticipants values (2,'france');
insert into lesParticipants values (3,'danemark');
insert into lesParticipants values (4,'USA');
insert into lesParticipants values (8,'perou');
insert into lesParticipants values (5,'perou');
insert into lesParticipants values (6,'perou');
insert into lesParticipants values (7,'perou');

insert into LESEPREUVES(IDEPREUVE,NOMEPREUVE,NOMDISCIPLINE,CATEGORIE,DATEDEBUT,DATEFIN,TARIF,NBDEPLACE) values
(1,'coucou1','dis1','mixte',TO_DATE('2003/07/09 09', 'yyyy/mm/dd HH24'), TO_DATE('2003/07/09 12', 'yyyy/mm/dd HH24'),11,100);
insert into LESEPREUVES(IDEPREUVE,NOMEPREUVE,NOMDISCIPLINE,CATEGORIE,DATEDEBUT,DATEFIN,TARIF,NBDEPLACE) values
(2,'coucou2','dis1','mixte',TO_DATE('2003/07/09 09', 'yyyy/mm/dd HH24'), TO_DATE('2003/07/09 11', 'yyyy/mm/dd HH24'),11,100);

insert into LESEPREUVESPAREQUIPE(IDEPREUVE,NBPERSONNEFIXE) values (1,12);
insert into LESEPREUVESPAREQUIPE(IDEPREUVE,NBPERSONNEFIXE) values (2,14);

insert into lesEquipes values (5,equipePerou,'mixte');
insert into lesSportifs values (1,jean,dupont,TO_DATE('2003/07/09 09', 'yyyy/mm/dd'),masculin,
insert into lesConsitutionEquipe values (5,6);
insert into lesConsitutionEquipe values (5,7);
insert into lesConsitutionEquipe values (5,8);