
insert into lesMedailles values(38,54,'or');
insert into lesMedailles values(38,55,'argent');
insert into lesMedailles values(38,15,'bronze');

DELETE FROM lesMedailles WHERE idEpreuve=38;


select * from lesEpreuves;

UPDATE lesEpreuves 
SET nbDePlace = 8
WHERE idEpreuve=41;

UPDATE lesEpreuves 
SET nbDePlace = 8
WHERE idEpreuve=24;





