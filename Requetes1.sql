use allocine;
select * from categorie;

select * from categorie;
insert into film(titre, sousTitre, duree, synopsis, bandeAnnonce, idCategorie,idLangue, dateSortie)
values ('Fight Club','',120,'Une histoire de baston','',1,null,sysdate()),
('Le jouet','',120,'Une histoire de jouet','',1,null,sysdate()),
('Blanche Neige et les 7 mains','',120,'Une histoire de ...','',1,null,sysdate());
insert into film(titre) select concat(titre,', c''est mon cul') from film where id = 2;
delete from film;
delete from film where id in (2,3);
truncate film;

insert into categorie(libelle) values ('Thriller'),('Comédie');
commit

select f.titre, c.libelle from film f inner join categorie c on f.idCategorie = c.id;

select * from film;
update film set synopsis = 'Une histoire de mains' where id = 6;

alter table film drop column idLangue;
alter table film add column langue varchar(2) null;

insert into film values 
(null,'les tuches 3', '',120, 'une histoire de tuche', '', 4, '2010-10-10','fr'),
(null,'les tuches 4', 'fr', '2011-10-10', 9, 120, 'zedfrefergerg'),
(null,'les tuches 5', 'fr', '2010-11-10', 8, 120, 'zedfrefergerg'),
(null,'les tuches 6', 'fr', '2009-09-18', 9, 120, 'zedfrefergerg'),
(null,'les tuches 6', 'fr', '2010-09-18', 8, 120, 'zedfrefergerg'),
(null,'les tuches 6', 'fr', sysdate(), 9, 120, 'zedfrefergerg');
insert into film values 
(null,'les tuches 3', 'fr', '2010-10-10', 6, 120, 'zedfrefergerg'),
(null,'les tuches 4', 'fr', '2011-10-10', 9, 120, 'zedfrefergerg'),
(null,'les tuches 5', 'fr', '2010-11-10', 8, 120, 'zedfrefergerg'),
(null,'les tuches 6', 'fr', '2009-09-18', 9, 120, 'zedfrefergerg'),
(null,'les tuches 7', 'fr', '2010-09-18', 8, 120, 'zedfrefergerg'),
(null,'les tuches 8', 'fr', sysdate(), 9, 120, 'zedfrefergerg')
;

insert into film values 
(null,'les tuches 3', '',120, 'une histoire de tuche', '', 4, '2010-10-10','fr'),
(null,'les tuches 4', '',120, 'une histoire de tuche', '', 4, '2010-10-10','fr'),
(null,'les tuches 5', '',120, 'une histoire de tuche', '', 4, '2010-10-10','fr'),
(null,'les tuches 6', '',120, 'une histoire de tuche', '', 4, '2010-10-10','fr');

select * from film;
select * from film where dateSortie between '2010-01-01' and '2022-01-01';
select * from film where dateSortie between '2010-01-01' and '2022-01-01';

select * from film;

select titre, substring(titre,1,3) from film;
select * from film where upper(titre) like '%TU%';
select * from film;
select libelle, count(1) as `Nbre de films` from film f inner join categorie c on f.idCategorie = c.id group by libelle;
select titre,lpad(titre,3) from film;
select trim(trailing 'x' from 'xxxxxSYLVAINxx');
select trim(leading 'x' from 'xxxxxSYLVAINxx');
select trim(both 'x' from 'xxxxxSYLVAINxx');
select * from film where datediff(sysdate(), dateSortie) <1;
select DAYOFWEEK(dateSortie), dateSortie from film;
select now();
select cast(now() as date);
