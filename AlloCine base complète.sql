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
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `categorie` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(255),
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `langue` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `libelle` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `filmActeur` (
  `idFilm` int,
  `idActeur` int,
  PRIMARY KEY (`idFilm`, `idActeur`)
);

CREATE TABLE `filmRealisateur` (
  `idFilm` int,
  `idRealisateur` int,
  PRIMARY KEY (`idFilm`, `idRealisateur`)
);

CREATE TABLE `filmCinema` (
  `idFilm` int,
  `idCinema` int,
  PRIMARY KEY (`idFilm`, `idCinema`)
);

CREATE TABLE `filmProducteur` (
  `idFilm` int,
  `idProducteur` int,
  PRIMARY KEY (`idFilm`, `idProducteur`)
);

CREATE TABLE `acteur` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `idFilm` int,
  `nom` varchar(255),
  `prenom` varchar(255),
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `realisateur` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255),
  `prenom` varchar(255),
  `dateNaissance` datetime,
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `producteur` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255),
  `prenom` varchar(255),
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `cinema` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `idFilm` int,
  `nom` varchar(255),
  `nombrePlaces` int,
  `adresse` varchar(255),
  `created at` varchar(255),
  PRIMARY KEY (`id`)
);

CREATE TABLE `seance` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `idCinema` int,
  `idFilm` int,
  `debut` varchar(255),
  `fin` varchar(255),
  `created at` varchar(255),
  PRIMARY KEY (`id`, `idCinema`, `idFilm`)
);

ALTER TABLE `filmRealisateur` ADD FOREIGN KEY (`idFilm`) REFERENCES `film` (`id`);

ALTER TABLE `filmRealisateur` ADD FOREIGN KEY (`idRealisateur`) REFERENCES `realisateur` (`id`);

ALTER TABLE `filmActeur` ADD FOREIGN KEY (`idFilm`) REFERENCES `film` (`id`);

ALTER TABLE `filmProducteur` ADD FOREIGN KEY (`idFilm`) REFERENCES `film` (`id`);

ALTER TABLE `producteur` ADD FOREIGN KEY (`id`) REFERENCES `filmProducteur` (`idProducteur`);

ALTER TABLE `film` ADD FOREIGN KEY (`idLangue`) REFERENCES `langue` (`id`);

ALTER TABLE `filmCinema` ADD FOREIGN KEY (`idFilm`) REFERENCES `film` (`id`);

ALTER TABLE `cinema` ADD FOREIGN KEY (`id`) REFERENCES `filmCinema` (`idCinema`);

ALTER TABLE `filmActeur` ADD FOREIGN KEY (`idActeur`) REFERENCES `acteur` (`id`);

ALTER TABLE `seance` ADD FOREIGN KEY (`idFilm`) REFERENCES `filmCinema` (`idFilm`);

ALTER TABLE `seance` ADD FOREIGN KEY (`idCinema`) REFERENCES `filmCinema` (`idCinema`);

ALTER TABLE `film` ADD FOREIGN KEY (`idCategorie`) REFERENCES `categorie` (`id`);
