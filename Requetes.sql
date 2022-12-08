CREATE TABLE `cinema` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255),
  `ville` varchar(255),
  `codePostal` varchar(5),
  `isOpen` boolean,
  `idGroupe` int
);

CREATE TABLE `groupe` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(255)
);

CREATE TABLE `cinemaFilm` (
  `cinemaId` int,
  `filmId` int
);

-- ALTER TABLE `film` ADD FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`);

ALTER TABLE `cinema` ADD FOREIGN KEY (`idGroupe`) REFERENCES `groupe` (`id`);
alter table `cinemaFilm` add constraint `FK_cinemaFilm_film` foreign key (filmId) references film(id);
alter table `cinemaFilm` add constraint `FK_cinemaFilm_cinema` foreign key (cinemaId) references cinema(id);
alter table `cinemaFilm` add constraint `UC_cinemaFilm` unique (filmId, cinemaId);

insert into groupe(libelle) values ('UGC'),('GAUMONT'),('PATHE');
insert into groupe(libelle) values ('INCONNU');

select * from groupe;
insert into cinema(nom, ville, codePostal, isOpen, idGroupe) values('UGC_Ciné_Cité', 'Paris', '75000', true, 1);

select * from cinema;

select * from film inner join categorie on film.idCategorie = categorie.id;
select film.titre, categorie.id from film left join categorie on film.idCategorie = categorie.id;
select * from film right join categorie on film.idCategorie = categorie.id;

update film set idCategorie = null where id = 6;

select * from film;
select * from categorie;
select * from cinema;
select * from cinemaFilm;
select * from groupe;

insert into cinemaFilm(cinemaId, filmId) values 
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11);

insert into cinemaFilm(cinemaId, filmId) values 
(2,5),
(2,7),
(2,10),
(2,11);

select f.titre, cf.cinemaId from film f inner join cinemaFilm cf on f.id = cf.filmId and cf.cinemaId = 1;

select 
	f.titre as 'titre film', 
	-- ca.libelle, 
	-- cf.cinemaId, 
	c.nom as 'nom cinéma',
    g.libelle as 'groupe'
from 
	film f 
	
    -- inner join categorie ca on ca.id = f.idCategorie
	inner join cinemaFilm cf on f.id = cf.filmId
	inner join cinema c on c.id = cf.cinemaId
    inner join groupe g on g.id = c.idGroupe and c.idGroupe = 1;

select * from groupe;
select * from categorie;
select * from cinema;

select langue from film;
select langue, count(*) from film;

-- 08/12/2022
create database if not exists `ville` character set utf8 COLLATE `utf8_general_ci`;

use ville;
select * from villes_france_free;
select * from departement;

select ville_nom, ville_population_2012 from villes_france_free order by ville_population_2012 desc limit 10;
select ville_nom, ville_surface from villes_france_free order by ville_surface asc limit 50;
select * from departement where departement_code like '97%';
select vff.ville_nom, vff.ville_departement, d.departement_nom, vff.ville_population_2012 from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code order by ville_population_2012 desc limit 10;
select d.departement_nom, vff.ville_departement, count(1) as 'Nombre de communes' from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code group by vff.ville_departement order by count(1) desc;
select d.departement_nom, vff.ville_departement, sum(ville_surface) as 'Surface' from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code group by vff.ville_departement order by sum(ville_surface) desc limit 10;
select count(ville_nom) from villes_france_free where upper(ville_nom) like 'SAINT%';
select ville_nom, count(ville_nom) from villes_france_free group by ville_nom having count(ville_nom) > 1 order by count(ville_nom) desc;
select ville_nom, ville_surface from villes_france_free where ville_surface > (select avg(ville_surface) from villes_france_free) order by ville_surface asc;
select d.departement_nom, vff.ville_departement, sum(ville_population_2012) as 'Nb habitants' from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code group by vff.ville_departement having sum(ville_population_2012) > 2000000 order by sum(ville_population_2012) desc;
select ville_nom, replace(ville_nom,'-',' ') from villes_france_free where upper(ville_nom) like 'SAINT-%';

-- Optimisation requête n°10 
select * from (select d.departement_nom, vff.ville_departement, sum(ville_population_2012) as 'Nb_habitants_2012' from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code group by vff.ville_departement) v where v.Nb_habitants_2012 > 2000000;