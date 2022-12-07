CREATE TABLE `film` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `titre` varchar(255),
  `sousTitre` varchar(255),
  `duree` int,
  `synopsis` varchar(255),
  `bandeAnnonce` varchar(255),
  `idCategorie` int,
  `idLangue` int,
  `dateSortie` date,
  `created at` varchar(255)
);

CREATE TABLE `categorie` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(255),
  `created at` varchar(255)
);

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

ALTER TABLE `film` ADD FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`);

ALTER TABLE `cinema` ADD FOREIGN KEY (`idGroupe`) REFERENCES `groupe` (`id`);
