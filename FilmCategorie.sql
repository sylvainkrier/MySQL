create database if not exists `allocine` character set utf8 COLLATE `utf8_general_ci`;

CREATE TABLE `film` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `titre` varchar(255),
  `sousTitre` varchar(255),
  `duree` int,
  `synopsis` varchar(255),
  `bandeAnnonce` varchar(255),
  `idCategorie` int,
  `idLangue` int,
  `dateSortie` date
);

CREATE TABLE `categorie` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(255)
);

ALTER TABLE `film` ADD FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`);
