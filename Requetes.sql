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

-- 08/12/2022 matin
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
begin tran
update villes_france_free set ville_nom = replace(ville_nom,'-',' ') where upper(ville_nom) like 'SAINT-%';

-- Optimisation requête n°10 
select * from (select d.departement_nom, vff.ville_departement, sum(ville_population_2012) as 'Nb_habitants_2012' from villes_france_free vff inner join departement d on vff.ville_departement = d.departement_code group by vff.ville_departement) v where v.Nb_habitants_2012 > 2000000;

-- 08/12/2022 ap midi
create database if not exists `commande` character set utf8 COLLATE `utf8_general_ci`;
use commande;

select * from client;
select * from commande;
select * from commande_ligne;

-- 1
select * from client where upper(prenom) like 'MURIEL' and password = sha1('test11'); 
-- 2
select nom, count(1) from commande_ligne group by nom having count(1) > 1 order by count(1) desc;
-- 3
select nom, group_concat(commande_id SEPARATOR '-') as 'liste des commandes', count(1) as 'Nbre commandes' from commande_ligne group by nom having count(1) > 1;
-- 4
update commande_ligne set prix_total = cast(prix_unitaire*quantite as float);
select * from commande_ligne;
-- 5
select cli.prenom, cli.nom, c.date_achat, cl.commande_id, concat(round(sum(prix_total),2),' €') from 
commande_ligne cl 
inner join commande c on cl.commande_id = c.id 
inner join client cli on cli.id = c.client_id 
group by cl.commande_id;
-- 6
-- Ne fonctionne pas !!!
update commande cmd set cache_prix_total = (
select sum(prix_total) from commande_ligne cl 
where cl.id = cmd.id);

-- Fonctionne !!!
update commande cmd 
inner join (select commande_id, sum(prix_total) as prix_total from commande_ligne group by commande_id) r 
on r.commande_id = cmd.id set cmd.cache_prix_total = r.prix_total;
-- select commande_id, sum(prix_total) as prix_total from commande_ligne group by commande_id;

select client_id, id as c_id,  (select sum(prix_total) from commande_ligne cl 
where cl.id = c_id) as 'sum(prix_total)' from commande;

select * from commande;
-- 7
select 
	case when month(date_achat) = 1 then 'Janvier'
    when month(date_achat) = 2 then 'Février'
    when month(date_achat) = 3 then 'Mars'
    when month(date_achat) = 4 then 'Avril'
    else 'OK Google' end as 'Mois achat',
    sum(cache_prix_total), group_concat(date_achat) from commande group by month(date_achat);
-- 8
select cli.nom, c.cache_prix_total from
commande c inner join client cli on c.client_id = cli.id order by c.cache_prix_total desc limit 10;
select * from commande order by client_id;

-- 11
alter table commande add column category int null;
update commande set category (
case when cache_prix_total < 200 then '1'
when cache_prix_total < 500 then '2'
when cache_prix_total < 1000 then '3'
else '4' end);

-- 12
delete from commande_ligne where date_achat < '2019-02-01';